"""Observe/capture natural vehicles at recorded map locations; no spawn fixtures.

Run through the resource guard inside an owned native-session.py lifetime.
Never calls the old gallery-capture.py or modifies any vehicle, zone or recipe.
"""
import argparse,json,shutil,time
from pathlib import Path
from native_lab import NativeLab,ROOT,rows

p=argparse.ArgumentParser()
p.add_argument('run');p.add_argument('location');p.add_argument('--probe',action='store_true')
p.add_argument('--frame',type=float,nargs=2);p.add_argument('--zoom',type=float)
a=p.parse_args()
assert a.run.startswith('gallery-') and 'natural' in a.run
lab=NativeLab(a.run)
call=lambda code:lab.client(code,'sp')
locations=json.loads((ROOT/'config/workshop-gallery-locations.json').read_text('utf-8'))
location=next(x for x in locations if x['key']==a.location)
assert call('return getPlayer() and not getPlayer():isDead()')
assert call('return not OnlyKI5GalleryPolice and not OnlyKI5VariantFixture and not OnlyKI5ForcedStoryResult and not OnlyKI5HumveeFixture'), 'Staged fixtures must not enter a natural photo session'
call('''getGameTime():setTimeOfDay(12)
local p=getPlayer();p:dressInNamedOutfit('Police')
getCore():setAutoZoom(0,false)
getSearchMode():setOverrideSearchManager(0,true)
getSearchMode():setEnabled(0,false)
getCore():setOptionZoomLevels1x('50;75;100;125;150;175;200;225;250')
getCore():setOptionZoomLevels2x('50;75;100;125;150;175;200;225;250')
getCore():zoomLevelsChanged()
getZomboidRadio():setDisableBroadcasting(true)
local ds=getZomboidRadio():getDevices()
for i=0,ds:size()-1 do pcall(function() ds:get(i):getDeviceData():setIsTurnedOn(false) end) end
ISUIHandler.allUIVisible=false;ISUIHandler.setVisibleAllUI(false)
return true''')
call((ROOT/'dev/gallery-visibility.lua').read_text('utf-8'))
x,y=a.frame or location['probe' if a.probe else 'frame']
call(f'getPlayer():teleportTo({x},{y},0);return true')
lab.wait(lambda:call(f'return getCell():getGridSquare({int(x)},{int(y)},0)~=nil'),bool,'natural area streaming')
time.sleep(8)
call('MELensMedia.cameraOff();return true')
observer={'x':x,'y':y}
target=a.zoom or location['zoom']
for _ in range(12):
    current=call('return getCore():getZoom(0)')
    if abs(current-target)<.03:break
    call('getCore():doZoomScroll(0,'+str(1 if current<target else -1)+');return true')
    time.sleep(.5)
call('ISUIHandler.setVisibleAllUI(false);MEMCNativeLab.holdKey(17,100);return true')
if location.get('lookAt'):
    look_x,look_y=location['lookAt']
    call(f'getPlayer():faceLocation({look_x},{look_y});return true')
time.sleep(3)
snapshot=call((ROOT/'dev/snapshot.lua').read_text('utf-8'))
near=[v for v in rows(snapshot['vehicles']) if abs(v['x']-x)<65 and abs(v['y']-y)<65]
record=dict(location=location,frame=[x,y],zoom=call('return getCore():getZoom(0)'),photoVisibilityReveal=True,
            carSpawnRate=call('return SandboxVars.CarSpawnRate'),nativePhotoNoLighting=True,
            staged=False,vehicleMutations=False,spawnFixtureCalled=False,nearbyVehicles=near,
            player=snapshot['player'])
record['observer']=observer
record['lookAt']=location.get('lookAt')
lab.write('natural-'+a.location+('-probe' if a.probe else ''),record)
name='natural-'+a.location+'-'+str(time.time_ns())
source=Path(lab.invoke('native-command.py','capture','--name',name)['result'])
target=lab.run/'captures'/('natural-'+a.location+('-probe' if a.probe else '')+'.png')
shutil.copy2(source,target)
interesting=[v for v in near if any(word in v['script'].lower() for word in ('police','pd','ksp','meade','sheriff','security','prison','ambulance','fire','postal','fossoil','mccoy'))]
print(json.dumps(dict(location=a.location,vehicleCount=len(near),featuredCandidates=[{k:v.get(k) for k in ('script','x','y','skin','zone')} for v in (interesting or near)[:25]],capture=target.name)))
