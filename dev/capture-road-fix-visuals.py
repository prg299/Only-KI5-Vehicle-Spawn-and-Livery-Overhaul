"""Native frames of the owned fixtures; never modifies vehicles or player payload."""
import argparse,json,time
from native_lab import NativeLab,ROOT,rows
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--mp',action='store_true');p.add_argument('--scene',choices=('parked','police'),required=True)
a=p.parse_args();lab=NativeLab(a.run);peers=('a','b') if a.mp else ('sp',)
call=lab.server if a.mp else lambda code:lab.client(code,'sp')
if a.scene=='parked':
    source=json.loads((lab.run/'road-fixes-physics.json').read_text())['authority']
    target=next(v for v in rows(source) if v['fixture']=='truck')
else:
    source=json.loads((lab.run/'silent-lightbar-fixture.json').read_text())['authority']
    target=next(v for v in rows(source) if v['lights']>0)
target=call('local v=getVehicleById('+str(target['id'])+');assert(v);return {id=v:getId(),x=v:getX(),y=v:getY(),script=v:getScriptName(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode()}')
if a.scene=='police':assert target['lights']>0 and target['siren']==0,target
x,y=round(target['x']+2),round(target['y']+2)
if a.mp:lab.move(x,y)
else:
    call(f'getPlayer():teleportTo({x},{y},0);return true')
    lab.wait(lambda:call('local p=getPlayer();return {x=p:getX(),y=p:getY()}'),lambda s:abs(s['x']-x)<2 and abs(s['y']-y)<2,'photo observer teleport')
    time.sleep(5)
records={}
for who in peers:
    lab.client((ROOT/'dev/gallery-visibility.lua').read_text(),who)
    lab.client('MELensMedia.cameraOff();getGameTime():setTimeOfDay(12);getCore():setAutoZoom(0,false);ISUIHandler.allUIVisible=false;ISUIHandler.setVisibleAllUI(false);MEMCNativeLab.holdKey(17,100);GameWindow.doRenderEvent(true);return true',who)
    lab.client("getCore():setOptionZoomLevels1x('50;75;100;125;150;175;200');getCore():setOptionZoomLevels2x('50;75;100;125;150;175;200');getCore():zoomLevelsChanged();return true",who)
    for _ in range(8):
        zoom=lab.client('return getCore():getZoom(0)',who)
        if abs(zoom-1.5)<.03:break
        lab.client('getCore():doZoomScroll(0,'+str(1 if zoom<1.5 else -1)+');return true',who)
        time.sleep(.5)
    time.sleep(3)
    lab.client(f'getPlayer():faceLocation({target["x"]},{target["y"]});return true',who)
    time.sleep(2)
    records[who]=lab.client('local p=getPlayer();return {x=p:getX(),y=p:getY(),camera=MELensMedia.cameraInfo(),photoVisibility=true}',who)
    for phase in (1,2):
        lab.invoke('native-command.py','capture','--client',who,'--name',f'road-fixes-{a.scene}-{who}-{phase}')
        time.sleep(.25)
lab.write('road-fixes-visual-'+a.scene,{'target':target,'observers':records,'vehiclesModified':False,'nativeMovementInput':True})
print('Captured '+a.scene+' on '+','.join(peers),flush=True)
