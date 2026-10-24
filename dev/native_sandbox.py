"""Shared native mouse/text driver for the owned sandbox acceptance screen."""
import json,time
class SandboxInput:
    keys={'civilian':'CustomCivilianChance','lights':'PoliceLightsChance','humvee':'HumveeSpawnChance','truck':'AMGeneralTruckChance'}
    def __init__(self,lab):self.lab=lab
    def call(self,code):return self.lab.client(code,'sp')
    def click(self,point):
        self.call(f"MEMCNativeLab.clickAt({int(point['x'])},{int(point['y'])});return true");time.sleep(.5)
    def button(self,name):
        self.click(self.call('local c=MainScreen.instance.sandOptions.'+name+';return {x=c:getAbsoluteX()+20,y=c:getAbsoluteY()+12}'))
    def text(self,point,old,value):
        self.click(point)
        self.call('MELensNativeText.key("END",1);'+(f'MELensNativeText.key("BACKSPACE",{len(old)});' if old else '')+
                  'MELensNativeText.text('+json.dumps(str(value))+');return true')
        self.lab.wait(lambda:self.call('return MELensNativeText.queued()'),lambda n:n==0,'native text dispatch')
    def entry(self,key,value):
        name='OnlyKI5.'+self.keys[key]
        point=self.call('local c=MainScreen.instance.sandOptions.controls['+json.dumps(name)+
                        '];return {x=c:getAbsoluteX()+20,y=c:getAbsoluteY()+12,text=c:getText()}')
        self.text(point,point['text'],value)
        assert self.state()[key]==float(value)
    def state(self):
        fields=','.join(key+"=tonumber(s.controls['OnlyKI5."+name+"']:getText())" for key,name in self.keys.items())
        return self.call('local s=MainScreen.instance.sandOptions;return {'+fields+'}')
    def committed(self):
        fields=','.join(key+'=SandboxVars.OnlyKI5.'+name for key,name in self.keys.items())
        native=','.join(key+"=getSandboxOptions():getOptionByName('OnlyKI5."+name+"'):getValue()" for key,name in self.keys.items())
        return self.call('return {vars={'+fields+'},native={'+native+'}}')
    def open(self):
        point=self.call("""local s=MainScreen.instance.sandOptions
MainScreen.instance.bottomPanel:setVisible(false);MainScreen.instance.charCreationProfession:setVisible(false);s:setVisible(true)
for i,item in ipairs(s.listbox.items) do if item.text=='ONLY KI5: Vehicle Spawn & Skins' then
 return {x=s.listbox:getAbsoluteX()+80,y=s.listbox:getAbsoluteY()+(i-.5)*s.listbox.itemheight} end end
error('ONLY KI5 sandbox page missing')""")
        self.click(point)
    def open_save(self):
        self.button('savePresetButton')
        self.call("local list=UIManager.getUI();for i=0,list:size()-1 do local ui=list:get(i):getTable();if ui and ui.Type=='ISTextBox' and ui:isVisible() then OnlyKI5SandboxModal=ui end end;assert(OnlyKI5SandboxModal);return true")
    def modal(self):return self.call("""local m=OnlyKI5SandboxModal;return {draft=m.entry:getText(),valid=m.yes.enable,
 entry={x=m.entry:getAbsoluteX()+25,y=m.entry:getAbsoluteY()+12},
 ok={x=m.yes:getAbsoluteX()+20,y=m.yes:getAbsoluteY()+12},count=getSandboxPresets():size()}""")
    def modal_text(self,value):
        old=self.modal();self.text(old['entry'],old['draft'],value)
        assert self.modal()['draft']==value
