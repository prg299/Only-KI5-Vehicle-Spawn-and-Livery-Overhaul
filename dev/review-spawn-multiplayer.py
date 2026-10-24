"""Sequential final registry, natural peer, frame and silent-light acceptance."""
import argparse,subprocess,sys,json
from native_lab import ROOT,NativeLab,rows
from native_paths import owned_run
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run)
for who in ('a','b'):assert (lab.run/('connected-'+who+'.json')).is_file()
def invoke(tool,*args):
    subprocess.run([sys.executable,str(ROOT/'dev'/tool),a.run,*map(str,args)],cwd=ROOT,check=True)
if not (lab.run/'spawn-pools.json').is_file():
    invoke('collect-spawn-pools.py','--server','--include',owned_run('spawn-audit-033-baseline')/'spawn-pools.json')
subprocess.run([sys.executable,str(ROOT/'dev/audit-spawn-pools.py'),
 '--before',str(owned_run('spawn-audit-033-baseline')/'spawn-pools.json'),
 '--after',str(lab.run/'spawn-pools.json'),'--output',str(ROOT/'docs/validation/native-20261024-spawn-pools/multiplayer')],check=True)
if not (lab.run/'audit-mp-comparison.json').is_file():invoke('check-spawn-pool-multiplayer.py')
print('NATURAL_PEERS_VERIFIED',flush=True)
# The ordinary-peer four-location comparison is complete. Natural visual
# coverage comes from fourteen SP locations plus the existing MP checkpoint
# frame; finish the priority lightbar checks in the same owned lifetime.
if not (lab.run/'silent-lightbar-audio.json').is_file():invoke('check-silent-lightbars.py')
print('SILENT_NATIVE_AUDIO_VERIFIED',flush=True)
if not (lab.run/'audit-configurable-spawns.json').is_file():invoke('check-configurable-spawns.py')
print('MULTIPLAYER_STATE_AUDIT_COMPLETE; visual acceptance requires opening and reviewing actual frames',flush=True)
