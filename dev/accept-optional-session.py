"""Sequential controls inside an already guarded optional-fleet SP lifetime."""
import argparse,subprocess,sys,time,json
from native_lab import NativeLab,ROOT
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--menu',action='store_true');a=p.parse_args();lab=NativeLab(a.run)
deadline=time.monotonic()+180
while not (lab.run/'clients.json').is_file():
 if time.monotonic()>deadline:raise TimeoutError('Owned native menu readiness')
 time.sleep(.5)
def invoke(tool,*args):
 subprocess.run([sys.executable,str(ROOT/'dev'/tool),a.run,*args],check=True,cwd=ROOT)
if not a.menu:
 if not lab.client('return getPlayer()~=nil and isIngameState()','sp'):
  invoke('native-command.py','lua','--file',str(ROOT/'dev/new-world.lua'))
  invoke('start-sp-world.py')
invoke('check-optional-fleet.py',*(['--menu'] if a.menu else []))
if not a.menu:
 invoke('capture-spawn-audit.py','louisville-highway','--client','sp')
 # Recheck after real chunk streaming, rather than treating menu tables as a world.
 invoke('check-optional-fleet.py')
lab.write('optional-fleet-acceptance',{'menuOnly':a.menu,'checks':'Native registered models, provider availability, variant skins/parts, final map/profession pools and fresh location streaming' if not a.menu else 'Native full-fleet registered models and conditional variant skins/parts only'})
invoke('native-command.py','stop')
print('OPTIONAL_FLEET_NATIVE_ACCEPTED',flush=True)
