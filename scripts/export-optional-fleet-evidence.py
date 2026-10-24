"""Export stopped native optional-fleet receipts, without private profiles/logs."""
from pathlib import Path
import argparse,hashlib,json,re,shutil,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'dev'))
from native_paths import owned_run
from native_lab import rows
MOD=ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul';OUT=ROOT/'docs/validation/native-20261024-optional-fleets'
RUNS={'none':'optional-034-zero-verified','one':'optional-034-one-verified','full-menu':'optional-034-full-verified','mixed-multiplayer':'optional-034-mixed-verified'}
p=argparse.ArgumentParser();p.add_argument('--available-only',action='store_true');a=p.parse_args()
raw={f.relative_to(MOD).as_posix():hashlib.sha256(f.read_bytes()).hexdigest() for f in MOD.rglob('*') if f.is_file()}
canonical={f.relative_to(MOD).as_posix():hashlib.sha256(f.read_bytes().replace(b'\r\n',b'\n') if f.suffix in {'.lua','.txt','.info','.md','.json'} else f.read_bytes()).hexdigest() for f in MOD.rglob('*') if f.is_file()}
text=(MOD/'42/media/lua/shared/OnlyKI5VehicleSpawnLiveryOverhaul_OptionalVehicles.lua').read_text('utf8')
skins={name:len(re.findall(r'\bskin\s*\{',body)) for name,body in re.findall(r'\{script="([^"]+)".*?definition=\[==\[(.*?)\]==\]\},',text,re.S)}
assert len(skins)==57
OUT.mkdir(parents=True,exist_ok=True);evidence={}
for mode,name in RUNS.items():
 run=owned_run(name)
 if a.available_only and not (run/'finished.json').is_file():continue
 assert (run/'finished.json').is_file(),name+' not stopped'
 assert (run/'optional-fleet-acceptance.json').is_file(),name+' not accepted'
 inputs=json.loads((run/'inputs.json').read_text())
 assert {k.replace('\\','/'):v for k,v in inputs['payload'].items()}==raw,name+' payload drift'
 exits={}
 for who in (('a','b') if mode=='mixed-multiplayer' else ('sp',)):
  receipt=json.loads((run/who/'native-session-exit.json').read_text())
  assert receipt['exitCode']==0 and receipt['desktopSwitched'] is False,receipt
  exits[who]={k:receipt[k] for k in ('exitCode','desktopSwitched','gameInJob','keeperInJob')}
 if mode=='mixed-multiplayer':
  exits['server']=json.loads((run/'server/exit.json').read_text());assert exits['server']['exitCode']==0
 records={f.stem:json.loads(f.read_text()) for f in run.glob('optional-fleet-*.json')}
 if mode=='mixed-multiplayer':
  for stem in ('audit-mp-comparison','silent-lightbar-audio'):
   records[stem]=json.loads((run/(stem+'.json')).read_text())
  assert records['silent-lightbar-audio']['nativeSirenStateVerified']
  assert records['silent-lightbar-audio']['nativeAudioManagerVerified']
 authority=records['optional-fleet-authority'];assert not authority['invalid']
 for variant in rows(authority['variants']):
  if variant['enabled']:assert variant['skins']==skins[variant['name']] and variant['parts']>0,variant
 frames={}
 for f in (run/'captures').glob('audit-*.png'):
  dest=OUT/'captures'/mode/f.name;dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(f,dest)
  frames[f.name]=hashlib.sha256(f.read_bytes()).hexdigest()
 evidence[mode]={'run':name,'modules':inputs['mods'],'cleanExits':exits,'records':records,'frames':frames}
def write(name,value):(OUT/name).write_text(json.dumps(value,indent=2)+'\n','utf8')
write('tested-payload.json',{'files':raw})
write('canonical-payload.json',{'policy':'LF-normalized text for Git; raw native hashes retained separately','files':canonical})
write('evidence.json',{'version':'0.3.4','game':'42.21.0','productionLuaScenarios':28,'compiledLuaFiles':59,'nativeApiContracts':37,'runs':evidence,'complete':len(evidence)==len(RUNS)})
print('Exported '+str(len(evidence))+' clean native optional-fleet runs; exact payload and original variant skin counts match.')
