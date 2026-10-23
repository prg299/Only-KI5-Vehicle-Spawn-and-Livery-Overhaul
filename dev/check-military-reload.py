"""Joined save/restart acceptance using persisted scene/vehicle identities."""
from pathlib import Path
import argparse,json,math
from native_lab import NativeLab,rows,ROOT

p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--baseline',required=True);p.add_argument('--continue-run',action='store_true');a=p.parse_args()
lab=NativeLab(a.run)
baseline=(ROOT/'build/native'/a.baseline).resolve()
if not baseline.is_relative_to(ROOT/'build/native'):raise ValueError('Baseline root')
assert json.loads((baseline/'server/exit.json').read_text())['exitCode']==0
summary=json.loads((baseline/'military-acceptance-summary.json').read_text())
protection=lab.server('local r={};local ps=getOnlinePlayers();for i=0,ps:size()-1 do local p=ps:get(i);p:setGodMod(true);r[#r+1]={name=p:getUsername(),dead=p:isDead(),god=p:isGodMod()} end;return r')
assert len(rows(protection))==2 and all(r['god'] and not r['dead'] for r in rows(protection))
lab.write('rejoined-players',protection)
variants=rows(json.loads((baseline/'variants-before-restart.json').read_text())['value'])
later_fixture_ids={v['sqlId'] for v in variants}
report=json.loads((lab.run/'military-reload-summary.json').read_text()) if a.continue_run else []
for item in summary:
    if 'story' not in item:continue
    name=item['story'];x,y=item['checkpoint']['x'],item['checkpoint']['y']
    if any(r.get('story')==name for r in report):continue
    lab.move(round(x),round(y+2))
    probe='OnlyKI5SceneX='+str(x)+';OnlyKI5SceneY='+str(y)+';'+(ROOT/'dev/probe-scene.lua').read_text()
    after=lab.server(probe)
    before=json.loads((baseline/(name.lower()+'-snapshots.json')).read_text())['server']
    expected=[v for v in rows(before['vehicles']) if abs(v['x']-x)<35 and abs(v['y']-y)<45]
    actual=rows(after['vehicles'])
    comparisons=[]
    for v in expected:
        assert v['sqlId']>=0,v
        hits=[n for n in actual if n['sqlId']==v['sqlId']]
        comparisons.append({'sqlId':v['sqlId'],'matches':len(hits),'same':len(hits)==1 and all(hits[0][k]==v[k] for k in ('script','skin'))})
    extra=[v for v in actual if v['sqlId'] not in {n['sqlId'] for n in expected}]
    assert len({v['sqlId'] for v in actual})==len(actual) and all(v['same'] for v in comparisons),(name,comparisons,actual)
    assert all(v['sqlId'] in later_fixture_ids for v in extra),('Unexpected new scene vehicle',extra)
    assert after['checkpoint']['state']=='done' and after['checkpoint']['story']==name,after
    peers=lab.snapshot(name.lower()+'-reloaded')
    for who in ('a','b'):
        seen=rows(peers[who]['vehicles'])
        for v in actual:
            authority=next(n for n in rows(peers['server']['vehicles']) if n['sqlId']==v['sqlId'])
            hits=[n for n in seen if n['id']==authority['id']]
            assert len(hits)==1 and all(hits[0][k]==authority[k] for k in ('script','skin','lights','siren')),(who,authority,hits)
    lab.capture(name.lower()+'-reloaded')
    report.append({'story':name,'checkpoint':after['checkpoint'],'baselineVehicles':len(expected),'laterFixturesInView':len(extra),'savedMatches':comparisons,'peersMatch':True})
    lab.write('military-reload-summary',report)
    print(name+': saved checkpoint, '+str(len(actual))+' vehicle identities and both peers preserved',flush=True)

lab.move(round(variants[0]['x']),round(variants[0]['y']))
vehicles=rows(lab.server((ROOT/'dev/snapshot.lua').read_text())['vehicles'])
names=json.loads((ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul/42/media/lua/shared/Translate/EN/IG_UI.json').read_text())
for who in ('a','b'):
    received=lab.client('local r={};for _,key in ipairs('+ '{'+','.join(json.dumps(k) for k in names)+'}'+') do r[key]=getText(key) end;return r',who)
    assert received==names,(who,received,names)
lab.write('native-variant-translations',{'keys':len(names),'bothClientsMatch':True,'names':names})
for index,v in enumerate(variants):
    hits=[n for n in vehicles if n['sqlId']==v['sqlId']]
    assert len(hits)==1 and all(hits[0][k]==v[k] for k in ('script','skin')),(v,hits)
    current=hits[0]
    ui=lab.mechanics(current,'variant-'+str(index+1)+'-reloaded')
    report.append({'variant':v['script'],'sqlId':v['sqlId'],'preserved':True,'ui':ui,'name':names['IGUI_VehicleName'+v['script'].split('.')[1]]})
    lab.write('military-reload-summary',report)
    print(v['script']+': saved vehicle, translated name and native mechanics UI passed',flush=True)
print('PASS: all four saved scenes, both native peers, four variant families and all 23 JSON names')
