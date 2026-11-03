"""Export only accepted, stopped road-fix native runs matching current bytes."""
from pathlib import Path
import argparse,hashlib,json,shutil,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'dev'))
from native_paths import owned_run
MOD=ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
OUT=ROOT/'docs/validation/native-20261103-road-fixes'
p=argparse.ArgumentParser();p.add_argument('--available-only',action='store_true');a=p.parse_args()
raw={f.relative_to(MOD).as_posix():hashlib.sha256(f.read_bytes()).hexdigest() for f in MOD.rglob('*') if f.is_file()}
canonical={f.relative_to(MOD).as_posix():hashlib.sha256(f.read_bytes().replace(b'\r\n',b'\n') if f.suffix in {'.lua','.txt','.info','.md','.json'} else f.read_bytes()).hexdigest() for f in MOD.rglob('*') if f.is_file()}
evidence={}
for mode in ('sp','mp'):
    name={'sp':'road-fixes-035-sp-f','mp':'road-fixes-035-mp'}[mode];run=owned_run(name)
    if a.available_only and not (run/'finished.json').is_file():continue
    assert (run/'finished.json').is_file(),name+' has not stopped'
    accepted=json.loads((run/'road-fixes-acceptance.json').read_text())
    assert accepted['accepted'] and accepted['mode']==mode and accepted['visualReview']
    inputs=json.loads((run/'inputs.json').read_text())
    assert {k.replace('\\','/'):v for k,v in inputs['payload'].items()}==raw,name+' payload differs'
    exits={}
    for who in (('a','b') if mode=='mp' else ('sp',)):
        receipt=json.loads((run/who/'native-session-exit.json').read_text())
        assert receipt['exitCode']==0 and receipt['desktopSwitched'] is False
        exits[who]={k:receipt[k] for k in ('exitCode','desktopSwitched','gameInJob','keeperInJob')}
    if mode=='mp':
        exits['server']=json.loads((run/'server/exit.json').read_text());assert exits['server']['exitCode']==0
    helper=json.loads((run/'optional-fleet-helper-exit.json').read_text());assert helper['exitCode']==0
    records={f.stem:json.loads(f.read_text()) for f in run.glob('road-fixes-*.json')}
    for stem in ('silent-lightbar-audio','optional-fleet-authority'):
        records[stem]=json.loads((run/(stem+'.json')).read_text())
    if mode=='mp':records['audit-mp-comparison']=json.loads((run/'audit-mp-comparison.json').read_text())
    assert records['silent-lightbar-audio']['nativeSirenStateVerified']
    frames={}
    for frame in (run/'captures').glob('road-fixes-*.png'):
        target=OUT/'captures'/mode/frame.name;target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(frame,target)
        frames[frame.name]=hashlib.sha256(frame.read_bytes()).hexdigest()
    evidence[mode]={'run':name,'modules':inputs['mods'],'exits':exits,'records':records,'frames':frames}
OUT.mkdir(parents=True,exist_ok=True)
def write(name,data):(OUT/name).write_text(json.dumps(data,indent=2)+'\n','utf8')
write('tested-payload.json',{'files':raw});write('canonical-payload.json',{'files':canonical})
write('evidence.json',{'version':'0.3.5','game':'42.21.0','complete':len(evidence)==2,'runs':evidence,'productionLuaScenarios':29,'compiledLuaFiles':59,'nativeApiContracts':39})
print('Exported '+str(len(evidence))+' accepted road-fix lifetimes with exact payloads and clean exits')
