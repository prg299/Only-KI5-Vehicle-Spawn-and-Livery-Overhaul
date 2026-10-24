"""Export only stopped owned 0.3.3 registry/visual receipts, never private logs."""
from pathlib import Path
import hashlib,json,shutil,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'dev'))
from native_paths import owned_run
MOD=ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
OUT=ROOT/'docs/validation/native-20261024-spawn-pools'
RUNS={'default-rare':'spawn-audit-033-final4-sp','original-weights':'spawn-audit-033-final4-off','multiplayer':'spawn-audit-033-final4-mp'}
current={p.relative_to(MOD).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in MOD.rglob('*') if p.is_file()}
OUT.mkdir(parents=True,exist_ok=True)
evidence={}
for mode,name in RUNS.items():
    run=owned_run(name);assert (run/'finished.json').is_file(),name+' still active'
    inputs=json.loads((run/'inputs.json').read_text('utf8'))
    assert {k.replace('\\','/'):v for k,v in inputs['payload'].items()}==current,name+' source drift'
    clients=('a','b') if mode=='multiplayer' else ('sp',)
    exits={}
    for client in clients:
        receipt=json.loads((run/client/'native-session-exit.json').read_text('utf8'))
        assert receipt['exitCode']==0 and receipt['desktopSwitched'] is False,receipt
        exits[client]={k:receipt[k] for k in ('exitCode','desktopSwitched','keeperInJob','gameInJob')}
    if mode=='multiplayer':
        exits['server']=json.loads((run/'server/exit.json').read_text('utf8'));assert exits['server']['exitCode']==0
    records={}
    for file in run.glob('audit-*.json'):records[file.stem]=json.loads(file.read_text('utf8'))
    for file in run.glob('spawn-pools*.json'):records[file.stem]=json.loads(file.read_text('utf8'))
    for file in run.glob('connected-*.json'):records[file.stem]=json.loads(file.read_text('utf8'))
    for file in run.glob('sandbox-*.json'):records[file.stem]=json.loads(file.read_text('utf8'))
    for label in ('silent-lightbar-audio','silent-lightbar-fixture','silent-lightbar-saved-vehicles'):
        file=run/(label+'.json')
        if file.is_file():records[label]=json.loads(file.read_text('utf8'))
    # Preserve reviewed, unmodified native frames, with exact source hashes.
    frames={};rejected={};dest=OUT/'captures'/mode;dest.mkdir(parents=True,exist_ok=True)
    for file in (run/'captures').glob('audit-*.png'):
        if mode=='multiplayer' and file.name.startswith('audit-police-100-fixture'):
            rejected[file.name]={'sha256':hashlib.sha256(file.read_bytes()).hexdigest(),
                'reason':'Rejected visual evidence: dead/indoor observer or no visible target lightbar. Native state assertions remain separate.'}
            continue
        shutil.copy2(file,dest/file.name)
        frames[file.name]=hashlib.sha256(file.read_bytes()).hexdigest()
    evidence[mode]={'run':name,'mods':inputs['mods'],'cleanExits':exits,'records':records,'frames':frames,'rejectedFrames':rejected}
ui=owned_run('spawn-audit-033-final4-sp')
ui_files=['42/media/sandbox-options.txt','42/media/lua/shared/Translate/EN/Sandbox.json']
ui_inputs=json.loads((ui/'inputs.json').read_text('utf8'))['payload']
assert all(ui_inputs[k.replace('/','\\') if k not in ui_inputs else k]==current[k] for k in ui_files)
evidence['nativeSandboxInput']=json.loads((ui/'sandbox-input.json').read_text('utf8'))
evidence['nativeSettingsInput']=json.loads((ui/'sandbox-settings-input.json').read_text('utf8'))
for file in (ui/'captures').glob('audit-sandbox-*.png'):
    (OUT/'captures/options').mkdir(parents=True,exist_ok=True);shutil.copy2(file,OUT/'captures/options'/file.name)
text={'.lua','.txt','.info','.md','.json'}
canonical={p.relative_to(MOD).as_posix():hashlib.sha256(p.read_bytes().replace(b'\r\n',b'\n') if p.suffix in text else p.read_bytes()).hexdigest() for p in MOD.rglob('*') if p.is_file()}
def write(name,value):(OUT/name).write_text(json.dumps(value,indent=2)+'\n','utf8')
write('canonical-payload.json',{'policy':'LF-normalized text for Git; raw native hashes retained separately','files':canonical})
write('tested-payload.json',{'files':current})
write('evidence.json',{'version':'0.3.3','game':'42.21.0','runs':evidence,'compiledLuaFiles':57,
    'productionLuaScenarios':23,'scope':'All final registries for the recorded fleet; representative natural locations, no population-frequency claim'})
print('Exported three clean owned 0.3.3 runs, native sandbox inputs, complete registries and natural frames.')
