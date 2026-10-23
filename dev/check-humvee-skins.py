"""Focused native new-spawn, authority/peer and persisted-livery verification.

Explicit construction fixtures are separate from the natural checkpoint sample.
Run through run-heavy inside an owned native-session lifetime.
"""
import argparse,json,time
from native_lab import NativeLab,ROOT,rows
from native_paths import owned_run

p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--single-player',action='store_true')
p.add_argument('--baseline');a=p.parse_args()
lab=NativeLab(a.run);who='sp' if a.single_player else 'a'
call=(lambda code:lab.client(code,'sp')) if a.single_player else lab.server
KEY='OnlyKI5VehicleSpawnLiveryOverhaul.HumveeSkinV1'
snapshot=(ROOT/'dev/snapshot.lua').read_text()
pool_shares=call('''local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog';local out={}
for _,name in ipairs({'military','military_vehicle_light','modified_trfjm'}) do
 local pool=VehicleZoneDistribution[name];local total,humvee=0,0
 for _,id in ipairs(C.groups.militaryCar) do
  local entry=pool and pool.vehicles and pool.vehicles[id]
  local weight=entry and entry.spawnChance or 0;total=total+weight
  if id=='Base.92amgeneralM998' then humvee=weight end
 end
 assert(total>0,name);out[name]=humvee/total
end
return out''')
assert all(abs(value-.95)<.000001 for value in pool_shares.values()),pool_shares
def move(x,y):
    if a.single_player:
        lab.client(f'getPlayer():teleportTo({x},{y},0);return true','sp')
        lab.wait(lambda:call(f'return getCell():getGridSquare({x},{y},0)~=nil'),bool,'SP streaming')
        time.sleep(6)
    else:lab.move(x,y)

if a.baseline:
    expected=json.loads((owned_run(a.baseline)/'humvee-skins.json').read_text())['fixture']
    move(12558,2042)
    current=rows(call(snapshot)['vehicles'])
    fixture=[]
    for old in expected:
        matches=[v for v in current if v['sqlId']==old['sqlId']]
        assert len(matches)==1,(old,matches)
        v=matches[0]
        assert all(v[k]==old[k] for k in ('script','skin','data')),(old,v)
        fixture.append(v)
    natural=[]
else:
    move(12550,4213)
    natural=[v for v in rows(call(snapshot)['vehicles']) if v['script']=='Base.92amgeneralM998']
    assert natural,'No naturally generated checkpoint Humvees'
    assert all(v['skin']==v['data'].get(KEY) for v in natural),natural
    move(12558,2042)
    result=call('''
assert(not isClient())
if OnlyKI5HumveeFixture then
 local found={};local it=getCell():getVehicles():iterator()
 while it:hasNext() do local v=it:next();if v:getModData()['OnlyKI5Acceptance.HumveeFixture'] then found[#found+1]=v:getId() end end
 return found
end
OnlyKI5HumveeFixture={}
local p=isServer() and getOnlinePlayers():get(0) or getPlayer()
local native=RandomizedWorldBase.new()
for dx=-24,24,8 do
 for dy=-24,24,12 do
  local x,y=math.floor(p:getX())+dx+.5,math.floor(p:getY())+dy+.5
  local sq=getCell():getGridSquare(math.floor(x),math.floor(y),0)
  if sq and not sq:getBuilding() and not sq:isWaterSquare() and sq:isFree(false) and not sq:isVehicleIntersecting() then
   local v=native:addVehicle(sq:getZone(),x,y,0,0,'military','Base.92amgeneralM998',nil,nil)
   if v then v:getModData()['OnlyKI5Acceptance.HumveeFixture']=true;OnlyKI5HumveeFixture[#OnlyKI5HumveeFixture+1]=v:getId() end
  end
  if #OnlyKI5HumveeFixture>=20 then break end
 end
 if #OnlyKI5HumveeFixture>=20 then break end
end
return OnlyKI5HumveeFixture''')
    ids=set(rows(result));assert len(ids)==20,result
    fixture=[v for v in rows(call(snapshot)['vehicles']) if v['id'] in ids]
    assert len(fixture)==20 and all(v['skin']==v['data'].get(KEY) for v in fixture),fixture
    assert all(v['created'] for v in fixture),'Native creation not finalized'
    # Real callbacks on already-created vehicles must preserve the skin/data.
    call('for _,id in ipairs(OnlyKI5HumveeFixture) do triggerEvent("OnSpawnVehicleStart",getVehicleById(id)) end;return true')
    after={v['id']:v for v in rows(call(snapshot)['vehicles']) if v['id'] in ids}
    assert all(all(after[v['id']][k]==v[k] for k in ('script','skin','data')) for v in fixture)

comparisons=[]
if not a.single_player:
    time.sleep(5)
    for peer in ('a','b'):
        current=rows(lab.client(snapshot,peer)['vehicles'])
        for v in fixture:
            found=[r for r in current if r['id']==v['id']]
            assert len(found)==1 and found[0]['skin']==v['skin'],(peer,v,found)
            comparisons.append(dict(peer=peer,id=v['id'],skin=v['skin'],matches=True))
if a.single_player:call('save(true);return true')
else:lab.client("SendCommandToServer('/save');return true")
time.sleep(3)
current=rows(call(snapshot)['vehicles']);ids={v['id'] for v in fixture}
fixture=[v for v in current if v['id'] in ids]
assert len(fixture)==20 and all(v['sqlId']>=0 for v in fixture),fixture
histogram={}
for v in fixture:histogram[str(v['skin'])]=histogram.get(str(v['skin']),0)+1
report=dict(singlePlayer=a.single_player,baseline=a.baseline,natural=natural,fixture=fixture,
    humveeVehiclePoolShares=pool_shares,
    peerComparisons=comparisons,fixtureHistogram=histogram,weights=dict(standard=95,medic=4,jtf=1),
    observedNaturalSeparately=True,frequencyProvenByExhaustivePolicyFixture=True)
lab.write('humvee-skins',report)
lab.invoke('native-command.py','capture','--client',who,'--name','humvee-skins')
print('PASS: '+str(len(natural))+' natural Humvees; 20 native fixture liveries; '+str(len(comparisons))+' peer comparisons; '+('persisted restart matches' if a.baseline else 'saved-vehicle callback leaves skins/data intact'))
