-- Production callback coverage for native ParkingStall names and broad metadata.
function isClient() return ONLY_KI5_TEST_TRAFFIC_SHAPE=='client' end
function isServer() return not isClient() and ONLY_KI5_TEST_TRAFFIC_SHAPE~='singleplayer' end
local callbacks={}
Events={OnSpawnVehicleEnd={Add=function(fn) callbacks[#callbacks+1]=fn end}}
local parkingName,metaType,roll='modified_trfjm','TownZone',0
function getVehicleZoneAt() return {getName=function() return parkingName end} end
function getCell() return {getGridSquare=function() return {getZone=function() return {getType=function() return metaType end} end} end} end
function ZombRand() return roll end
function getGameTime() return {getWorldAgeHours=function() return 20 end} end
local function vehicle()
 local v={data={},lights=0,siren=0,condition=100}
 function v:getScriptName()return 'Base.92fordCVPILouisville' end
 function v:hasLightbar()return true end
 function v:getX()return 12453 end;function v:getY()return 1628 end;function v:getZ()return 0 end
 function v:getModData()return self.data end
 function v:getLightbarSirenMode()return self.siren end;function v:setLightbarSirenMode(n)self.siren=n end
 function v:getLightbarLightsMode()return self.lights end;function v:setLightbarLightsMode(n)self.lights=n end
 function v:setSirenStartTime(n)self.sirenTime=n end
 function v:getPartById()return {getCondition=function()return self.condition end} end
 return v
end
require 'OnlyKI5VehicleSpawnLiveryOverhaul_PoliceLightbars'
if isClient() then assert(#callbacks==0,'A joined client must not roll authoritative lightbar decisions');return end
assert(#callbacks==1)
local apply=callbacks[1]
for _,name in ipairs({'police','policegarage','fire','firegarage','firetruck','ambulance','prison','ranger','military','military_vehicle_light_angled'})do
 parkingName=name;local v=vehicle();v.siren=2;apply(v)
 assert(v.siren==0,'Station spawn retained an audible siren')
 assert(v.lights==0 and string.find(v.data['OnlyKI5VehicleSpawnLiveryOverhaul.PoliceLightbarSpawnV1'],'station:',1,true),'Native emergency parking exclusion: '..name)
end
parkingName='modified_trfjm';local on=vehicle();on.siren=2;apply(on)
assert(on.lights==2 and on.siren==0 and on.sirenTime==20)
roll=99;on.siren=2;apply(on);assert(on.lights==2 and on.siren==0,'Repeated callbacks must preserve lights and clear a spawn siren')
local off=vehicle();apply(off);assert(off.lights==0 and off.data['OnlyKI5VehicleSpawnLiveryOverhaul.PoliceLightbarSpawnV1']=='off')
roll=0;local broken=vehicle();broken.condition=0;apply(broken);assert(broken.lights==0)
local existing=vehicle();existing.lights=1;existing.siren=2;apply(existing);assert(existing.lights==1 and existing.siren==0)
parkingName='ordinary';metaType='police';local legacy=vehicle();apply(legacy);assert(legacy.lights==0)
