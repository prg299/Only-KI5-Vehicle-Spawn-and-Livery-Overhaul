"""Submit a serialized action to an already guarded owned acceptance lifetime."""
from pathlib import Path
import argparse,json,time,uuid
from native_files import read_json

p=argparse.ArgumentParser()
p.add_argument('run');p.add_argument('action',choices=['lua','capture','client','stop'])
p.add_argument('--client',default='sp');p.add_argument('--file',type=Path);p.add_argument('--code')
p.add_argument('--name');p.add_argument('--port',type=int);p.add_argument('--output',type=Path)
p.add_argument('--quiet',action='store_true')
a=p.parse_args()
root=Path(__file__).resolve().parents[1]
run=(root/'build/native'/a.run).resolve()
if not run.is_relative_to(root/'build/native'):raise ValueError('Run escaped test root')
if (run/'request.json').exists():raise RuntimeError('A prior action is pending')
q={'id':uuid.uuid4().hex,'action':a.action,'client':a.client}
if a.file:q['code']=a.file.read_text('utf-8-sig')
elif a.code:q['code']=a.code
if a.name:q['name']=a.name
if a.port:q['port']=a.port
tmp=run/'request.pending';tmp.write_text(json.dumps(q),encoding='utf-8');tmp.replace(run/'request.json')
if a.action=='stop':print('Owned lifetime stop requested');raise SystemExit()
deadline=time.monotonic()+300
while time.monotonic()<deadline:
    path=run/'response.json'
    if path.exists():
        result=read_json(path)
        if result.get('id')==q['id']:
            if a.output:a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(result,indent=2),encoding='utf-8')
            print(json.dumps({'ok':result['ok'],'output':str(a.output)} if a.quiet and result['ok'] else result,indent=2));raise SystemExit(0 if result['ok'] else 1)
    time.sleep(.2)
raise TimeoutError('Guarded acceptance lifetime did not finish the submitted action')
