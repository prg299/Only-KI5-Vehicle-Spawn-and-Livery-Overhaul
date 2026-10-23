"""Read/mutate only the owned lab server through its admin-only test bridge."""
from pathlib import Path
import argparse,json,time,uuid
from native_files import read_json

p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--code');p.add_argument('--file',type=Path)
p.add_argument('--output',type=Path);p.add_argument('--quiet',action='store_true')
a=p.parse_args();root=Path(__file__).resolve().parents[1]
from native_paths import owned_run
run=owned_run(a.run)

def call(code):
    if (run/'request.json').exists():raise RuntimeError('Another action is pending')
    q={'action':'lua','client':'a','id':uuid.uuid4().hex,'code':code}
    temporary=run/'request.pending';temporary.write_text(json.dumps(q));temporary.replace(run/'request.json')
    deadline=time.monotonic()+60
    while time.monotonic()<deadline:
        response=run/'response.json'
        if response.exists():
            value=read_json(response)
            if value.get('id')==q['id']:
                if not value['ok']:raise RuntimeError(value['error'])
                return value.get('result')
        time.sleep(.1)
    raise TimeoutError('Owned client endpoint')

code=a.file.read_text('utf-8-sig') if a.file else a.code
identity=int(time.time_ns()%1000000000)
call('OnlyKI5AcceptanceResult=nil;sendClientCommand(getPlayer(),"OnlyKI5Acceptance","eval",'+
     '{id='+str(identity)+',code='+json.dumps(code)+'});return true')
deadline=time.monotonic()+30
while time.monotonic()<deadline:
    result=call('return OnlyKI5AcceptanceResult and OnlyKI5AcceptanceResult.id=='+str(identity)+' and OnlyKI5AcceptanceResult')
    if result:
        if a.output:a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(result,indent=2))
        print(json.dumps({'ok':result['ok'],'output':str(a.output)} if a.quiet and result['ok'] else result,indent=2))
        raise SystemExit(0 if result['ok'] else 1)
    time.sleep(.2)
raise TimeoutError('Owned authoritative server reply')
