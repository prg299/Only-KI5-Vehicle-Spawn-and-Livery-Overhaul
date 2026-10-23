"""Prepare by default; --upload --cached-login publishes the unlisted candidate.

Content uses SteamCMD. Native SteamUGC queries/adds requirements separately.
Credentials are handled only by Steam's existing cache, outside this repository.
"""
from pathlib import Path
from datetime import datetime,timezone
import argparse,hashlib,json,os,re,shutil,subprocess,time
from steam_workshop import metadata,reconcile_ids,vdf_field,make_vdf,retain_id,plain_quotes,read_as_steamcmd

ROOT=Path(__file__).resolve().parents[1]
RELEASE=ROOT/'release/workshop'
MOD_ID='OnlyKI5VehicleSpawnLiveryOverhaul'
SOURCE=ROOT/'mod'/MOD_ID
STAGE=ROOT/'build/workshop'/MOD_ID
PRIVATE=ROOT/'build/steamcmd'
VDF=PRIVATE/'only-ki5-item.vdf'
IDENTITY=RELEASE/'steamcmd-identity.json'
STEAMCMD=Path(os.environ.get('ONLY_KI5_STEAMCMD',str(Path(os.environ['LOCALAPPDATA'])/'GameMods/SteamCMD/steamcmd.exe')))
PROTECTED_IDS={'3806374180','3811728541'}

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

def prepare():
    PRIVATE.mkdir(parents=True,exist_ok=True)
    expected=hashes(SOURCE)
    package=STAGE/'Contents/mods'/MOD_ID
    if hashes(package)!=expected:raise ValueError('Stage differs from source; prepare a clean stage first')
    if json.loads((STAGE/'payload-manifest.json').read_text(encoding='utf-8'))!=expected:raise ValueError('Payload manifest differs')
    canonical=json.loads((ROOT/'docs/validation/native-20261023/canonical-payload.json').read_text(encoding='utf-8'))['files']
    current={p.relative_to(SOURCE).as_posix():hashlib.sha256(
        p.read_bytes().replace(b'\r\n',b'\n') if p.suffix in {'.lua','.txt','.info','.md','.json'} else p.read_bytes()).hexdigest()
        for p in SOURCE.rglob('*') if p.is_file()}
    if current!=canonical:raise ValueError('Candidate differs from native-tested canonical payload')
    if not STEAMCMD.is_file():raise FileNotFoundError('SteamCMD executable missing')
    info=metadata(RELEASE/'workshop.txt')
    if info['visibility']!='unlisted':raise ValueError('Only an unlisted upload is authorized')
    if info['title']!='Only KI5: Vehicle Spawn & Livery Overhaul':raise ValueError('Unexpected title')
    description=plain_quotes((RELEASE/'description.txt').read_text('utf-8-sig').strip())
    if info['description'].strip()!=description:raise ValueError('Description and native metadata differ; synchronize first')
    description+='\n\nMod ID: '+MOD_ID
    info['description']=description
    note=plain_quotes((RELEASE/'changenote.txt').read_text('utf-8-sig').strip())
    if not note.startswith('Only KI5 0.3.1 -'):raise ValueError('Change note version mismatch')
    for text in (description,note):
        if '\\' in text or len(text.encode())+text.count('\n')>4000:
            raise ValueError('SteamCMD text must contain no backslashes and stay below 4000 bytes')
    item=saved_id()
    if (STAGE/'workshop.txt').exists():
        shutil.copy2(STAGE/'workshop.txt',PRIVATE/'workshop-before-upload.txt')
    shutil.copy2(RELEASE/'workshop.txt',STAGE/'workshop.txt')
    preview=RELEASE/'only-ki5-overhaul-preview.png'
    if preview.read_bytes()!=(STAGE/'preview.png').read_bytes():raise ValueError('Preview changed; restage explicitly')
    VDF.write_text(make_vdf('108600',info,STAGE/'Contents',STAGE/'preview.png',item,note),encoding='utf-8')
    parsed=read_as_steamcmd(VDF.read_text(encoding='utf-8'))
    assert parsed['description']==description and parsed['visibility']=='3' and parsed['appid']=='108600'
    assert reconcile_ids(parsed['publishedfileid'])==item
    record={'preparedUtc':datetime.now(timezone.utc).isoformat(),'version':'0.3.1','workshopId':item,
            'visibility':'unlisted','payloadFiles':len(expected),'payloadBytes':sum(p.stat().st_size for p in SOURCE.rglob('*') if p.is_file()),
            'previewSha256':hashlib.sha256(preview.read_bytes()).hexdigest(),
            'sourceCommit':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
            'descriptionSha256':hashlib.sha256(description.encode()).hexdigest(),'uploadAttempted':False}
    write(PRIVATE/'prepared.json',record)
    print('Prepared 0.3.1: '+str(len(expected))+' native-tested payload files; unlisted; '+(item or 'new item'))
    return record

def cached_username():
    import winreg
    with winreg.OpenKey(winreg.HKEY_CURRENT_USER,r'Software\Valve\Steam') as key:
        username=winreg.QueryValueEx(key,'AutoLoginUser')[0]
    if not username or not username.isascii() or any(c.isspace() or c in '\"\'\\/;+' for c in username):
        raise ValueError('No valid Steam account name in the local desktop setup')
    return username

def upload(record):
    log=PRIVATE/'steamcmd-upload.log'
    record['uploadAttempted']=True
    with log.open('w',encoding='utf-8') as output:
        process=subprocess.Popen([str(STEAMCMD),'+login',cached_username(),'+workshop_build_item',str(VDF),'+quit'],
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
    record.update(steamcmdExitCode=process.returncode,workshopId=keep_id())
    content=log.read_text(encoding='utf-8',errors='replace')
    success=process.returncode==0 and record['workshopId'] and bool(re.search(r'Success\.\s+Uploaded item',content,re.I))
    record['steamcmdUploadConfirmed']=bool(success)
    write(RELEASE/'publication.json',record)
    if not success:
        raise RuntimeError('SteamCMD upload not confirmed. Inspect private build/steamcmd/steamcmd-upload.log; saved identity retained.')
    print('SteamCMD confirmed upload: https://steamcommunity.com/sharedfiles/filedetails/?id='+record['workshopId'])

def verify(add_dependencies=False):
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
        if before['visibility']!=3:raise ValueError('Item is not unlisted; refusing dependency mutations')
        if before['title']!=metadata(RELEASE/'workshop.txt')['title']:raise ValueError('Unexpected live title')
        if add_dependencies:
            def record(operation):
                operations.append(operation);write(PRIVATE/'dependency-operations.json',operations)
            steam.add_dependencies(before,record)
        after=steam.query() if add_dependencies else before
        expected=plain_quotes((RELEASE/'description.txt').read_text('utf-8-sig').strip())+'\n\nMod ID: '+MOD_ID
        if after['description'].replace('\r\n','\n')!=expected:raise ValueError('Live description differs from prepared text')
        if after['visibility']!=3 or after['missingDependencies']:raise ValueError('Unlisted visibility or dependency verification is incomplete')
        if set(after['dependencies'])!=set(steam_ugc.DEPENDENCIES):raise ValueError('Unexpected live dependencies')
        write(RELEASE/'page-verified.json',{'queriedUtc':datetime.now(timezone.utc).isoformat(),**after})
        print('Verified: unlisted, complete description, '+str(len(after['dependencies']))+' required Workshop items')
    finally:steam.api.SteamAPI_Shutdown()

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--upload',action='store_true');p.add_argument('--cached-login',action='store_true')
    p.add_argument('--verify',action='store_true');p.add_argument('--add-dependencies',action='store_true')
    a=p.parse_args()
    if a.add_dependencies and not a.verify:p.error('--add-dependencies requires --verify')
    if a.upload and not a.cached_login:p.error('Use --cached-login; credentials must be handled locally by Steam')
    if a.verify:verify(a.add_dependencies)
    else:
        record=prepare()
        if a.upload:upload(record)

if __name__=='__main__':main()
