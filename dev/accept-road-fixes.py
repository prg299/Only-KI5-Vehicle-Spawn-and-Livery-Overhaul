"""SP or dedicated/two-client controls within the owned native lifetime."""
import argparse,json,subprocess,sys,time
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
print('ROAD_FIX_NATIVE_BASELINE '+json.dumps({'aliases':len(rows(baseline['aliases'])),'rejectedSemis':len(rows(baseline['rejectedSemis'])),'rates':baseline['rates']}),flush=True)
time.sleep(12)
ids=[v['id'] for v in rows(baseline['physics'])]
probe="local r={};for _,id in ipairs({"+','.join(map(str,ids))+"}) do local v=getVehicleById(id);if v then r[#r+1]={id=id,script=v:getScriptName(),x=v:getX(),y=v:getY(),z=v:getZ(),speed=v:getCurrentSpeedKmHour(),parts=v:getPartCount()} end end;return r"
authority=rows(call(probe));assert len(authority)==2,authority
old={v['id']:v for v in rows(baseline['physics'])}
for v in authority:
    assert abs(v['x']-old[v['id']]['x'])<2 and abs(v['y']-old[v['id']]['y'])<2 and abs(v['z'])<1,v
    assert abs(v['speed'])<5 and v['parts']>0,v
matches={}
for who in peers:
    seen=lab.wait(lambda:rows(lab.client(probe,who)),lambda vs:len(vs)==2,'coupled vehicles on '+who)
    for v in seen:
        expected=next(s for s in authority if s['id']==v['id'])
        assert v['script']==expected['script'] and abs(v['x']-expected['x'])<2 and abs(v['y']-expected['y'])<2 and abs(v['z'])<1,(who,v)
    matches[who]=seen
lab.write('road-fixes-physics',{'seconds':12,'authority':authority,'peers':matches})
first=authority[0];x,y=round(first['x']+5),round(first['y']+5)
if a.mp:lab.move(x,y)
else:call(f'getPlayer():teleportTo({x},{y},0);return true');time.sleep(3)
who=peers[0]
lab.client((ROOT/'dev/gallery-visibility.lua').read_text(),who)
lab.client(f'getGameTime():setTimeOfDay(12);getPlayer():faceLocation({first["x"]},{first["y"]});return true',who)
lab.invoke('native-command.py','capture','--client',who,'--name','road-fixes-coupled-'+who)
invoke('check-silent-lightbars.py',*([] if a.mp else ['--single-player']))
if a.mp:invoke('check-spawn-pool-multiplayer.py','--allow-empty')
lab.write('road-fixes-acceptance',{'accepted':True,'mode':'mp' if a.mp else 'sp','transport':'No-Steam loopback' if a.mp else 'native SP',
    'scope':'Native frequency ratios, player proximity, legacy backlog retirement, five semi exclusions, valid drawbar physics, five native vanilla aliases and silent-siren control'})
invoke('native-command.py','stop')
print('ROAD_FIX_NATIVE_ACCEPTED',flush=True)
