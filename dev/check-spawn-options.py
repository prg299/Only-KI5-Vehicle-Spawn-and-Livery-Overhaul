"""Reject an invalid preset name without losing numeric drafts, then save."""
import argparse,json
from native_lab import NativeLab
from native_sandbox import SandboxInput
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run);ui=SandboxInput(lab)
initial=ui.modal();draft=ui.state();committed=ui.committed()
assert draft=={'civilian':100,'lights':50,'humvee':95,'truck':75}
ui.modal_text('OnlyKI5/Invalid');rejected=ui.modal();assert rejected['valid'] is False
ui.click(rejected['ok']);unchanged=ui.modal()
assert unchanged['draft']=='OnlyKI5/Invalid' and unchanged['count']==initial['count']
assert ui.state()==draft and ui.committed()==committed,'Rejected input altered committed or draft settings'
ui.modal_text('OnlyKI5SpawnAuditOriginalWeights');assert ui.modal()['valid'] is True
ui.click(ui.modal()['ok'])
saved=ui.call("""local s=MainScreen.instance.sandOptions;local p=s.presets[s.presetList.selected];return {
 name=p.name,civilian=p.options:getOptionByName('OnlyKI5.CustomCivilianChance'):getValue(),
 truck=p.options:getOptionByName('OnlyKI5.AMGeneralTruckChance'):getValue()}""")
assert saved=={'name':'OnlyKI5SpawnAuditOriginalWeights','civilian':100,'truck':75},saved
lab.invoke('native-command.py','capture','--name','audit-sandbox-saved-original')
lab.write('sandbox-input',{'defaultRareShareConfirmed':True,'inputPath':'native MouseState and KeyEventQueue -> preset validation/save',
 'rejected':rejected,'unchangedAfterRejectedClick':unchanged,'draftRetained':draft,'authorityRetained':committed,'saved':saved})
print(json.dumps(saved))
