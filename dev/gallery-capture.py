"""Native photo fixtures in an already guarded disposable SP gallery world.

This produces screenshots, not gameplay acceptance. Use native-session.py first;
never point it at a real player profile. Photo lineups and selected story recipes
are explicitly staged. Natural checkpoint/highway vehicles remain unmodified.
"""
import argparse
import json
from pathlib import Path
import shutil
import time
from native_lab import NativeLab, ROOT, rows

p=argparse.ArgumentParser()
p.add_argument('run')
p.add_argument('scene',choices=['checkpoint','approach','traffic','police','lightbars','variants','variant-close','blockpost','convoy','biohazard'])
a=p.parse_args()
lab=NativeLab(a.run)
call=lambda code:lab.client(code,'sp')
assert a.run.startswith('gallery-'), 'Photo fixtures require a named gallery run'
assert call('return getPlayer() and not getPlayer():isDead()'), 'Living photo character required'
call((ROOT/'dev/gallery-photo.lua').read_text('utf-8'))
call('''local daylight=getClimateManager():getClimateFloat(ClimateManager.FLOAT_DAYLIGHT_STRENGTH)
daylight:setEnableOverride(true);daylight:setOverride(1,1)
local ambient=getClimateManager():getClimateFloat(ClimateManager.FLOAT_AMBIENT)
ambient:setEnableOverride(true);ambient:setOverride(1,1)
return true''')

def move(x,y):
    call(f'getPlayer():teleportTo({x},{y},0);return true')
    time.sleep(8)
    assert call(f'return getCell():getGridSquare({int(x)},{int(y)},0)~=nil')

def zoom(target):
    for _ in range(10):
        current=call('return getCore():getZoom(0)')
        if abs(current-target)<.02:break
        call('getCore():doZoomScroll(0,'+str(1 if current<target else -1)+');return true')
        time.sleep(.6)

if a.scene=='checkpoint':
    move(12573,4213);zoom(2)
elif a.scene=='approach':
    move(12535,4100);zoom(1.5)
elif a.scene=='traffic':
    move(12564,2395);zoom(1.5)
elif a.scene=='police':
    move(12684,5005);zoom(2)
    call('''local pending={};local it=getCell():getVehicles():iterator()
while it:hasNext() do local v=it:next()
 if v:getX()>12675 and v:getX()<12692 and v:getY()>4995 and v:getY()<5017 and
 v:hasLightbar() then pending[#pending+1]=v end end
for _,v in ipairs(pending) do v:permanentlyRemove() end;return #pending''')
    time.sleep(3)
    records=call('''OnlyKI5GalleryPolice={};local native=RandomizedWorldBase.new()
for i,name in ipairs({'92fordCVPIWestPoint','92fordCVPIMuldraugh','92fordCVPILouisville','92fordCVPIMeade'}) do
 local x,y=12679+((i-1)%2)*7,5000+math.floor((i-1)/2)*10
 local s=assert(getCell():getGridSquare(x,y,0))
 assert(not s:getBuilding() and s:isFree(false),'Lineup square is not open ground')
 assert(not s:isVehicleIntersecting(),'Occupied lineup footprint '..i..' at '..x..','..y)
 local v=assert(native:addVehicle(s:getZone(),x+.5,y+.5,0,0,'police','Base.'..name,nil,nil))
 v:repair();v:setLightbarSirenMode(0)
 OnlyKI5GalleryPolice[#OnlyKI5GalleryPolice+1]=v:getId()
end
return OnlyKI5GalleryPolice''')
    lab.write('gallery-police-fixture',{'staged':True,'vehicleIds':records})
    move(12685,5008)
elif a.scene=='variants':
    move(10598,9588);zoom(1.5)
    lab.write('gallery-variants-fixture',call((ROOT/'dev/spawn-variants.lua').read_text('utf-8')))
elif a.scene=='variant-close':
    move(10592,9573);zoom(2)
elif a.scene=='lightbars':
    move(12685,5008);zoom(2)
    records=call('''local out={};local it=getCell():getVehicles():iterator()
while it:hasNext() do local v=it:next()
 if v:getX()>12675 and v:getX()<12692 and v:getY()>4995 and v:getY()<5017 and v:hasLightbar() then
  v:repair();v:setLightbarLightsMode(2);v:setLightbarSirenMode(0)
  out[#out+1]={script=v:getScriptName(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode()}
 end end
getGameTime():setTimeOfDay(21)
getClimateManager():getClimateFloat(ClimateManager.FLOAT_DAYLIGHT_STRENGTH):setOverride(0,1)
getClimateManager():getClimateFloat(ClimateManager.FLOAT_AMBIENT):setOverride(.15,1)
return out''')
    assert len(rows(records))==4,records
    lab.write('gallery-lightbars-fixture',{'staged':True,'settings':records})
else:
    story,point={'blockpost':('MilitaryBlockpost',(12684,5228)),
                 'convoy':('MilitaryConvoy',(12684,5488)),
                 'biohazard':('BiohazardCrash',(12684,5616))}[a.scene]
    move(*point)
    prior=lab.run/('gallery-'+a.scene+'-fixture.json')
    if prior.exists():
        saved=json.loads(prior.read_text('utf-8'))
        selected,result=saved['selection'],saved['constructed']
    else:
        selected=call('OnlyKI5ForceStory='+json.dumps(story)+';'+(ROOT/'dev/force-story.lua').read_text('utf-8'))
        assert selected.get('selected'),selected
        result=lab.wait(lambda:call('return OnlyKI5ForcedStoryResult and OnlyKI5ForcedStoryResult.data'),
                        lambda r:r and r['state'] in ('done','failed','partial','blocked'), 'photo recipe')
    assert result['state']=='done',result
    # Freeze photo-only hostiles to avoid a moving foreground obscuring vehicles.
    call('''OnlyKI5PhotoFreeze=function() local z=getCell():getZombieList()
    for i=0,z:size()-1 do z:get(i):setUseless(true) end end
    Events.OnTick.Add(OnlyKI5PhotoFreeze);OnlyKI5PhotoFreeze();return true''')
    offset=(4,2) if a.scene=='blockpost' else (3,6)
    move(round(result['x'])+offset[0],round(result['y'])+offset[1]);zoom(2)
    lab.write('gallery-'+a.scene+'-fixture',{'staged':True,'selection':selected,'constructed':result})
call('ISUIHandler.setVisibleAllUI(false);MEMCNativeLab.holdKey(17,150);return true')
time.sleep(3)
capture=lab.invoke('native-command.py','capture','--name','gallery-'+a.scene+'-'+str(time.time_ns()))['result']
shutil.copy2(Path(capture),lab.run/'captures'/('gallery-'+a.scene+'.png'))
snapshot=call((ROOT/'dev/snapshot.lua').read_text('utf-8'))
lab.write('gallery-'+a.scene+'-snapshot',snapshot)
print('Native photo captured: '+a.scene,flush=True)
