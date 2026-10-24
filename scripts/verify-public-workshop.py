"""Anonymous official metadata check after a verified content-only upload."""
from datetime import datetime,timezone
import hashlib,json
from urllib.parse import urlencode
from urllib.request import Request,urlopen
from workshop_upload import RELEASE,VDF,saved_id,read_as_steamcmd,write

item=saved_id()
page=json.loads((RELEASE/'page-verified.json').read_text('utf8'))
publication=json.loads((RELEASE/'publication.json').read_text('utf8'))
download=json.loads((RELEASE/'download-verified.json').read_text('utf8'))
assert publication['workshopId']==download['workshopId']==item
assert publication['steamcmdUploadConfirmed'] and publication['pagePreserved']
assert set(read_as_steamcmd(VDF.read_text('utf8')))=={'appid','publishedfileid','contentfolder','changenote'}
data=urlencode({'itemcount':1,'publishedfileids[0]':item}).encode()
request=Request('https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/',data=data)
with urlopen(request,timeout=45) as response:raw=json.load(response)
detail=raw['response']['publishedfiledetails'][0]
assert detail['result']==1 and str(detail['publishedfileid'])==item
assert detail['consumer_app_id']==108600 and detail['visibility']==0
assert detail['title']==page['title']=='ONLY KI5: Vehicle Spawn & Skins'
digest=lambda text:hashlib.sha256(text.replace('\r\n','\n').encode()).hexdigest()
expected_description=publication['descriptionSha256']
page_update=RELEASE/'page-update-verified.json'
if page_update.exists():
    latest=json.loads(page_update.read_text('utf8'))
    assert latest['workshopId']==item and latest['verified'] and latest['payloadUploadAttempted'] is False
    expected_description=latest['descriptionSha256']
assert digest(detail['description'])==expected_description==digest(page['description'])
desired=(RELEASE/'description.txt').read_text('utf-8-sig').strip()+'\n\nMod ID: OnlyKI5VehicleSpawnLiveryOverhaul'
assert digest(detail['description'])==digest(desired),'Live description differs from the requested source text'
assert 'https://steamcommunity.com/workshop/filedetails/?id=3652192243' in detail['description']
assert 'id=2490220997' not in detail['description']
assert str(detail['hcontent_file'])==download['manifest']
assert detail['preview_url']==page['cover']
stamp=datetime.now(timezone.utc).isoformat()
write(RELEASE/'public-web-verified.json',dict(verifiedUtc=stamp,workshopId=item,
 title=detail['title'],visibility=detail['visibility'],manifest=download['manifest'],
 descriptionSha256=digest(detail['description']),contentUploadDescriptionSha256=publication['descriptionSha256'],
 collectionLinkVerified='https://steamcommunity.com/workshop/filedetails/?id=3652192243' in detail['description'],
 crashSceneWordingVerified='Crashed cars too.' in detail['description'],
 officialPublicMetadataVerified=True,coverMatches=True,version=publication['version']))
write(RELEASE/'verification-status.json',dict(verifiedUtc=stamp,workshopId=item,
 steamcmdUploadConfirmed=True,officialDownloadMatches=True,visibilityConfigured=0,
 visibilityPublicApiVerified=True,descriptionVerifiedAgainstUpload=expected_description==publication['descriptionSha256'],
 descriptionVerifiedAgainstOwnerPage=True,manifestMatches=True,
 pagePreservedByContentOnlyUpload=True,requiredWorkshopItems=len(page['dependencies']),
 galleryImages=len(page['previews']),relationshipsOwnerVerifiedBeforeUpload=True,
 galleryOwnerVerifiedBeforeUpload=True,postUploadOwnerQuery=expected_description!=publication['descriptionSha256'],
 note='Anonymous official API verifies current public metadata, cover and content manifest against the recorded owner page. The content-only VDF contains no page/media/relationship fields. Any later owner description-only update separately verifies preserved gallery/order and requirements.',blocker=None))
print('PASS anonymous official API: public title, full description, cover and downloaded manifest; content-only upload preserves page relationships/media.')
