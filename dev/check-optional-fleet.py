"""Read-only final-world acceptance for an owned optional-fleet profile."""
import argparse,json
from native_lab import NativeLab,ROOT,rows
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--server',action='store_true');p.add_argument('--menu',action='store_true');a=p.parse_args();lab=NativeLab(a.run)
code=(ROOT/'dev/optional-fleet-snapshot.lua').read_text()
data=lab.server(code) if a.server else lab.client(code,'sp')
assert not data.get('invalid'),data.get('invalid')
for v in rows(data['variants']):
 assert (v['skins']>0 and v['parts']>0 and v['available']) if v['enabled'] else (v['skins']==0 and v['parts']==0 and not v['available']),v
if a.menu:
 assert data['available']==531,data['available']
elif data['available']==0:
 assert not any(data['zones'].values()),{k:v for k,v in data['zones'].items() if v}
 assert data['professionChoices']==0,data['professionChoices']
else:
 assert sum(data['zones'].values())>0
for v in rows(data['vehicles']):
 assert v.get('available',True),'Unavailable natural vehicle: '+v['script']
 assert v['script']!='Base.04vwTouran','Uninstalled Touran leaked'
data['menuOnly']=a.menu
lab.write('optional-fleet-authority',data)
print(json.dumps({'available':data['available'],'zonePools':len(data['zones']),'positiveChoices':sum(data['zones'].values()),'professionChoices':data['professionChoices'],'variants':len(rows(data['variants'])),'naturalVehicles':len(rows(data['vehicles']))}))
