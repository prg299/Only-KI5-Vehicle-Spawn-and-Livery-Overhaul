"""Natural, default-abundance native audit frames; no vehicle mutations.

Only use inside a guarded native-session.py lifetime. Observer teleports and
debug visibility are explicit review fixtures, never part of the player mod.
"""
import argparse,json,shutil,time
from pathlib import Path
from native_lab import NativeLab,ROOT,rows

p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('location')
p.add_argument('--client',default='sp');p.add_argument('--frame',type=float,nargs=2);a=p.parse_args()
assert a.run.startswith(('spawn-audit-','optional-034-'))
lab=NativeLab(a.run);call=lambda code:lab.client(code,a.client)
locations=json.loads((ROOT/'config/workshop-gallery-locations.json').read_text('utf8'))
location=next(x for x in locations if x['key']==a.location)
if a.frame:location={**location,'frame':a.frame}
x,y=location['frame']
assert call('return getPlayer() and not getPlayer():isDead()')
assert call('return isIngameState()'),'Wait for world loading, then click to start before capturing'
assert call('return not OnlyKI5GalleryPolice and not OnlyKI5VariantFixture and not OnlyKI5ForcedStoryResult and not OnlyKI5HumveeFixture')
call('''getGameTime():setTimeOfDay(12)
getSearchMode():setOverrideSearchManager(0,true);getSearchMode():setEnabled(0,false)
getCore():setAutoZoom(0,false)
getCore():setOptionZoomLevels1x('50;75;100;125;150;175;200;225;250')
getCore():setOptionZoomLevels2x('50;75;100;125;150;175;200;225;250')
getCore():zoomLevelsChanged();ISUIHandler.allUIVisible=false;ISUIHandler.setVisibleAllUI(false)
return true''')
call((ROOT/'dev/gallery-visibility.lua').read_text('utf8'))
if a.client=='sp':call(f'getPlayer():teleportTo({x},{y},0);return true')
else:lab.move(x,y)
lab.wait(lambda:call(f'return getCell():getGridSquare({int(x)},{int(y)},0)~=nil'),bool,'natural location streaming')
time.sleep(7)
target=location['zoom']
for _ in range(12):
    current=call('return getCore():getZoom(0)')
    if abs(current-target)<.03:break
    call('getCore():doZoomScroll(0,'+str(1 if current<target else -1)+');return true');time.sleep(.3)
call('MEMCNativeLab.holdKey(17,100);return true')
look=location.get('lookAt',[x-8,y-8]);call(f'getPlayer():faceLocation({look[0]},{look[1]});return true')
time.sleep(2)
record=call('''local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local P=require 'OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy'
local result={vehicles={},carSpawnRate=SandboxVars.CarSpawnRate,
    suppressCustom=P.suppressionEnabled(),civilianWeightPercent=P.numberOption('CustomCivilianChance',.025),
    player={x=getPlayer():getX(),y=getPlayer():getY()},photoNoLighting=true,
    vehicleMutations=false,spawnFixtures=false}
local it=getCell():getVehicles():iterator()
while it:hasNext() do local v=it:next()
    if math.abs(v:getX()-getPlayer():getX())<80 and math.abs(v:getY()-getPlayer():getY())<80 then
        local name=v:getScriptName();local z=getVehicleZoneAt(math.floor(v:getX()),math.floor(v:getY()),0)
        result.vehicles[#result.vehicles+1]={script=name,skin=v:getSkinIndex(),sqlId=v:getSqlId(),
            x=v:getX(),y=v:getY(),zone=z and z:getName(),category=P.category(C,name),
            suppressed=P.suppressed(C,name),siren=v:getLightbarSirenMode(),lights=v:getLightbarLightsMode()}
    end
end
return result''')
record['location']=location;lab.write('audit-'+a.location+'-'+a.client,record)
if not a.frame:
    wanted='emergency' if location['category']=='regional-police' else 'military' if location['category']=='military' else 'everyday'
    candidates=[v for v in rows(record['vehicles']) if v['category']==wanted and abs(v['x']-x)<45 and abs(v['y']-y)<45]
    if candidates:
        hero=min(candidates,key=lambda v:(v['x']-x)**2+(v['y']-y)**2)
        # Move only the observer to frame an already generated vehicle.
        fx,fy=hero['x']+3,hero['y']+5
        if a.client=='sp':call(f'getPlayer():teleportTo({fx},{fy},0);return true')
        else:lab.move(round(fx),round(fy))
        call(f"getPlayer():faceLocation({hero['x']},{hero['y']});return true");time.sleep(2)
        record['player']=call('return {x=getPlayer():getX(),y=getPlayer():getY()}')
        record['observerReframedToNaturalVehicle']={'script':hero['script'],'sqlId':hero['sqlId'],'x':hero['x'],'y':hero['y']}
        lab.write('audit-'+a.location+'-'+a.client,record)
name='audit-'+a.location+'-'+a.client
source=Path(lab.invoke('native-command.py','capture','--client',a.client,'--name',name)['result'])
print(json.dumps(dict(capture=str(source),vehicles=len(rows(record['vehicles'])),
    suppressed=[v['script'] for v in rows(record['vehicles']) if v['suppressed']],
    categories=dict(__import__('collections').Counter(v['category'] for v in rows(record['vehicles']))),
    carSpawnRate=record.get('carSpawnRate'))))
