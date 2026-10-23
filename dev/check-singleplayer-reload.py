"""Verify persisted silent police fixtures in a resumed, owned native SP world."""
import argparse,json
from native_lab import NativeLab,ROOT,rows

p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--baseline',required=True);a=p.parse_args()
lab=NativeLab(a.run)
baseline=(ROOT/'build/native'/a.baseline).resolve()
if not baseline.is_relative_to(ROOT/'build/native'):raise ValueError('Baseline root')
assert (baseline/'finished.json').is_file(),'Baseline must be stopped'
fixture=json.loads((baseline/'silent-lightbar-fixture.json').read_text())
snapshot=json.loads((baseline/'silent-lightbar-saved-vehicles.json').read_text())
ids={v['id'] for v in fixture['authority']}
expected=[v for v in rows(snapshot['vehicles']) if v['id'] in ids]
assert len(expected)==20 and all(v['sqlId']>=0 for v in expected),expected
status=json.loads(lab.client('return OnlyKI5NativeAudio.enableMutedProbe()','sp'))
assert status['masterMuted'] and not status['soundDisabled'],status
current=rows(lab.client((ROOT/'dev/snapshot.lua').read_text(),'sp')['vehicles'])
comparisons=[]
for v in expected:
    found=[n for n in current if n['sqlId']==v['sqlId']]
    assert len(found)==1,(v,found)
    actual=found[0]
    for key in ('script','skin','lights','siren','data'):assert actual[key]==v[key],(key,v,actual)
    assert actual['siren']==0
    audio=json.loads(lab.client('return OnlyKI5NativeAudio.inspect(getVehicleById('+str(actual['id'])+'))','sp'))
    assert not audio['sirenSounding'] and audio['emitterEmpty'],audio
    comparisons.append({'sqlId':v['sqlId'],'script':v['script'],'lights':actual['lights'],
                        'siren':actual['siren'],'savedDecisionPreserved':True,'audio':audio})
lab.write('singleplayer-reload-comparison',{'vehicles':20,'comparisons':comparisons,'output':status})
print('PASS: all 20 single-player police vehicles preserved; silent audio, skins, lights and decisions match')
