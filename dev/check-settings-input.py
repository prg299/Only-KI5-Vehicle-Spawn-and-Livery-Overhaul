"""Edit all four actual sandbox controls through native mouse/text dispatch."""
import argparse,json
from native_lab import NativeLab
from native_sandbox import SandboxInput
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run);ui=SandboxInput(lab)
ui.open();initial=ui.state();assert initial=={'civilian':.025,'lights':50,'humvee':95,'truck':75},initial
lab.invoke('native-command.py','capture','--name','audit-sandbox-default')
boundary={'civilian':.1,'lights':0,'humvee':100,'truck':0}
for key,value in boundary.items():ui.entry(key,value)
lab.invoke('native-command.py','capture','--name','audit-sandbox-boundaries')
ui.button('playButton');committed=ui.committed()
assert committed=={'vars':boundary,'native':boundary},committed
ui.open()
for key,value in {'civilian':100,'lights':50,'humvee':95,'truck':75}.items():ui.entry(key,value)
ui.open_save()
lab.write('sandbox-settings-input',{'initial':initial,'boundaryDraft':boundary,'committed':committed,
 'inputPath':'native MouseState and KeyEventQueue -> sandbox Next -> SandboxOptions/SandboxVars'})
print(json.dumps(committed))
