"""Prepare by default; --upload --cached-login publishes the configured release.

Content uses SteamCMD. Native SteamUGC queries/adds requirements separately.
Credentials are handled only by Steam's existing cache, outside this repository.
"""
from pathlib import Path
from datetime import datetime,timezone
import argparse,hashlib,json,os,re,shutil,subprocess,time
from steam_workshop import metadata,reconcile_ids,vdf_field,make_vdf,retain_id,plain_quotes,read_as_steamcmd,quote

ROOT=Path(__file__).resolve().parents[1]
RELEASE=ROOT/'release/workshop'
MOD_ID='OnlyKI5VehicleSpawnLiveryOverhaul'
SOURCE=ROOT/'mod'/MOD_ID
STAGE=ROOT/'build/workshop'/MOD_ID
PRIVATE=ROOT/'build/steamcmd'
VDF=PRIVATE/'only-ki5-item.vdf'
IDENTITY=RELEASE/'steamcmd-identity.json'
STEAMCMD=Path(os.environ.get('ONLY_KI5_STEAMCMD',str(Path(os.environ['LOCALAPPDATA'])/'GameMods/SteamCMD/steamcmd.exe')))
PROTECTED_IDS={'3806374180','3811728541','3825545131'}
RELEASE_METADATA=json.loads((RELEASE/'metadata.json').read_text('utf-8'))
TARGET_VISIBILITY={'public':0,'unlisted':3}[RELEASE_METADATA['visibility']]
VERSION='0.3.2'
NATIVE_EVIDENCE=ROOT/'docs/validation/native-20261024-humvee'

def hashes(folder):
    return {p.relative_to(folder).as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
            for p in folder.rglob('*') if p.is_file()}

def write(path,value):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(value,indent=2)+'\n',encoding='utf-8')

def saved_id():
    identity=json.loads(IDENTITY.read_text(encoding='utf-8')) if IDENTITY.exists() else {}
    if identity and (identity['appid']!='108600' or identity['modId']!=MOD_ID):
        raise ValueError('Workshop identity targets another game/mod')
    result=reconcile_ids(identity.get('workshopId'),vdf_field(VDF,'publishedfileid'),
                         metadata(RELEASE/'workshop.txt').get('id'),
                         metadata(STAGE/'workshop.txt').get('id') if STAGE.exists() else None)
    if result in PROTECTED_IDS:raise ValueError('Refusing to target the predecessor or Real Vehicle Interiors')
    return result

def keep_id():
    result=saved_id()
    if result:
        write(IDENTITY,{'workshopId':result,'appid':'108600','modId':MOD_ID,
                        'note':'Keep this identity across retries and future uploads; do not create duplicates.'})
        for path in (RELEASE/'workshop.txt',STAGE/'workshop.txt'):retain_id(path,result)
    return result

def prepare(preserve_page=False):
    PRIVATE.mkdir(parents=True,exist_ok=True)
    expected=hashes(SOURCE)
    package=STAGE/'Contents/mods'/MOD_ID
    if hashes(package)!=expected:raise ValueError('Stage differs from source; prepare a clean stage first')
    if json.loads((STAGE/'payload-manifest.json').read_text(encoding='utf-8'))!=expected:raise ValueError('Payload manifest differs')
    canonical=json.loads((NATIVE_EVIDENCE/'canonical-payload.json').read_text(encoding='utf-8'))['files']
    current={p.relative_to(SOURCE).as_posix():hashlib.sha256(
        p.read_bytes().replace(b'\r\n',b'\n') if p.suffix in {'.lua','.txt','.info','.md','.json'} else p.read_bytes()).hexdigest()
        for p in SOURCE.rglob('*') if p.is_file()}
    # The public replacement changes only the two visible descriptor names.
    # Compare each exact archived descriptor and every other canonical byte.
    accepted=dict(current);metadata_delta=[]
    if current!=canonical:
        previous=RELEASE/'archive/20261024-replaced-3825545131/payload-descriptors'
        for relative in ('mod.info','42/mod.info'):
            old=(previous/relative).read_bytes().replace(b'\r\n',b'\n')
            renamed=old.replace(b'name=Only KI5: Vehicle Spawn & Livery Overhaul\n',
                                b'name=ONLY KI5: Vehicle Spawn & Skins\n')
            actual=(SOURCE/relative).read_bytes().replace(b'\r\n',b'\n')
            if hashlib.sha256(old).hexdigest()!=canonical[relative] or actual!=renamed or renamed==old:
                raise ValueError('Descriptor delta exceeds the authorized display-name change')
            accepted[relative]=canonical[relative];metadata_delta.append(relative)
        if accepted!=canonical:raise ValueError('Gameplay payload differs from native-tested canonical payload')
    write(ROOT/'docs/validation/public-20261024-metadata/canonical-payload.json',
          dict(baseEvidence=NATIVE_EVIDENCE.relative_to(ROOT).as_posix(),metadataOnlyChanges=metadata_delta,
               policy='Only exact descriptor display-name replacement; all gameplay bytes unchanged',files=current))
    if not STEAMCMD.is_file():raise FileNotFoundError('SteamCMD executable missing')
    info=metadata(RELEASE/'workshop.txt')
    if info['visibility']!=RELEASE_METADATA['visibility']:raise ValueError('Unexpected release visibility')
    if info['title']!='ONLY KI5: Vehicle Spawn & Skins':raise ValueError('Unexpected title')
    description=plain_quotes((RELEASE/'description.txt').read_text('utf-8-sig').strip())
    if info['description'].strip()!=description:raise ValueError('Description and native metadata differ; synchronize first')
    description+='\n\nMod ID: '+MOD_ID
    info['description']=description
    note=plain_quotes((RELEASE/'changenote.txt').read_text('utf-8-sig').strip())
    if not note.startswith('Only KI5 '+VERSION+' -'):raise ValueError('Change note version mismatch')
    for text in ((note,) if preserve_page else (description,note)):
        if '\\' in text or len(text.encode())+text.count('\n')>4000:
            raise ValueError('SteamCMD text must contain no backslashes and stay below 4000 bytes')
    item=saved_id()
    if (STAGE/'workshop.txt').exists():
        shutil.copy2(STAGE/'workshop.txt',PRIVATE/'workshop-before-upload.txt')
    shutil.copy2(RELEASE/'workshop.txt',STAGE/'workshop.txt')
    preview=RELEASE/'only-ki5-overhaul-preview.png'
    if preview.read_bytes()!=(STAGE/'preview.png').read_bytes():raise ValueError('Preview changed; restage explicitly')
    if preserve_page:
        if not item or item in PROTECTED_IDS:raise ValueError('Page preservation requires the current Only KI5 item')
        before=json.loads((RELEASE/'page-verified.json').read_text('utf-8'))
        if before['visibility']!=TARGET_VISIBILITY:raise ValueError('Expected verified release visibility')
        fields={'appid':'108600','publishedfileid':item,
                'contentfolder':(STAGE/'Contents').resolve().as_posix(),'changenote':note}
        VDF.write_text('\n'.join(['"workshopitem"','{',*[quote(k)+' '+quote(v) for k,v in fields.items()],'}','']),encoding='utf-8')
    else:
        VDF.write_text(make_vdf('108600',info,STAGE/'Contents',STAGE/'preview.png',item,note),encoding='utf-8')
    parsed=read_as_steamcmd(VDF.read_text(encoding='utf-8'))
    assert parsed['appid']=='108600'
    if preserve_page:
        assert set(parsed)=={'appid','publishedfileid','contentfolder','changenote'}
    else:
        assert parsed['description']==description and parsed['visibility']==str(TARGET_VISIBILITY)
    assert reconcile_ids(parsed['publishedfileid'])==item
    record={'preparedUtc':datetime.now(timezone.utc).isoformat(),'version':VERSION,'workshopId':item,
            'visibility':info['visibility'],'payloadFiles':len(expected),'payloadBytes':sum(p.stat().st_size for p in SOURCE.rglob('*') if p.is_file()),
            'previewSha256':hashlib.sha256(preview.read_bytes()).hexdigest(),
            'sourceCommit':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
            'descriptionSha256':hashlib.sha256(description.encode()).hexdigest(),'uploadAttempted':False,
            'pagePreserved':preserve_page,'nativeEvidence':NATIVE_EVIDENCE.relative_to(ROOT).as_posix(),
            'nativeMetadataOnlyDelta':metadata_delta}
    if preserve_page:record['descriptionSha256']=hashlib.sha256(before['description'].replace('\r\n','\n').encode()).hexdigest()
    write(PRIVATE/'prepared.json',record)
    print('Prepared '+VERSION+': '+str(len(expected))+' native-tested payload files; '+info['visibility']+'; '+(item or 'new item'))
    return record

def cached_username():
    import winreg
    with winreg.OpenKey(winreg.HKEY_CURRENT_USER,r'Software\Valve\Steam') as key:
        username=winreg.QueryValueEx(key,'AutoLoginUser')[0]
    if not username or not username.isascii() or any(c.isspace() or c in '\"\'\\/;+' for c in username):
        raise ValueError('No valid Steam account name in the local desktop setup')
    return username

def steamcmd(arguments,log_name):
    log=PRIVATE/log_name
    with log.open('w',encoding='utf-8') as output:
        process=subprocess.Popen([str(STEAMCMD),'+login',cached_username(),*arguments,'+quit'],
            cwd=STEAMCMD.parent,stdin=subprocess.DEVNULL,stdout=output,stderr=subprocess.STDOUT,
            creationflags=subprocess.CREATE_NO_WINDOW)
        deadline=time.monotonic()+360
        while process.poll() is None:
            if time.monotonic()>deadline:
                process.kill();process.wait();break
            content=log.read_text(encoding='utf-8',errors='replace')
            if re.search(r'(?:password:|Steam Guard code:|two-factor code:)',content,re.I):
                process.kill();process.wait();break
            time.sleep(.5)
    content=log.read_text(encoding='utf-8',errors='replace')
    return process.returncode,content

def upload(record):
    record['uploadAttempted']=True
    code,content=steamcmd(['+workshop_build_item',str(VDF)],'steamcmd-upload.log')
    record.update(steamcmdExitCode=code,workshopId=keep_id())
    committed=bool(re.search(r'(?:Success\.\s+Uploaded item|Committing update\.{3,}\s*Success\.)',content,re.I))
    success=code==0 and record['workshopId'] and committed
    record['steamcmdUploadConfirmed']=bool(success)
    write(RELEASE/'publication.json',record)
    if not success:
        raise RuntimeError('SteamCMD upload not confirmed. Inspect private build/steamcmd/steamcmd-upload.log; saved identity retained.')
    print('SteamCMD confirmed upload: https://steamcommunity.com/sharedfiles/filedetails/?id='+record['workshopId'])

def download():
    item=saved_id()
    if not item:raise ValueError('No assigned item to download')
    code,content=steamcmd(['+workshop_download_item','108600',item,'validate'],'steamcmd-download.log')
    if code or not re.search(r'Success\.\s+Downloaded item',content,re.I):
        raise RuntimeError('Official download not confirmed; inspect the private SteamCMD download log')
    package=STEAMCMD.parent/'steamapps/workshop/content/108600'/item/'mods'/MOD_ID
    actual=hashes(package);expected=hashes(SOURCE)
    if actual!=expected:raise ValueError('Official SteamCMD payload differs from staged source')
    acf=(STEAMCMD.parent/'steamapps/workshop/appworkshop_108600.acf').read_text(encoding='utf-8')
    installed=acf.split('"WorkshopItemsInstalled"',1)[1]
    entry=re.search('"'+item+r'"\s*\{([^}]+)\}',installed,re.S)
    manifest=re.search(r'"manifest"\s*"(\d+)"',entry[1])[1] if entry else None
    if not manifest:raise ValueError('Downloaded Workshop manifest could not be verified')
    write(RELEASE/'download-verified.json',{'verifiedUtc':datetime.now(timezone.utc).isoformat(),
        'workshopId':item,'manifest':manifest,'files':len(actual),'bytes':sum(p.stat().st_size for p in package.rglob('*') if p.is_file()),
        'steamcmdExitCode':code,'allPayloadHashesMatch':True,'payloadSha256':actual})
    print('Official SteamCMD download matches all '+str(len(actual))+' payload files; manifest '+manifest)

def verify(add_dependencies=False,remove_vehicle_dependencies=False):
    import steam_ugc
    item=saved_id()
    if not item:raise ValueError('No assigned Workshop item to query')
    steam_ugc.ITEM=int(item)
    dependencies=json.loads((RELEASE/'dependencies.json').read_text(encoding='utf-8'))
    steam_ugc.DEPENDENCIES={int(d['workshopId']):d['name'] for d in dependencies}
    steam=steam_ugc.Steam()
    operations=[]
    try:
        before=steam.query()
        if before['visibility']!=TARGET_VISIBILITY:raise ValueError('Unexpected release visibility; refusing dependency mutations')
        if before['title']!=metadata(RELEASE/'workshop.txt')['title']:raise ValueError('Unexpected live title')
        if add_dependencies:
            def record(operation):
                operations.append(operation);write(PRIVATE/'dependency-operations.json',operations)
            steam.add_dependencies(before,record)
        if remove_vehicle_dependencies:
            fleet=json.loads((ROOT/'config/fleet-dependencies.json').read_text('utf-8'))
            allowed={int(d['workshopId']) for d in fleet}-set(steam_ugc.DEPENDENCIES)
            def record_removal(operation):
                operations.append(operation);write(PRIVATE/'dependency-removal-operations.json',operations)
            steam.remove_dependencies(before,allowed,record_removal)
        after=steam.query() if add_dependencies or remove_vehicle_dependencies else before
        publication=json.loads((RELEASE/'publication.json').read_text(encoding='utf-8'))
        if publication['workshopId']!=item:raise ValueError('Publication receipt targets another item')
        page_update=RELEASE/'page-update-verified.json'
        if page_update.exists():
            latest=json.loads(page_update.read_text('utf-8'))
            if latest['workshopId']!=item or not latest['verified']:
                raise ValueError('Latest page-update receipt is not verified for this item')
            publication=latest
        description_hash=hashlib.sha256(after['description'].replace('\r\n','\n').encode()).hexdigest()
        if description_hash!=publication['descriptionSha256']:raise ValueError('Live description differs from uploaded snapshot')
        if after['visibility']!=TARGET_VISIBILITY or after['missingDependencies']:raise ValueError('Visibility or dependency verification is incomplete')
        if set(after['dependencies'])!=set(steam_ugc.DEPENDENCIES):raise ValueError('Unexpected live dependencies')
        if any(after[key]!=before[key] for key in ('title','cover','previews')):
            raise ValueError('Unexpected page/media change during dependency update')
        write(RELEASE/'page-verified.json',{'queriedUtc':datetime.now(timezone.utc).isoformat(),**after})
        write(RELEASE/'verification-status.json',{'verifiedUtc':datetime.now(timezone.utc).isoformat(),
            'workshopId':item,'steamcmdUploadConfirmed':True,'officialDownloadMatches':True,
            'visibilityConfigured':TARGET_VISIBILITY,'visibilityOwnerVerified':True,'requiredWorkshopItems':len(after['dependencies']),
            'requiredItemsVerified':True,'descriptionVerifiedAgainstUpload':True,'blocker':None})
        print('Verified: '+RELEASE_METADATA['visibility']+', complete description, '+str(len(after['dependencies']))+' required Workshop items')
    finally:steam.api.SteamAPI_Shutdown()

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--upload',action='store_true');p.add_argument('--cached-login',action='store_true')
    p.add_argument('--verify',action='store_true');p.add_argument('--add-dependencies',action='store_true')
    p.add_argument('--download',action='store_true')
    p.add_argument('--remove-vehicle-dependencies',action='store_true')
    p.add_argument('--preserve-page',action='store_true',help='Content-only update preserving live description, title, gallery, cover, visibility and requirements')
    a=p.parse_args()
    if a.add_dependencies and not a.verify:p.error('--add-dependencies requires --verify')
    if a.remove_vehicle_dependencies and not a.verify:p.error('--remove-vehicle-dependencies requires --verify')
    if (a.upload or a.download) and not a.cached_login:p.error('Use --cached-login; credentials must be handled locally by Steam')
    if sum((a.upload,a.verify,a.download))>1:p.error('Choose only one of --upload, --verify or --download')
    if a.download:download()
    elif a.verify:verify(a.add_dependencies,a.remove_vehicle_dependencies)
    else:
        if a.preserve_page:verify()
        record=prepare(a.preserve_page)
        if a.upload:upload(record)

if __name__=='__main__':main()
