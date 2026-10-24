"""Connect an owned client; character-screen buttons use native mouse input.

Connection credentials/target are test setup. They never reach stdout or Git.
The owned game/server lifetime must already be running through run-heavy.
"""
from pathlib import Path
import argparse,json,time,uuid
from native_files import read_json

p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('client',choices=['a','b'])
p.add_argument('--resume-connection',action='store_true',help='Resume UI/loading without another serverConnect')
a=p.parse_args();root=Path(__file__).resolve().parents[1]
from native_paths import owned_run
run=owned_run(a.run)
credentials=json.loads((run/'credentials.json').read_text())
client=json.loads((run/'clients.json').read_text())[a.client]
input_file=run/('connection-inputs-'+a.client+'.json')
inputs=json.loads(input_file.read_text('utf8')) if input_file.is_file() else []
loading_thread=False

def lua(code):
    global loading_thread
    if (run/'request.json').exists():raise RuntimeError('Another action is pending')
    q={'action':'lua','client':a.client,'id':uuid.uuid4().hex,'code':code,'timeout':60}
    temporary=run/'request.pending';temporary.write_text(json.dumps(q),encoding='utf-8');temporary.replace(run/'request.json')
    deadline=time.monotonic()+75
    while time.monotonic()<deadline:
        response=run/'response.json'
        if response.exists():
            result=read_json(response)
            if result.get('id')==q['id']:
                if not result['ok']:
                    # The test endpoint can race the game's loading-thread Lua
                    # owner while connection proceeds. Do not reconnect or hide
                    # arbitrary Lua failures; retry only this known adapter race.
                    error=result['error']
                    if 'java.lang.Boolean.booleanValue()' in error and '"success" is null' in error:
                        loading_thread=True
                        return {'state':'loading'}
                    if 'class java.lang.String cannot be cast to class java.lang.Boolean' in error or 'owner=GameLoadingThread' in error:
                        loading_thread=True
                        return {'state':'loading'}
                    if 'TimeoutError: timed out' in error:return {'state':'waiting'}
                    raise RuntimeError(error)
                return result.get('result')
        time.sleep(.1)
    raise TimeoutError('Owned lifetime did not answer')

user='OnlyKI5Admin' if a.client=='a' else 'OnlyKI5Guest'
password=credentials['password'] if a.client=='a' else credentials.get('guestPassword',uuid.uuid4().hex)
if a.client=='b':
    credentials['guest']='OnlyKI5Guest';credentials['guestPassword']=password
    (run/'credentials.json').write_text(json.dumps(credentials),encoding='utf-8')
if not a.resume_connection:
    lua(f'serverConnect({json.dumps(user)}, {json.dumps(password)}, "127.0.0.1", "127.0.0.1", "17431", "", "onlyki5", false, true, 1, ""); return true')
deadline=time.monotonic()+240
while time.monotonic()<deadline:
    if loading_thread:
        console=run/a.client/'home/Zomboid/console.txt'
        if 'game loading took ' not in console.read_text('utf8',errors='replace'):
            time.sleep(1);continue
        loading_thread=False
    state=lua('''
local p=getPlayer()
if p and not p:isDead() and isClient() and isIngameState() and p:getOnlineID()>=0 then
 return {state='connected',name=p:getUsername(),id=p:getOnlineID(),x=p:getX(),y=p:getY()}
end
if p and not p:isDead() then return {state='loading'} end
local function nextButton(window)
 if not window or not window:isReallyVisible() then return end
 local seen={}
 local function find(w)
  if not w or seen[w] then return end;seen[w]=true
  if w.internal=='NEXT' and w.enable~=false and w:isReallyVisible() then
   return {state='button',type=window.Type,x=w:getAbsoluteX()+w:getWidth()/2,y=w:getAbsoluteY()+w:getHeight()/2}
  end
  for _,child in pairs(w.children or {}) do local result=find(child);if result then return result end end
 end
 return find(window)
end
return nextButton(MapSpawnSelect and MapSpawnSelect.instance)
 or nextButton(CharacterCreationProfession and CharacterCreationProfession.instance)
 or nextButton(CharacterCreationMain and CharacterCreationMain.instance) or {state='waiting'}
''')
    if state['state']=='connected':
        receipt={'connected':state,'nativeCharacterInputs':inputs,'connectionTargetFixture':True}
        (run/f'connected-{a.client}.json').write_text(json.dumps(receipt,indent=2),encoding='utf-8')
        print(json.dumps(receipt,indent=2));break
    if state['state']=='button':
        lua(f'MEMCNativeLab.clickAt({int(state["x"])},{int(state["y"])});return true')
        inputs.append(state);print('Native character-screen click: '+str(state['type']),flush=True)
        input_file.write_text(json.dumps(inputs,indent=2),'utf8')
    elif state['state']=='loading':
        # This screen explicitly consumes the real mouse click before entering.
        lua('MEMCNativeLab.clickToStart();GameWindow.doRenderEvent(true);return true')
    time.sleep(1.2)
else:raise TimeoutError('Owned client did not join')
