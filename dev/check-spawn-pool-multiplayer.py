"""Compare natural authoritative spawns with two joined native peers."""
import argparse,json,time
from native_lab import NativeLab,ROOT,rows
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--allow-empty',action='store_true');a=p.parse_args();lab=NativeLab(a.run)
snapshot=(ROOT/'dev/snapshot.lua').read_text('utf8');results={}
for name,x,y in [('checkpoint',12566,4215),('highway',12598,1788),('secret-base',5592,12458),('west-point',11788,6818)]:
    lab.move(x,y)
    records=lab.snapshot('audit-mp-'+name)
    authority=[v for v in rows(records['server']['vehicles']) if abs(v['x']-x)<40 and abs(v['y']-y)<40]
    if not authority and a.allow_empty:
        results[name]={'naturalAuthority':[],'peerMatches':{},'suppressed':[]};continue
    assert authority,name+' has no natural vehicles'
    expected={v['id']:v for v in authority};compared={}
    for v in authority:
        if v.get('skinCount',0)>0:assert 0<=v['skin']<v['skinCount'],(name,'invalid native skin',v)
    for who in ('a','b'):
        def probe():return {v['id']:v for v in rows(lab.client(snapshot,who)['vehicles'])}
        peer=lab.wait(probe,lambda p:all(k in p and all(p[k][field]==v[field] for field in ('script','skin','lights','siren'))
                                       for k,v in expected.items()),who+' natural vehicle state replication')
        for identity,v in expected.items():
            assert all(peer[identity][key]==v[key] for key in ('script','skin','lights','siren')),(name,who,v,peer[identity])
        compared[who]=len(expected)
    suppressed=lab.server('''local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local P=require 'OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy';local out={}
local it=getCell():getVehicles():iterator();while it:hasNext() do local v=it:next()
 if P.suppressed(C,v:getScriptName()) then out[#out+1]=v:getScriptName() end end
return out''')
    assert not rows(suppressed),suppressed
    results[name]={'naturalAuthority':authority,'peerMatches':compared,'suppressed':rows(suppressed)}
lab.write('audit-mp-comparison',results)
assert any(r['naturalAuthority'] for r in results.values()),'No natural MP observations at any location'
print(json.dumps({name:{'naturalVehicles':len(r['naturalAuthority']),'peerMatches':r['peerMatches']} for name,r in results.items()}))
