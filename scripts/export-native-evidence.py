"""Export only whitelisted acceptance receipts and unmodified native frames.

Raw profiles, command queues, logs and credentials must stay under ignored build/.
This is the dated 2026-10-23 release evidence, not a new gameplay test.
"""
from pathlib import Path
import hashlib,json,shutil

ROOT=Path(__file__).resolve().parents[1]
NATIVE=ROOT/'build/native'
OUT=ROOT/'docs/validation/native-20261023'
RUNS={
    'sp_initial':'full-fleet-20261023-c',
    'mp_initial':'multiplayer-20261023-b',
    'mp_police_reload':'multiplayer-20261023-c-reload',
    'mp_military':'multiplayer-20261023-f-final',
    'mp_military_reload':'multiplayer-20261023-g-acceptance-reload',
    'sp_silent':'singleplayer-20261023-h-silent',
    'sp_reload':'singleplayer-20261023-i-reload',
}

def read(role,name):return json.loads((NATIVE/RUNS[role]/name).read_text())
def write(name,value):(OUT/name).write_text(json.dumps(value,indent=2)+'\n')
def rows(value):return list(value.values()) if isinstance(value,dict) else value

OUT.mkdir(parents=True,exist_ok=True)
catalog=read('mp_military','final-catalog-audit.json')['value']
assert catalog['scripts']==531 and not catalog['missing']
military=read('mp_military','military-acceptance-summary.json')
reload=read('mp_military_reload','military-reload-summary.json')
mp_silent=read('mp_military_reload','silent-lightbar-audio.json')
sp_silent=read('sp_silent','silent-lightbar-audio.json')
sp_reload=read('sp_reload','singleplayer-reload-comparison.json')
translations=read('mp_military_reload','native-variant-translations.json')
assert sp_silent['nativeAudioManagerVerified'] and sp_reload['vehicles']==20
assert translations['bothClientsMatch'] and translations['keys']==23
mp_emitters={}
for peer in ('a','b'):
    positive=[v for v in mp_silent['positiveControl'][peer] if v['siren']>0]
    assert len(positive)==1
    on=positive[0];off=next(v for v in mp_silent['after'][peer] if v['id']==on['id'])
    assert on['audioManagerPresent'] and on['emitterEmpty'] is False
    assert off['emitterEmpty'] and off['siren']==0 and not off['sounding'] and off['lights']>0
    mp_emitters[peer]={'positiveControl':on,'afterPolicy':off,'nativeEmitterVerified':True}

evidence={'version':'0.3.1','date':'2026-10-23',
    'game':{'version':'42.21.0','revision':'4a0e9546ec','steamBuild':25485521},
    'runs':RUNS,'catalog':catalog,'militaryAcceptance':military,'militaryReload':reload,
    'policePeerComparison':read('mp_initial','police-peer-comparison.json'),
    'policeSavedComparison':read('mp_police_reload','saved-police-comparison.json'),
    'policeRejoinedPeerComparison':read('mp_police_reload','reloaded-peer-comparison.json'),
    'stationFixture':read('mp_initial','station-parking-result.json')['value'],
    'singlePlayerSilentAudio':sp_silent,'singlePlayerReload':sp_reload,
    'multiplayerSilentSiren':mp_silent,'multiplayerEmitterComparison':mp_emitters,'translations':translations,
    'flashing':{'mpA':read('mp_initial','flash-frames-a.json'),
                'mpB':read('mp_initial','flash-frames-b.json'),
                'sp':read('sp_reload','flash-frames-sp.json')},
    'limits':['Loopback non-Steam dedicated transport',
              'Forced story selection proves native construction, not natural frequency',
              'Pool shares and small area samples are not population frequency estimates',
              'Armor registration and mechanics UI do not prove every armor installation',
              'No trailer-driving, long-run benchmark or human listening acceptance'],
    'cleanExits':{}}
for role in ('mp_initial','mp_police_reload','mp_military','mp_military_reload','sp_silent','sp_reload'):
    run=NATIVE/RUNS[role]
    assert (run/'finished.json').is_file(),('Run still active',role)
    clients=('a','b') if role.startswith('mp_') else ('sp',)
    exits={}
    for client in clients:
        receipt=json.loads((run/client/'native-session-exit.json').read_text())
        assert receipt['exitCode']==0,(role,client,receipt['exitCode'])
        exits[client]={'exitCode':0,'keeperInJob':receipt['keeperInJob'],
                       'gameInJob':receipt['gameInJob'],'desktopSwitched':receipt['desktopSwitched']}
    if role.startswith('mp_'):
        exits['server']=json.loads((run/'server/exit.json').read_text())
        assert exits['server']['exitCode']==0
    evidence['cleanExits'][role]=exits
write('evidence.json',evidence)

tested={role:{k.replace('\\','/'):v for k,v in read(role,'inputs.json')['payload'].items()}
        for role in ('mp_initial','mp_military','mp_military_reload','sp_silent','sp_reload')}
current={p.relative_to(ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul').as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
         for p in (ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul').rglob('*') if p.is_file()}
assert current==tested['sp_silent']==tested['sp_reload'],'Final source differs from native SP candidate'
write('tested-payloads.json',tested)
# Git checks out text as LF; preserve raw native hashes and document that boundary.
mod=ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
text_types={'.lua','.txt','.info','.md','.json'}
canonical={p.relative_to(mod).as_posix():hashlib.sha256(
    p.read_bytes().replace(b'\r\n',b'\n') if p.suffix in text_types else p.read_bytes()).hexdigest()
    for p in mod.rglob('*') if p.is_file()}
write('canonical-payload.json',{'policy':'LF-normalized text for Git; native raw hashes remain in tested-payloads.json',
                              'files':canonical})
stage=ROOT/'build/workshop/OnlyKI5VehicleSpawnLiveryOverhaul'
assert json.loads((stage/'payload-manifest.json').read_text())==current
package=stage/'Contents/mods/OnlyKI5VehicleSpawnLiveryOverhaul'
staged={p.relative_to(package).as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
        for p in package.rglob('*') if p.is_file()}
assert staged==current,'Staged payload differs from tested source'
write('external-input-fingerprints.json',read('mp_military','input-fingerprints.json'))

images={
    'checkpoint-camo.png':NATIVE/RUNS['sp_initial']/'captures/checkpoint-lighting-diagnostic.png',
    'mcv-ambulance-mechanics.png':NATIVE/RUNS['mp_military_reload']/'captures/variant-2-reloaded-a.png',
}
for role,prefix,folder,report in (
    ('mp_initial','police-multiplayer','a/home/Zomboid/Screenshots/clip-police-powered-a',evidence['flashing']['mpA']),
    ('sp_reload','police-singleplayer','sp/home/Zomboid/Screenshots/clip-silent-sp-visible',evidence['flashing']['sp'])):
    for colour,key in (('blue','mostBlue'),('red','mostRed')):
        images[prefix+'-'+colour+'.jpg']=NATIVE/RUNS[role]/folder/report[key]['file']
manifest={}
for name,source in images.items():
    shutil.copy2(source,OUT/name)
    manifest[name]={'sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'bytes':source.stat().st_size,
                    'nativeRun':next(v for v in RUNS.values() if v in source.parts),
                    'unmodified':True}
write('images.json',manifest)
print('Exported dated native receipts, payload fingerprints and six unmodified gameplay frames; no logs or credentials.')
