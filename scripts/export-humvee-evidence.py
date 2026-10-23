"""Export whitelisted 0.3.2 receipts only after all owned runs stop cleanly."""
from pathlib import Path
import hashlib,json,sys

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'dev'))
from native_paths import owned_run

OUT=ROOT/'docs/validation/native-20261024-humvee'
MOD=ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
RUNS=['humvee-032-sp-a','humvee-032-sp-b-reload','humvee-032-mp-a','humvee-032-mp-b-reload']
current={p.relative_to(MOD).as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
         for p in MOD.rglob('*') if p.is_file()}
evidence={}
for name in RUNS:
    run=owned_run(name)
    assert (run/'finished.json').is_file(),('Still active',name)
    report=json.loads((run/'humvee-skins.json').read_text('utf8'))
    assert len(report['fixture'])==20
    assert all(v['skin']==v['data']['OnlyKI5VehicleSpawnLiveryOverhaul.HumveeSkinV1'] for v in report['fixture'])
    tested=json.loads((run/'inputs.json').read_text('utf8'))['payload']
    assert {k.replace('\\','/'):v for k,v in tested.items()}==current,('Source drift',name)
    clients=('sp',) if report['singlePlayer'] else ('a','b')
    exits={}
    for client in clients:
        receipt=json.loads((run/client/'native-session-exit.json').read_text('utf8'))
        assert receipt['exitCode']==0 and receipt['desktopSwitched'] is False
        exits[client]={k:receipt[k] for k in ('exitCode','desktopSwitched','keeperInJob','gameInJob')}
    if not report['singlePlayer']:
        assert len(report['peerComparisons'])==40 and all(c['matches'] for c in report['peerComparisons'])
        exits['server']=json.loads((run/'server/exit.json').read_text('utf8'))
        assert exits['server']['exitCode']==0
    evidence[name]=dict(report=report,cleanExits=exits)
text={'.lua','.txt','.info','.md','.json'}
canonical={p.relative_to(MOD).as_posix():hashlib.sha256(
    p.read_bytes().replace(b'\r\n',b'\n') if p.suffix in text else p.read_bytes()).hexdigest()
    for p in MOD.rglob('*') if p.is_file()}
old=json.loads((ROOT/'docs/validation/native-20261023/canonical-payload.json').read_text('utf8'))['files']
changes=sorted(k for k in set(old)|set(canonical) if old.get(k)!=canonical.get(k))
assert changes==sorted(['mod.info','42/mod.info',
    '42/media/lua/shared/OnlyKI5VehicleSpawnLiveryOverhaul_SpawnSkins.lua',
    '42/media/lua/server/OnlyKI5VehicleSpawnLiveryOverhaul_PoliceSpawnRouting.lua']),changes
OUT.mkdir(parents=True,exist_ok=True)
def write(name,value):(OUT/name).write_text(json.dumps(value,indent=2)+'\n',encoding='utf8')
write('evidence.json',dict(version='0.3.2',game='42.21.0',runs=evidence,
    changedPayloadFiles=changes,scope='Focused weighted-livery follow-up; earlier 0.3.1 acceptance remains separate',
    productionLuaScenarios=13,compiledLuaFiles=56,hearingAcceptance=False))
write('canonical-payload.json',dict(policy='LF-normalized text for Git; raw tested hashes retained separately',files=canonical))
write('tested-payload.json',dict(files=current))
print('Exported four clean owned native runs; SP/MP, two peers and both restarts; '+str(len(current))+' payload files')
