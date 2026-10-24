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
assert digest(detail['description'])==publication['descriptionSha256']==digest(page['description'])
assert str(detail['hcontent_file'])==download['manifest']
assert detail['preview_url']==page['cover']
stamp=datetime.now(timezone.utc).isoformat()
write(RELEASE/'public-web-verified.json',dict(verifiedUtc=stamp,workshopId=item,
 title=detail['title'],visibility=detail['visibility'],manifest=download['manifest'],
 descriptionSha256=digest(detail['description']),crashSceneWordingVerified='Crashed cars too.' in detail['description'],
 officialPublicMetadataVerified=True,coverMatches=True,version=publication['version']))
write(RELEASE/'verification-status.json',dict(verifiedUtc=stamp,workshopId=item,
 steamcmdUploadConfirmed=True,officialDownloadMatches=True,visibilityConfigured=0,
 visibilityPublicApiVerified=True,descriptionVerifiedAgainstUpload=True,manifestMatches=True,
 pagePreservedByContentOnlyUpload=True,requiredWorkshopItems=len(page['dependencies']),
 galleryImages=len(page['previews']),relationshipsOwnerVerifiedBeforeUpload=True,
 galleryOwnerVerifiedBeforeUpload=True,postUploadOwnerQuery=False,
 note='Anonymous official API verifies current public metadata, cover and content manifest. Ordered gallery and exact two requirements were owner-verified immediately before the content-only upload; they are outside the upload VDF.',blocker=None))
print('PASS anonymous official API: public title, full description, cover and downloaded manifest; content-only upload preserves page relationships/media.')
