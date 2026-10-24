-- Production selection policy with explicit fixtures; native registries and
-- natural location captures are audited separately by dev/audit-spawn-pools.py.
local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local P=require 'OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy'
function ZombRand(n) return 0 end
function ZombRandFloat(a,b) return a end
local A=require 'OnlyKI5VehicleSpawnLiveryOverhaul_SpawnAliases'
SandboxVars={}
assert(P.civilianShare()==.00025,'custom share must default to 0.025 percent')
SandboxVars.OnlyKI5={CustomCivilianChance=0}
assert(P.suppressionEnabled(),'zero must disable custom civilian spawns')
local protected=0
for name in pairs(C.customCivilianScripts) do
    assert(P.suppressed(C,name),name)
    assert(C.weight('normal',name,'parkingstall')==0,name)
    assert(not P.suppressed(C,P.replacement(C,name)),name..' replacement remains custom')
end
for _,group in ipairs({'police','fire','ambulance','militaryCar','militaryTruck','militaryTrailer'}) do
    for _,name in ipairs(C.groups[group]) do
        protected=protected+1;assert(not P.suppressed(C,name),name)
    end
end
for name in pairs(C.trafficProtectedScripts) do assert(not P.suppressed(C,name),name) end
assert(P.category(C,'Base.90bmwE30m3')=='sports')
assert(P.category(C,'Base.CarNormalBurnt')=='wreck','charred prop counted as ordinary road traffic')
assert(C.weight('commercial','Base.87fordB700school','carpenter')==0,'school bus at carpenter')
assert(C.weight('commercial','Base.87fordB700school','transit')>0,'transit bus lost')
assert(protected>100)
for _,name in ipairs(C.groups.prisonPolice) do
    assert(not string.find(name,'Airport',1,true) and name~='Base.93fordF350as','airport security in prison escort pool')
end
for _,name in ipairs({'Base.84oldsmobile98Sedan','Base.85oldsmobileDelta88Coupe'}) do
    assert(P.category(C,name)=='everyday',name..' mistaken for commercial')
end
local function properties(weight) return {index=-1,spawnChance=weight} end
local function source()
    return {vehicles={
        ['Base.85chevyCapriceSedan']=properties(100),
        ['Base.82firebirdKITT']=properties(100),
        ['Base.86fordE150fossoil']=properties(100),
        ['Base.93townCarLimo']=properties(100),
        ['Base.93fordElgin']=properties(100),
        ['Base.90pierceArrow']=properties(100),
        ['Base.92amgeneralM998']=properties(100),
        ['Base.82porsche911']=properties(100),
    },chanceToSpawnNormal=80}
end
local s=source()
VehicleZoneDistribution={modified_trfjm=s,parkingstall=s,empty={vehicles={}},
    fire={vehicles={['Base.90pierceArrow']=properties(50),['Base.93fordElgin']=properties(50)}},
    advertising={vehicles={['Base.93fordElgin']=properties(30)}},
    business={vehicles={['Base.86fordE150fossoil']=properties(100),['Base.93fordF350as']=properties(100),['Base.87fordB700school']=properties(100)}},
    malformed={vehicles={['Base.Base.75grandPrixLJ']=properties(20),['75grandPrixLJ']=properties(30)}},
}
ProfessionVehicles={test={General={'Base.82firebirdKITT','Base.93fordF350as','Base.85chevyCapriceSedan',
    'Base.RaceCar12','Base.VanRadioJJ'}}}
P.normalizeRegistryKeys()
assert(VehicleZoneDistribution.parkingstall.vehicles==s.vehicles,'normalization broke shared source identity')
assert(VehicleZoneDistribution.malformed.vehicles['Base.75grandPrixLJ'].spawnChance==50)
local audit=P.apply(C,A)
assert(VehicleZoneDistribution.parkingstall.vehicles~=VehicleZoneDistribution.modified_trfjm.vehicles,'highway must be independently tunable')
for zone,record in pairs(audit.zones) do
    for name in pairs(VehicleZoneDistribution[zone].vehicles) do assert(not P.suppressed(C,name),zone..':'..name) end
end
local h=audit.zones.modified_trfjm
assert(h.categories.everyday/h.totalWeight>=.97,'highway everyday share')
for _,zone in ipairs({'parkingstall','modified_trfjm'}) do
    local v=VehicleZoneDistribution[zone].vehicles
    for _,name in ipairs({'Base.93townCarLimo','Base.93fordElgin'}) do
        local others=0;for other,p in pairs(v) do
            if other~='Base.93townCarLimo' and other~='Base.93fordElgin' then others=others+p.spawnChance end
        end
        assert(v[name].spawnChance<=others*(zone=='modified_trfjm' and .0002 or .0005)+1e-8)
    end
end
for _ in pairs(VehicleZoneDistribution.empty.vehicles) do assert(false,'empty reserved pool populated') end
assert(not VehicleZoneDistribution.fire.vehicles['Base.93fordElgin'],'sweeper in fire pool')
for name in pairs(VehicleZoneDistribution.advertising.vehicles) do assert(string.sub(name,1,12)=='Base.Trailer') end
assert(audit.zones.business.totalWeight>0,'suppression emptied a business pool')
assert(not VehicleZoneDistribution.business.vehicles['Base.93fordF350as'],'airport security at unrelated business')
assert(not VehicleZoneDistribution.business.vehicles['Base.87fordB700school'],'school bus at unrelated business')
assert(#ProfessionVehicles.test.General==5,'profession choices lost')
for _,name in ipairs(ProfessionVehicles.test.General) do
    assert(not P.suppressed(C,name),name);assert(name~='Base.RaceCar12','vanilla race alias retained')
end
local before=VehicleZoneDistribution.modified_trfjm.vehicles['Base.93fordElgin'].spawnChance
P.apply(C,A)
assert(math.abs(VehicleZoneDistribution.modified_trfjm.vehicles['Base.93fordElgin'].spawnChance-before)<1e-9,'policy inflates on repeat')
SandboxVars.OnlyKI5={CustomCivilianChance=100}
VehicleZoneDistribution={parkingstall=source()}
ProfessionVehicles={test={General={'Base.82firebirdKITT','Base.VanRadioJJ'}}}
P.apply(C,A)
assert(VehicleZoneDistribution.parkingstall.vehicles['Base.82firebirdKITT'],'opt-in novelty missing')
assert(VehicleZoneDistribution.parkingstall.vehicles['Base.86fordE150fossoil'],'opt-in business livery missing')
assert(ProfessionVehicles.test.General[1]=='Base.82firebirdKITT')
assert(A.resolve('Base.VanRadioJJ')=='Base.86fordE150LBMWradio')
