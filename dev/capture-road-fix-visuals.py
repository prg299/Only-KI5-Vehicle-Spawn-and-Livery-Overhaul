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
x,y=round(target['x']+(5 if a.scene=='parked' else 4)),round(target['y']+(3 if a.scene=='parked' else 2))
if a.mp:lab.move(x,y)
else:
    call(f'getPlayer():teleportTo({x},{y},0);return true')
    lab.wait(lambda:call('local p=getPlayer();return {x=p:getX(),y=p:getY()}'),lambda s:abs(s['x']-x)<2 and abs(s['y']-y)<2,'photo observer teleport')
    time.sleep(5)
# Retakes may follow chunk unloading. Resolve a fresh native identity after
# streaming the recorded location instead of trusting a recycled runtime ID.
match="v:getModData().OnlyKI5RoadFixture=='truck'" if a.scene=='parked' else 'v:getLightbarLightsMode()>0'
target=call('local best,dist=nil,25;local it=getCell():getVehicles():iterator();while it:hasNext() do local v=it:next();local d=(v:getX()-'+str(target['x'])+')^2+(v:getY()-'+str(target['y'])+')^2;if v:getScriptName()=='+json.dumps(target['script'])+' and '+match+' and d<dist then best,dist=v,d end end;assert(best,"Native photo target missing");local v=best;return {id=v:getId(),x=v:getX(),y=v:getY(),script=v:getScriptName(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode()}')
if a.scene=='police':assert target['lights']>0 and target['siren']==0,target
records={}
for who in peers:
    # A regular joined guest must keep ordinary permissions. Photo visibility
    # grants CAN_SEE_EVERYONE and correctly triggers the server's Power check.
    # Use normal native visibility on both MP peers; never disable anti-cheat.
    if not a.mp:lab.client((ROOT/'dev/gallery-visibility.lua').read_text(),who)
    lab.client('MELensMedia.cameraOff();getGameTime():setTimeOfDay(12);getCore():setAutoZoom(0,false);ISUIHandler.allUIVisible=false;ISUIHandler.setVisibleAllUI(false);MEMCNativeLab.holdKey(17,100);GameWindow.doRenderEvent(true);return true',who)
    lab.client("getCore():setOptionZoomLevels1x('50;75;100;125;150;175;200');getCore():setOptionZoomLevels2x('50;75;100;125;150;175;200');getCore():zoomLevelsChanged();return true",who)
    for _ in range(8):
        zoom=lab.client('return getCore():getZoom(0)',who)
        if abs(zoom-1.5)<.03:break
        lab.client('getCore():doZoomScroll(0,'+str(1 if zoom<1.5 else -1)+');return true',who)
        time.sleep(.5)
    time.sleep(3)
    look_y=target['y']+(3 if a.scene=='parked' else 0)
    lab.client(f'getPlayer():faceLocation({target["x"]},{look_y});return true',who)
    time.sleep(2)
    records[who]=lab.client('local p=getPlayer();return {x=p:getX(),y=p:getY(),camera=MELensMedia.cameraInfo(),photoVisibility=p:isSeeEveryone()}',who)
    for phase in (1,2):
        lab.invoke('native-command.py','capture','--client',who,'--name',f'road-fixes-{a.scene}-{who}-{phase}')
        time.sleep(.25)
lab.write('road-fixes-visual-'+a.scene,{'target':target,'observers':records,'vehiclesModified':False,'nativeMovementInput':True})
if a.mp:
    names=rows(lab.server('local r={};local ps=getOnlinePlayers();for i=0,ps:size()-1 do r[#r+1]=ps:get(i):getUsername() end;return r'))
    assert set(names)=={'OnlyKI5Admin','OnlyKI5Guest'},'Both peers must stay joined during capture'
print('Captured '+a.scene+' on '+','.join(peers),flush=True)
