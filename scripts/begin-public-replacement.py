"""Archive the explicitly replaced item and allocate one new Steam identity.

Restricted to the owner's 2026-10-24 replacement request. Never deletes an item.
An unknown creation outcome leaves a journal and refuses blind creation retries.
"""
from pathlib import Path
import ctypes as C
from datetime import datetime,timezone
import json,shutil
import steam_ugc

ROOT=Path(__file__).resolve().parents[1]
RELEASE=ROOT/'release/workshop'
ARCHIVE=RELEASE/'archive/20261024-replaced-3825545131'
PRIVATE=ROOT/'build/steamcmd'
IDENTITY=RELEASE/'steamcmd-identity.json'
PLAN=RELEASE/'replacement.json'
OLD='3825545131'
TITLE='ONLY KI5: Vehicle Spawn & Skins'

def write(path,value):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(value,indent=2)+'\n',encoding='utf8')

class CreateResult(C.Structure):
    _fields_=[('result',C.c_int),('item',steam_ugc.U64),('agreement',steam_ugc.BOOL)]

def main():
    if PLAN.exists():
        plan=json.loads(PLAN.read_text('utf8'))
        if plan.get('newWorkshopId'):
            print('New identity already allocated: '+plan['newWorkshopId']);return
        raise RuntimeError('Replacement already started; inspect its creation journal before any retry')
    if json.loads(IDENTITY.read_text('utf8'))['workshopId']!=OLD:
        raise ValueError('Expected the explicitly replaced Only KI5 identity')
    steam_ugc.ITEM=int(OLD)
    steam=steam_ugc.Steam()
    try:
        before=steam.query()
        if before['title']!='Only KI5: Vehicle Spawn & Livery Overhaul' or before['visibility']!=3:
            raise ValueError('The replaced item changed; inspect before proceeding')
        assert not ARCHIVE.exists()
        ARCHIVE.mkdir(parents=True)
        for source in RELEASE.iterdir():
            if source.name=='archive':continue
            target=ARCHIVE/source.name
            if source.is_dir():shutil.copytree(source,target)
            else:shutil.copy2(source,target)
        write(ARCHIVE/'owner-snapshot.json',dict(queriedUtc=datetime.now(timezone.utc).isoformat(),**before))
        for name in ('mod.info','42/mod.info'):
            target=ARCHIVE/'payload-descriptors'/name;target.parent.mkdir(parents=True,exist_ok=True)
            shutil.copy2(ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'/name,target)
        stage=(ROOT/'build/workshop/OnlyKI5VehicleSpawnLiveryOverhaul').resolve()
        history=(ROOT/'build/history/0.3.2-before-public-20261024').resolve()
        assert stage.parent==(ROOT/'build/workshop').resolve() and history.parent==(ROOT/'build/history').resolve()
        assert not history.exists()
        history.parent.mkdir(parents=True,exist_ok=True)
        stage.rename(history)
        vdf=PRIVATE/'only-ki5-item.vdf'
        archived_vdf=PRIVATE/'history/3825545131/only-ki5-item.vdf'
        archived_vdf.parent.mkdir(parents=True,exist_ok=True)
        if vdf.exists():
            assert not archived_vdf.exists();vdf.rename(archived_vdf)
        plan=dict(requestDate='2026-10-24',previousWorkshopId=OLD,previousTitle=before['title'],
                  title=TITLE,visibility='public',deletePreviousAuthorized=True,
                  newWorkshopId=None,creationStatus='submitting',previousDeleted=False)
        write(PLAN,plan)
        steam.bind('SteamAPI_ISteamUGC_CreateItem',steam_ugc.U64,steam_ugc.P,steam_ugc.U32,C.c_int)
        result=steam.call(steam.api.SteamAPI_ISteamUGC_CreateItem(steam.ugc,108600,0),CreateResult,3403)
        new=str(result.item)
        if new in ('0',OLD,'3806374180','3811728541'):raise RuntimeError('Invalid new identity')
        plan.update(newWorkshopId=new,creationStatus='created',needsAgreement=bool(result.agreement))
        write(PLAN,plan)
        write(IDENTITY,dict(workshopId=new,appid='108600',modId='OnlyKI5VehicleSpawnLiveryOverhaul',
                           note='Fresh public replacement; retain this identity across retries.',replaces=OLD))
        for name in ('publication.json','download-verified.json','page-verified.json','page-update-verified.json',
                     'gallery-download-verified.json','verification-status.json'):
            path=RELEASE/name
            if path.exists():path.unlink()  # exact archived local receipts only
        write(RELEASE/'verification-status.json',dict(workshopId=new,visibilityConfigured=0,
              steamcmdUploadConfirmed=False,officialDownloadMatches=False,
              blocker='Fresh public identity allocated; publication is being prepared.'))
        print('Allocated fresh Workshop item '+new+'; old item retained until replacement verification')
        if result.agreement:raise RuntimeError('Owner must accept the Workshop agreement before publication')
    finally:steam.api.SteamAPI_Shutdown()

if __name__=='__main__':main()
