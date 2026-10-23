"""Shared serialized broker for owned, already guarded native lab processes."""
from pathlib import Path
import json, subprocess, sys, time
from native_paths import owned_run

ROOT=Path(__file__).resolve().parents[1]

def rows(value): return list(value.values()) if isinstance(value,dict) else value

class NativeLab:
    def __init__(self,name):
        self.name=name;self.run=owned_run(name)

    def invoke(self,tool,*arguments):
        result=subprocess.run([sys.executable,str(ROOT/'dev'/tool),self.name,*arguments],
                              cwd=ROOT,capture_output=True,text=True,timeout=310)
        if result.returncode:raise RuntimeError(result.stdout+result.stderr)
        return json.loads(result.stdout)

    def client(self,code,who='a'):
        return self.invoke('native-command.py','lua','--client',who,'--code',code).get('result')

    def server(self,code):return self.invoke('native-server.py','--code',code).get('value')

    @staticmethod
    def wait(probe,accept,label):
        deadline=time.monotonic()+150;last=None
        while time.monotonic()<deadline:
            last=probe()
            if accept(last):return last
            time.sleep(1)
        raise TimeoutError(label+': '+str(last))

    def write(self,label,value):
        (self.run/(label+'.json')).write_text(json.dumps(value,indent=2)+'\n')

    def move(self,x,y):
        self.client(f"SendCommandToServer('/teleportto {x},{y},0');return true")
        self.wait(lambda:self.client('local p=getPlayer();return {x=p:getX(),y=p:getY()}'),
                  lambda r:abs(r['x']-x)<4 and abs(r['y']-y)<4,'admin teleport')
        self.client('SendCommandToServer(\'/teleportplayer "OnlyKI5Guest" "OnlyKI5Admin"\');return true')
        self.wait(lambda:self.client('local p=getPlayer();return {x=p:getX(),y=p:getY()}','b'),
                  lambda r:abs(r['x']-x)<5 and abs(r['y']-y)<5,'guest teleport')
        self.wait(lambda:self.server(f'return getCell():getGridSquare({x},{y},0)~=nil'),bool,'loaded area')
        time.sleep(5)

    def snapshot(self,label):
        code=(ROOT/'dev/snapshot.lua').read_text()
        records={'server':self.server(code),'a':self.client(code),'b':self.client(code,'b')}
        self.write(label+'-snapshots',records)
        return records

    def capture(self,label):
        for who in ('a','b'):
            self.invoke('native-command.py','capture','--client',who,'--name',label+'-'+who)

    def mechanics(self,v,label):
        identity=str(v['id'])
        engine=self.client('local v=getVehicleById('+identity+');local q=v:getAreaCenter("Engine");return {x=q:getX(),y=q:getY()}')
        self.move(round(engine['x']),round(engine['y']))
        facing=self.client('local v=getVehicleById('+identity+');local p=getPlayer();return {x=v:getX()-p:getX(),y=v:getY()-p:getY()}')
        key=(31 if facing['y']>=0 else 32) if facing['x']>=0 else (30 if facing['y']>=0 else 17)
        self.client('MEMCNativeLab.holdKey('+str(key)+',150);return true')
        time.sleep(.4)
        self.wait(lambda:self.client('local v=getPlayer():getNearVehicle();return v and v:getScriptName()'),
                  lambda n:n==v['script'],'native movement faces vehicle')
        self.client('MEMCNativeLab.holdKey(getCore():getKey(KeybindId.VEHICLE_MECHANICS:getId()),250);return true')
        ui=self.wait(lambda:self.client('local w=getPlayerMechanicsUI(0);return w and w:isReallyVisible() and {script=w.vehicle:getScriptName(),parts=w.vehicle:getPartCount()}'),bool,'native mechanics UI')
        assert ui['script']==v['script'],ui
        self.capture(label)
        self.client('MEMCNativeLab.holdKey(getCore():getKey(KeybindId.VEHICLE_MECHANICS:getId()),250);return true')
        return ui
