"""Sequential whole-registry and representative natural-frame acceptance."""
import argparse,json,subprocess,sys
from native_lab import ROOT,NativeLab
from native_paths import owned_run
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--opt-in',action='store_true');a=p.parse_args()
def invoke(tool,*args):
    subprocess.run([sys.executable,str(ROOT/'dev'/tool),a.run,*map(str,args)],cwd=ROOT,check=True)
invoke('start-sp-world.py')
invoke('collect-spawn-pools.py','--include',owned_run('spawn-audit-033-baseline')/'spawn-pools.json')
subprocess.run([sys.executable,str(ROOT/'dev/audit-spawn-pools.py'),
    '--before',str(owned_run('spawn-audit-033-baseline')/'spawn-pools.json'),
    '--after',str(owned_run(a.run)/'spawn-pools.json'),'--output',
    str(ROOT/'docs/validation/native-20261024-spawn-pools'/('original-weights' if a.opt_in else 'default-rare'))],check=True)
locations=json.loads((ROOT/'config/workshop-gallery-locations.json').read_text('utf8'))
selected=['riverside-town-centre','muldraugh-industrial','secret-military-base'] if a.opt_in else [x['key'] for x in locations]
for key in selected:
    invoke('capture-spawn-audit.py',key)
    print('NATURAL_FRAME_READY '+key,flush=True)
if not a.opt_in:invoke('check-configurable-spawns.py','--single-player')
print('SPAWN_AUDIT_COMPLETE',flush=True)
