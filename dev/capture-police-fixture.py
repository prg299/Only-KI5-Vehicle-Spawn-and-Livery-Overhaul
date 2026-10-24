"""Frame a tested native fixture from outside, with living owned observers."""
import argparse,json,time
from native_lab import NativeLab,ROOT
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run)
report=json.loads((lab.run/'audit-configurable-spawns.json').read_text())
v=next(v for v in report['policeBoundaries']['100']['authority'] if v['lights']>0)
target=lab.server("""local v=getVehicleById(%d);assert(v and v:getLightbarLightsMode()>0)
local offsets={{-4,-6},{-6,-4},{4,-4},{-4,4},{4,6},{6,4}}
for _,o in ipairs(offsets) do local x=math.floor(v:getX()+o[1]);local y=math.floor(v:getY()+o[2]);local s=getCell():getGridSquare(x,y,0)
if s and not s:getBuilding() and s:isFree(false) then return {x=x,y=y,vx=v:getX(),vy=v:getY(),script=v:getScriptName(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode()} end end
error('No outdoor observer square')"""%v['id'])
lab.client(f"SendCommandToServer('/teleportto {target['x']},{target['y']},0');return true",'b')
lab.wait(lambda:lab.client('local p=getPlayer();return {x=p:getX(),y=p:getY()}','b'),lambda r:abs(r['x']-target['x'])<4 and abs(r['y']-target['y'])<4,'living photo-admin teleport')
time.sleep(7)
for who in ('b',):
    assert lab.client('return getPlayer() and not getPlayer():isDead() and isIngameState()',who)
    lab.client('local p=getPlayer();p:setGodMod(true);getGameTime():setTimeOfDay(12);getCore():setAutoZoom(0,false);ISUIHandler.allUIVisible=false;ISUIHandler.setVisibleAllUI(false);return true',who)
    lab.client((ROOT/'dev/gallery-visibility.lua').read_text(),who)
    lab.client(f"getPlayer():faceLocation({target['vx']},{target['vy']});return true",who)
    for _ in range(10):
        zoom=lab.client('return getCore():getZoom(0)',who)
        if abs(zoom-2)<.03:break
        lab.client('getCore():doZoomScroll(0,'+str(1 if zoom<2 else -1)+');return true',who);time.sleep(.3)
    time.sleep(1)
    lab.invoke('native-command.py','capture','--client',who,'--name','audit-police-100-fixture-'+who)
    time.sleep(.35)
    lab.invoke('native-command.py','capture','--client',who,'--name','audit-police-100-fixture-phase2-'+who)
target['observers']= {who:lab.client('return {dead=getPlayer():isDead(),x=getPlayer():getX(),y=getPlayer():getY(),access=getPlayer():getAccessLevel()}',who) for who in ('b',)}
lab.write('audit-police-fixture-photo',target)
print(json.dumps(target))
