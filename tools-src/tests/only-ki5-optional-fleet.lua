function isClient() return false end
SandboxVars={OnlyKI5={CustomCivilianChance=.025}}
function ZombRand(n) return 0 end
function ZombRandFloat(a,b) return a end
local chosen={}
local shape=ONLY_KI5_TEST_TRAFFIC_SHAPE
if shape=='fleet-civilian' or shape=='fleet-mixed' then chosen['59meteor']=true end
if shape=='fleet-police' or shape=='fleet-mixed' then chosen['92fordCVPI']=true end
if shape=='fleet-military' or shape=='fleet-mixed' then chosen['80manKat1']=true end
function getActivatedMods() return {contains=function(self,n) return chosen[n]==true end} end
-- Ghost definitions intentionally exist, as bundled placeholders do natively.
function getScriptManager() return {getVehicle=function(self,n) return {getSkinCount=function() return 1 end} end} end
local function event() return {Add=function() end,Remove=function() end} end
Events={OnInitGlobalModData=event(),OnLoadMapZones=event(),OnLoadedMapZones=event(),OnSpawnVehicleStart=event()}
local applied
Events.OnLoadMapZones.Add=function(f) applied=f end
function addVehicleDebug(name) return name end
ProfessionVehicles={OptionalGhost={'Base.04vwTouran','Base.91fordLTDpdLouisville'},Ordinary={'Base.CarNormal'}}
VehicleZoneDistribution={parkingstall={vehicles={['Base.CarNormal']={spawnChance=50},['Base.04vwTouran']={spawnChance=10},['Base.59meteor']={spawnChance=50}}},
 police={vehicles={['Base.CarLightsPolice']={spawnChance=50}}},military={vehicles={['Base.92amgeneralM998']={spawnChance=50}}},
 military_vehicle_light={vehicles={}},military_vehicle_heavy={vehicles={}}}
loaded['OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_VehicleZoneDistribution']=true
loaded['OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_RegisterZones']=true
require 'OnlyKI5VehicleSpawnLiveryOverhaul_Runtime'
applied()
local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local F=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Fleet'
local A=require 'OnlyKI5VehicleSpawnLiveryOverhaul_SpawnAliases'
assert(not F.available('Base.04vwTouran'))
assert(not F.available('Base.91fordLTDpdLouisville'))
assert(C.weight('police','Base.91fordLTDpdLouisville')==0)
for _,zone in pairs(VehicleZoneDistribution) do for name in pairs(zone.vehicles or {}) do
 assert(F.available(name),'Unavailable pool choice '..name)
 assert(name~='Base.CarNormal' and name~='Base.CarLightsPolice','Vanilla fallback '..name)
end end
for _,name in ipairs(ProfessionVehicles.OptionalGhost) do assert(F.available(name)) end
assert(not A.resolve('Base.Trailer_Horsebox'),'Absent trailer alias selected')
assert(addVehicleDebug('Base.Trailer_Horsebox')==nil,'Missing direct alias leaked to vanilla')
if shape=='fleet-none' then
 assert(C.availableFleetCount==0 and #C.groups.normal==0)
 for _,zone in pairs(VehicleZoneDistribution) do for name in pairs(zone.vehicles or {}) do error('Zero-fleet pool contains '..name) end end
 assert(addVehicleDebug('Base.CarNormal')==nil)
elseif chosen['59meteor'] then
 assert(#C.groups.normal>0 and #C.groups.van>0,'Ordinary compatible fallback missing')
 assert(addVehicleDebug('Base.CarNormal')~=nil)
end
if chosen['80manKat1'] then
 assert(#C.groups.militaryTruck>0,'Non-AM truck pack discarded')
 assert(#C.weightedCopy('militaryTruck')==1000,'Absent AM family emptied truck choices')
end
local R=require 'OnlyKI5VehicleSpawnLiveryOverhaul_PoliceRegions'
for _,list in pairs(R.patrolLiveries) do for _,name in ipairs(list) do assert(F.available(name)) end end
print('PASS optional fleet '..shape..': provider filtering, compatible fallback, empty roles, aliases and native placeholders')
