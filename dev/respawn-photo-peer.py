"""Repair the disposable observer setup using the native new-character UI."""
import argparse,subprocess,sys,time
from native_lab import NativeLab,ROOT
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run)
assert a.run.startswith('spawn-audit-')
removed=lab.server("""getSandboxOptions():getOptionByName('Zombies'):setValue(6);getSandboxOptions():toLua()
local zombies=getCell():getZombieList();local n=zombies:size()
for i=zombies:size()-1,0,-1 do local z=zombies:get(i);z:removeFromWorld();z:removeFromSquare() end
return {removed=n,zombies=SandboxVars.Zombies}""")
assert removed['zombies']==6
before=lab.client('return {dead=getPlayer():isDead(),x=getPlayer():getX(),y=getPlayer():getY()}','b')
assert before['dead'] is True,before
# Native death-screen Continue with new character button, observed in the
# owned 1280x720 framebuffer. Never revives or edits a real saved character.
lab.client('MEMCNativeLab.clickAt(640,605);return true','b');time.sleep(1)
subprocess.run([sys.executable,str(ROOT/'dev/native-mp-connect.py'),a.run,'b','--resume-connection'],check=True)
after=lab.client("return {dead=getPlayer():isDead(),health=getPlayer():getBodyDamage():getHealth(),access=getPlayer():getAccessLevel()}",'b')
assert not after['dead'] and after['health']>0,after
lab.write('audit-observer-recovery',{'before':before,'testWorld':removed,'after':after,
 'method':'Native death-screen Continue and character wizard; same owned server/client processes; no real save touched'})
print('Disposable photo observer recreated through native UI')
