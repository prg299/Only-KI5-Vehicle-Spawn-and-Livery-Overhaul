"""Delete exactly the owner-requested old item after full replacement verification.

Uses Valve ISteamUGC::DeleteItem / DeleteItemResult_t (callback 3417).
https://partner.steamgames.com/doc/api/ISteamUGC#DeleteItem
The private predecessor and Real Vehicle Interiors are never deletion targets.
"""
from datetime import datetime,timezone
import ctypes as C
import hashlib,json
import steam_ugc
from workshop_upload import ROOT,RELEASE,SOURCE,saved_id,hashes,write,TARGET_VISIBILITY

OLD=3825545131
class DeleteResult(C.Structure):
    _fields_=[('result',C.c_int),('item',steam_ugc.U64)]

def main():
    plan=json.loads((RELEASE/'replacement.json').read_text('utf8'))
    new=saved_id()
    if plan['previousWorkshopId']!=str(OLD) or not plan['deletePreviousAuthorized']:
        raise ValueError('No matching owner-authorized replacement')
    if new!=plan['newWorkshopId'] or new in ('3806374180','3811728541',str(OLD)):
        raise ValueError('Replacement identity mismatch')
    manifest=json.loads((RELEASE/'gallery/manifest.json').read_text('utf8'))
    download=json.loads((RELEASE/'download-verified.json').read_text('utf8'))
    gallery_download=json.loads((RELEASE/'gallery-download-verified.json').read_text('utf8'))
    if download['workshopId']!=new or not download['allPayloadHashesMatch'] or download['payloadSha256']!=hashes(SOURCE):
        raise ValueError('Official replacement payload download must match source first')
    if gallery_download['workshopId']!=new or not gallery_download['allImagesMatch'] or len(gallery_download['images'])!=14:
        raise ValueError('All fourteen replacement images must be read back first')
    if [(x['file'],x['sha256']) for x in gallery_download['images']]!=[(x['file'],x['sha256']) for x in manifest['images']]:
        raise ValueError('Replacement gallery receipt differs')
    steam_ugc.ITEM=int(new)
    steam_ugc.DEPENDENCIES={int(d['workshopId']):d['name'] for d in json.loads((RELEASE/'dependencies.json').read_text('utf8'))}
    steam=steam_ugc.Steam()
    try:
        current=steam.query()
        description=(RELEASE/'description.txt').read_text('utf8').strip()+'\n\nMod ID: OnlyKI5VehicleSpawnLiveryOverhaul'
        if TARGET_VISIBILITY!=0 or current['visibility']!=0 or current['title']!=plan['title']:
            raise ValueError('The new item must be public with the requested title')
        if current['description'].replace('\r\n','\n')!=description.replace('\r\n','\n'):
            raise ValueError('New description differs')
        if set(current['dependencies'])!=set(steam_ugc.DEPENDENCIES) or [p['name'] for p in current['previews']]!=[p['file'] for p in manifest['images']]:
            raise ValueError('New requirements/gallery differ')
        receipt_path=RELEASE/'replacement-deletion.json'
        steam_ugc.ITEM=OLD
        old=steam.query(allow_missing=True)
        if old.get('missing'):
            if not receipt_path.exists():raise ValueError('Old item already missing without our deletion journal')
            receipt=json.loads(receipt_path.read_text('utf8'))
            receipt.update(oldItemAbsentVerified=True,absenceCheck=old)
            write(receipt_path,receipt)
        else:
            if old['title']!=plan['previousTitle']:
                raise ValueError('The old item title changed; refusing deletion')
            write(RELEASE/'archive/20261024-replaced-3825545131/owner-before-deletion.json',old)
            receipt=dict(previousWorkshopId=str(OLD),replacementWorkshopId=new,
                         authorizedRequestDate='2026-10-24',status='submitting',
                         replacementPublicVerified=True,replacementDownloadVerified=True,
                         replacementGalleryVerified=True)
            write(receipt_path,receipt)
            steam.bind('SteamAPI_ISteamUGC_DeleteItem',steam_ugc.U64,steam_ugc.P,steam_ugc.U64)
            result=steam.call(steam.api.SteamAPI_ISteamUGC_DeleteItem(steam.ugc,OLD),DeleteResult,3417)
            if result.item!=OLD:raise RuntimeError('Deletion callback identity mismatch; query before retrying')
            receipt.update(status='deleted',steamResult=result.result,deletedUtc=datetime.now(timezone.utc).isoformat())
            write(receipt_path,receipt)
            absent=steam.query(allow_missing=True)
            if not absent.get('missing'):raise RuntimeError('Deletion succeeded; fresh absence check is pending')
            receipt.update(oldItemAbsentVerified=True,absenceCheck=absent);write(receipt_path,receipt)
        steam_ugc.ITEM=int(new)
        after=steam.query()
        if any(after[k]!=current[k] for k in ('title','visibility','description','cover','previews','dependencies')):
            raise RuntimeError('Replacement page changed during old-item deletion')
        plan.update(previousDeleted=True,deletedUtc=receipt.get('deletedUtc'),oldItemAbsentVerified=True)
        write(RELEASE/'replacement.json',plan)
        print('Deleted old item '+str(OLD)+'; independently verified absence and unchanged public replacement '+new)
    finally:steam.api.SteamAPI_Shutdown()

if __name__=='__main__':main()
