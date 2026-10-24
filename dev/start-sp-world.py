"""Wait for the owned loading screen and dispatch its native click to start."""
import argparse,json,time
from native_lab import NativeLab
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run)
deadline=time.monotonic()+180;clicks=0
while time.monotonic()<deadline:
    # LuaManager belongs to GameLoadingThread until this native marker. Do
    # not run the main-thread endpoint against the loader's shared Lua state.
    console=lab.run/'sp/home/Zomboid/console.txt'
    if not console.exists() or 'game loading took ' not in console.read_text('utf8',errors='replace'):
        time.sleep(1);continue
    try:
        state=lab.client("local p=getPlayer();return {player=p~=nil,ready=p and isIngameState() and p:getCurrentSquare()~=nil,world=getWorld():getWorld()} ",'sp')
    except RuntimeError as error:
        # Known test-endpoint/Lua-loader ownership race, before game readiness.
        # Never recreate the world or swallow candidate runtime failures.
        if 'frame.closure' in str(error) or ('booleanValue()' in str(error) and 'success' in str(error)):
            time.sleep(1);continue
        raise
    if state.get('ready'):
        lab.write('sandbox-world-ready',{'state':state,'nativeStartClicks':clicks});print(json.dumps(state));break
    if state.get('player'):
        lab.client('MEMCNativeLab.clickToStart();GameWindow.doRenderEvent(true);return true','sp');clicks+=1
    time.sleep(1)
else:raise TimeoutError('Owned world did not finish loading')
