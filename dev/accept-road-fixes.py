"""SP or dedicated/two-client controls within the owned native lifetime."""
import argparse,hashlib,json,subprocess,sys,time
from native_lab import NativeLab,ROOT,rows
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--mp',action='store_true');a=p.parse_args();lab=NativeLab(a.run)
def invoke(tool,*args):subprocess.run([sys.executable,str(ROOT/'dev'/tool),a.run,*args],cwd=ROOT,check=True)
if a.mp:
    for who in ('a','b'):invoke('native-mp-connect.py',who)
    lab.move(12558,2042)
    call=lab.server;peers=('a','b')
else:
    invoke('native-command.py','lua','--file',str(ROOT/'dev/new-world.lua'));invoke('start-sp-world.py')
    call=lambda code:lab.client(code,'sp');peers=('sp',)
    call('getPlayer():teleportTo(12558,2042,0);return true')
    lab.wait(lambda:call('return getCell():getGridSquare(12558,2042,0)~=nil'),bool,'SP streaming')
    time.sleep(5)
invoke('check-optional-fleet.py',*(['--server'] if a.mp else []))
baseline=call((ROOT/'dev/probe-road-fixes.lua').read_text())
lab.write('road-fixes-baseline',baseline)
print('ROAD_FIX_NATIVE_BASELINE '+json.dumps({'rejectedSemis':len(rows(baseline['rejectedSemis'])),'rates':baseline['rates']}),flush=True)
truck=next(v for v in rows(baseline['physics']) if v['fixture']=='truck')
observer_x,observer_y=round(truck['x']+5),round(truck['y']+5)
# Keep both fixtures in the observer's loaded core. Runtime IDs can be reused
# after chunk unloading; compare the tagged native objects, never an old ID.
if a.mp:lab.move(observer_x,observer_y)
else:call(f'getPlayer():teleportTo({observer_x},{observer_y},0);return true');time.sleep(3)
time.sleep(12)
probe="local r={};local it=getCell():getVehicles():iterator();while it:hasNext() do local v=it:next();if v:getModData().OnlyKI5RoadFixture then r[#r+1]={id=v:getId(),sqlId=v:getSqlId(),fixture=v:getModData().OnlyKI5RoadFixture,script=v:getScriptName(),x=v:getX(),y=v:getY(),z=v:getZ(),speed=v:getCurrentSpeedKmHour(),parts=v:getPartCount()} end end;return r"
authority=rows(call(probe));assert len(authority)==2,authority
lab.write('road-fixes-physics-after',authority)
old={v['fixture']:v for v in rows(baseline['physics'])}
for v in authority:
    assert v['script']==old[v['fixture']]['script']
    assert abs(v['x']-old[v['fixture']]['x'])<2 and abs(v['y']-old[v['fixture']]['y'])<2 and abs(v['z'])<1,v
    assert abs(v['speed'])<5 and v['parts']>0,v
matches={}
fresh_ids=','.join('['+str(v['id'])+']='+json.dumps(v['fixture']) for v in authority)
peer_probe="local r={};for id,tag in pairs({"+fresh_ids+"}) do local v=getVehicleById(id);if v then r[#r+1]={id=id,fixture=tag,script=v:getScriptName(),x=v:getX(),y=v:getY(),z=v:getZ(),parts=v:getPartCount()} end end;return r"
for who in peers:
    seen=lab.wait(lambda:rows(lab.client(peer_probe,who)),lambda vs:len(vs)==2,'parked vehicles on '+who)
    for v in seen:
        expected=next(s for s in authority if s['fixture']==v['fixture'])
        assert v['script']==expected['script'] and abs(v['x']-expected['x'])<2 and abs(v['y']-expected['y'])<2 and abs(v['z'])<1,(who,v)
    matches[who]=seen
lab.write('road-fixes-physics',{'seconds':12,'authority':authority,'peers':matches})
invoke('capture-road-fix-visuals.py',*(['--mp'] if a.mp else []),'--scene','parked')
# Use a separate broad asphalt area for five disjoint replacement footprints.
# A tighter truck parking lot need not have enough room for these test cars.
if a.mp:lab.move(12558,2322)
else:
    call('getPlayer():teleportTo(12558,2322,0);return true')
    lab.wait(lambda:call('return getCell():getGridSquare(12558,2322,0)~=nil'),bool,'alias fixture streaming')
    time.sleep(5)
aliases=rows(call((ROOT/'dev/probe-native-aliases.lua').read_text()))
assert len(aliases)==5
lab.write('road-fixes-aliases',aliases)
print('PASS: five separated native McCoy/ordinary replacements',flush=True)
invoke('check-silent-lightbars.py',*([] if a.mp else ['--single-player']))
invoke('capture-road-fix-visuals.py',*(['--mp'] if a.mp else []),'--scene','police')
if a.mp:invoke('check-spawn-pool-multiplayer.py','--allow-empty')
frames={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in (lab.run/'captures').glob('road-fixes-*.png')}
lab.write('road-fixes-frames-ready',{'frames':frames,'reviewRequired':True})
print('ROAD_FIX_VISUAL_REVIEW_READY '+str(lab.run),flush=True)
review_path=lab.run/'road-fixes-visual-review.json'
deadline=time.monotonic()+180
while not review_path.is_file() and time.monotonic()<deadline:time.sleep(1)
assert review_path.is_file(),'Native frames need actual visual review before acceptance'
review=json.loads(review_path.read_text())
frames={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in (lab.run/'captures').glob('road-fixes-*.png')}
assert review['accepted'] and review['frames']==frames,'Visual receipt must cover these exact native frames'
lab.write('road-fixes-acceptance',{'accepted':True,'mode':'mp' if a.mp else 'sp','transport':'No-Steam loopback' if a.mp else 'native SP',
    'visualReview':True,
    'scope':'Native frequency ratios, player proximity, legacy backlog retirement, five semi exclusions, stable unhitched drawbar parking, five native vanilla aliases and silent-siren control'})
invoke('native-command.py','stop')
print('ROAD_FIX_NATIVE_ACCEPTED',flush=True)
