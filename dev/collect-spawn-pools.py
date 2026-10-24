"""Read final registries in an already guarded owned native lifetime."""
import argparse,json
from pathlib import Path
from native_lab import NativeLab,ROOT
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--client',default='sp')
p.add_argument('--server',action='store_true');p.add_argument('--include',type=Path)
p.add_argument('--label',default='spawn-pools');a=p.parse_args()
lab=NativeLab(a.run)
code=(ROOT/'dev/spawn-pool-snapshot.lua').read_text('utf8')
if a.include:
    names=sorted(json.loads(a.include.read_text('utf8'))['scripts'])
    code=code.replace('return result','for _,name in ipairs({'+','.join(map(json.dumps,names))+'}) do script(name) end\nreturn result')
if a.server:
    # A complete registry exceeds sendServerCommand's fixed packet buffer.
    # Freeze one read-only snapshot, then fetch bounded test-only blocks.
    paged=code.replace('return result',"""OnlyKI5AcceptancePoolBlocks={}
local fields={'zones','professions','scripts','classifications','mods','groups'}
local function size(value)
 if type(value)=='table' then local n=16;for k,v in pairs(value) do n=n+size(k)+size(v)+8 end;return n end
 return type(value)=='string' and #value+4 or 16
end
for _,field in ipairs(fields) do
 local block={field=field,entries={}};local bytes=0
 for key,value in pairs(result[field]) do
  local n=size(key)+size(value)+8
  if bytes+n>48000 and bytes>0 then OnlyKI5AcceptancePoolBlocks[#OnlyKI5AcceptancePoolBlocks+1]=block;block={field=field,entries={}};bytes=0 end
  block.entries[key]=value;bytes=bytes+n
 end
 if bytes>0 then OnlyKI5AcceptancePoolBlocks[#OnlyKI5AcceptancePoolBlocks+1]=block end
 result[field]=nil
end
return {meta=result,blocks=#OnlyKI5AcceptancePoolBlocks}""")
    index=lab.server(paged);snapshot=index['meta']
    for i in range(1,index['blocks']+1):
        block=lab.server(f'return OnlyKI5AcceptancePoolBlocks[{i}]')
        snapshot.setdefault(block['field'],{}).update(block['entries'])
    lab.server('OnlyKI5AcceptancePoolBlocks=nil;return true')
else:snapshot=lab.client(code,a.client)
lab.write(a.label,snapshot)
bad=[name for name,valid in snapshot['scripts'].items() if not valid]
print(json.dumps(dict(zones=len(snapshot['zones']),professionLists=len(snapshot['professions']),
                      scripts=len(snapshot['scripts']),unresolved=bad)))
