"""Small-fleet native server/two-client acceptance, owned by native-session.py."""
import json,subprocess,sys,time
from native_lab import NativeLab,ROOT,rows
run=sys.argv[1];lab=NativeLab(run)
def invoke(tool,*args):subprocess.run([sys.executable,str(ROOT/'dev'/tool),run,*args],cwd=ROOT,check=True)
for who in ('a','b'):invoke('native-mp-connect.py',who)
invoke('check-optional-fleet.py','--server')
authority=json.loads((lab.run/'optional-fleet-authority.json').read_text())
code=(ROOT/'dev/optional-fleet-snapshot.lua').read_text()
peers={}
for who in ('a','b'):
 data=lab.client(code,who)
 assert data['available']==authority['available']
 expected={v['name']:v for v in rows(authority['variants'])}
 for v in rows(data['variants']):assert all(v[k]==expected[v['name']][k] for k in ('enabled','skins','parts','available')),(who,v)
 peers[who]={'available':data['available'],'variants':data['variants'],'authority':False}
lab.write('optional-fleet-client-schemas',peers)
invoke('check-spawn-pool-multiplayer.py','--allow-empty')
invoke('check-silent-lightbars.py')
# Explicit visual fixture on an actual asphalt road, after all natural samples.
lab.move(12598,1788)
fixture=lab.server("""local native=RandomizedWorldBase.new();local old=SandboxVars.OnlyKI5.PoliceLightsChance;SandboxVars.OnlyKI5.PoliceLightsChance=100
local found
for dx=-8,8,4 do for dy=-8,8,4 do if not found and (math.abs(dx)+math.abs(dy)>3) then
 local x,y=12598+dx,1788+dy;local s=getCell():getGridSquare(x,y,0)
 local floor=s and s:getFloor();local sprite=floor and floor:getSprite();local name=sprite and sprite:getName() or ''
 if string.find(name,'street',1,true) and s:isFree(false) and not s:isVehicleIntersecting() then
  local v=native:addVehicle(s:getZone(),x+.5,y+.5,0,0,'police','Base.92fordCVPILouisville',nil,nil)
  if v and v:isCreated() and v:getId()>=0 and v:getLightbarLightsMode()>0 then
   found={id=v:getId(),x=v:getX(),y=v:getY(),script=v:getScriptName(),skin=v:getSkinIndex(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode(),floor=name}
  end
 end
end end end
SandboxVars.OnlyKI5.PoliceLightsChance=old;assert(found,'No valid open-road lightbar fixture');return found""")
assert fixture['siren']==0 and fixture['lights']>0
for who in ('a','b'):
 seen=lab.wait(lambda:lab.client('local v=getVehicleById('+str(fixture['id'])+');return v and {script=v:getScriptName(),skin=v:getSkinIndex(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode(),parts=v:getPartCount()}',who),lambda r:r and all(r[k]==fixture[k] for k in ('script','skin','lights','siren')),'fresh optional police fixture '+who)
 assert seen['parts']>0
lab.move(round(fixture['x']+3),round(fixture['y']+3))
assert lab.client('return not getPlayer():isDead()')
lab.client((ROOT/'dev/gallery-visibility.lua').read_text())
lab.client('getGameTime():setTimeOfDay(12);ISUIHandler.allUIVisible=false;ISUIHandler.setVisibleAllUI(false);getCore():setAutoZoom(0,false);return true')
lab.client(f"getPlayer():faceLocation({fixture['x']},{fixture['y']});return true")
for _ in range(12):
 zoom=lab.client('return getCore():getZoom(0)')
 if abs(zoom-1.5)<.03:break
 lab.client('getCore():doZoomScroll(0,'+str(1 if zoom<1.5 else -1)+');return true');time.sleep(.3)
time.sleep(4)
for phase in range(2):
 lab.invoke('native-command.py','capture','--client','a','--name','audit-optional-police-a-'+str(phase+1));time.sleep(.35)
fixture['visualAcceptance']='Frames require human review; explicit construction is excluded from natural samples'
lab.write('optional-fleet-police-photo',fixture)
invoke('check-optional-fleet.py','--server')
lab.write('optional-fleet-acceptance',{'menuOnly':False,'checks':'Partial native server registry, 57 client/server variant schemas, natural vehicle peer states, silent-siren positive control and explicit asphalt-road visual fixture','transport':'No-Steam loopback; not a production Steam-hosting claim'})
invoke('native-command.py','stop')
print('OPTIONAL_FLEET_MULTIPLAYER_ACCEPTED',flush=True)
