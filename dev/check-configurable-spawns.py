"""Native selection registries and police construction at configured boundaries.

Temporary settings and explicit fixtures belong only to the disposable world.
Natural screenshot/population evidence is collected before this helper.
"""
import argparse,json,time
from native_lab import NativeLab,ROOT,rows
p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--single-player',action='store_true')
a=p.parse_args();lab=NativeLab(a.run)
call=(lambda code:lab.client(code,'sp')) if a.single_player else lab.server
probe="""local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local P=require 'OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy';local out={}
for _,name in ipairs({'military_vehicle_light','military_vehicle','military_vehicle_burnt','modified_trfjm'}) do
 local zone=VehicleZoneDistribution[name]
 if zone then
  local r={car=0,humvee=0,truck=0,am=0}
  for _,group in ipairs({'militaryCar','militaryTruck'}) do
   for _,wrecked in ipairs({false,true}) do
    for _,script in ipairs((wrecked and C.wreckedGroups or C.groups)[group] or {}) do
     local w=(zone.vehicles[script] or {}).spawnChance or 0
     if group=='militaryCar' then r.car=r.car+w
      if script=='Base.92amgeneralM998' or script=='Base.92amgeneralM998Burnt' then r.humvee=r.humvee+w end
     else r.truck=r.truck+w;if string.find(script,'amgeneral',1,true) then r.am=r.am+w end end
    end
   end
  end
  out[name]=r
 end
end
return {chance=P.percentOption('HumveeSpawnChance',95),lights=P.percentOption('PoliceLightsChance',50),pools=out}
"""
initial=call(probe);assert initial['chance']==95 and initial['lights']==50,initial
samples={}
try:
    for chance in (0,37,100,95):
        call(f"SandboxVars.OnlyKI5.HumveeSpawnChance={chance};SandboxVars.OnlyKI5.AMGeneralTruckChance={chance};return true")
        result=call("""local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local P=require 'OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy';local r={}
for _,group in ipairs({'militaryCar','militaryTruck'}) do
 local total,preferred=0,0
 for _,name in ipairs(C.groups[group]) do local w=C.weight(group,name);total=total+w
  if (group=='militaryCar' and name=='Base.92amgeneralM998') or (group=='militaryTruck' and P.isAMGeneralTruck(name)) then preferred=preferred+w end end
 local list=C.weightedCopy(group);local n=0
 for _,name in ipairs(list) do if (group=='militaryCar' and name=='Base.92amgeneralM998') or (group=='militaryTruck' and P.isAMGeneralTruck(name)) then n=n+1 end end
 r[group]={share=preferred/total,slots=#list,preferredSlots=n}
end;return r""")
        for group,r in result.items():
            assert abs(r['share']-chance/100)<1e-6 and r['slots']==1000 and r['preferredSlots']==chance*10,(chance,group,r)
        samples[str(chance)]=result
    police={}
    for chance,x in ((0,12558),(100,12648)):
        if a.single_player:
            lab.client(f'getPlayer():teleportTo({x},2042,0);return true','sp')
            lab.wait(lambda:lab.client(f'return getCell():getGridSquare({x},2042,0)~=nil','sp'),bool,'streamed police fixture area')
            time.sleep(3)
        else:lab.move(x,2042)
        call(f'SandboxVars.OnlyKI5.PoliceLightsChance={chance};return true')
        fixture=(ROOT/'dev/spawn-police.lua').read_text('utf8').replace('OnlyKI5PoliceFixture','OnlyKI5SettingsValidFixture'+str(chance)).replace('>=20','>=8')
        result=call(fixture);vehicles=rows(result['vehicles']);assert len(vehicles)==8,result
        eligible=[v for v in vehicles if v.get('decision') in ('off','on')]
        assert eligible and all(v['siren']==0 and v['lights']==(2 if chance==100 else 0) for v in eligible),eligible
        peers={}
        if not a.single_player:
            ids={v['id']:v for v in vehicles}
            snapshot=(ROOT/'dev/snapshot.lua').read_text('utf8')
            for who in ('a','b'):
                seen=lab.wait(lambda:rows(lab.client(snapshot,who)['vehicles']),
                    lambda vs:all(any(v['id']==key and all(v[k]==expected[k] for k in ('script','skin','lights','siren'))
                                      for v in vs) for key,expected in ids.items()),'configured police replication '+who)
                peers[who]=[v for v in seen if v['id'] in ids]
        police[str(chance)]={'authority':vehicles,'eligible':len(eligible),'peers':peers}
finally:
    call("SandboxVars.OnlyKI5.HumveeSpawnChance=95;SandboxVars.OnlyKI5.AMGeneralTruckChance=75;SandboxVars.OnlyKI5.PoliceLightsChance=50;return true")
lab.write('audit-configurable-spawns',{'singlePlayer':a.single_player,'initial':initial,
    'humveeBoundaries':samples,'policeBoundaries':police,'restored':call(probe),
    'method':'Disposable authority settings; loaded native catalog boundary weights/slots and native police factory; startup registries collected separately; explicit fixtures excluded from natural samples'})
print('PASS loaded native Humvee and AM General weights/slots at 0/37/100/95%; eligible police 0/100% with sirens off'+('' if a.single_player else '; both peers agree'))
