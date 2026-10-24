"""Recover an owned guest after the debug photo visibility permission check.

Only the disposable OnlyKI5Guest account is promoted, after ordinary-peer
natural comparisons. Never use this helper against a player server/profile.
"""
import argparse,subprocess,sys,time
from native_lab import NativeLab,ROOT
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args();lab=NativeLab(a.run)
assert a.run.startswith('spawn-audit-')
lab.client('SendCommandToServer(\'/setaccesslevel "OnlyKI5Guest" "admin"\');return true')
time.sleep(1)
lab.client('getCore():exitToMenu();return true','b')
deadline=time.monotonic()+90
while time.monotonic()<deadline:
    try:
        if lab.client('return MainScreen and MainScreen.instance and not MainScreen.instance.inGame and not isIngameState()','b'):break
    except RuntimeError as e:
        if not any(s in str(e) for s in ('timed out','frame.closure','GameLoadingThread','cannot be cast to class java.lang.Boolean','booleanValue()')):raise
    time.sleep(1)
else:raise TimeoutError('Owned guest did not return to menu')
subprocess.run([sys.executable,str(ROOT/'dev/native-mp-connect.py'),a.run,'b'],check=True)
lab.client('SendCommandToServer(\'/setaccesslevel "OnlyKI5Guest" "admin"\');return true')
state=lab.wait(lambda:lab.client('return getPlayer():getAccessLevel()','b'),lambda value:value=='admin','owned photo permission')
lab.write('audit-photo-permission',{'user':'OnlyKI5Guest','permission':state,
 'scope':'Disposable photo peer only; ordinary-peer natural state comparisons were already complete',
 'reason':'Native see-everyone photo visibility requires server permission; gameplay payload unchanged'})
print('Owned guest rejoined; debug photo permission confirmed')
