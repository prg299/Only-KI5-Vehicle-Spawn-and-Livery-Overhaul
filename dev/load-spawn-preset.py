"""Reload the saved original-weight preset through native mouse dispatch."""
import argparse,json
from native_lab import NativeLab
from native_sandbox import SandboxInput
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run);ui=SandboxInput(lab)
ui.open();assert ui.state()=={'civilian':.025,'lights':50,'humvee':95,'truck':75}
ui.button('presetList')
point=ui.call("""local p=MainScreen.instance.sandOptions.presetList.popup
for i,item in ipairs(p.items) do if item.text=='OnlyKI5SpawnAuditOriginalWeights' then
 return {x=p:getAbsoluteX()+45,y=p:getAbsoluteY()+(i-.5)*p.itemheight+p:getYScroll()} end end
error('Owned saved preset missing after restart')""")
ui.click(point);loaded=ui.state();assert loaded=={'civilian':100,'lights':50,'humvee':95,'truck':75},loaded
lab.invoke('native-command.py','capture','--name','audit-sandbox-reloaded-original')
ui.button('playButton');committed=ui.committed();assert committed=={'vars':loaded,'native':loaded}
ui.call('OnlyKI5AcceptanceKeepSandboxDraft=true;return true')
lab.write('sandbox-preset-reload',{'loaded':loaded,'committed':committed,
 'inputPath':'native mouse -> preset popup -> sandbox Next -> native SandboxOptions/SandboxVars'})
print(json.dumps(committed))
