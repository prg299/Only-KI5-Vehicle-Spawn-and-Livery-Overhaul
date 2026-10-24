local result={spawns=OnlyKI5Acceptance and OnlyKI5Acceptance.spawns,
    chunks=OnlyKI5Acceptance and OnlyKI5Acceptance.chunks,client=isClient(),server=isServer()}
local p=getPlayer()
if p then result.player={x=p:getX(),y=p:getY(),z=p:getZ(),online=p:getOnlineID()} end
result.mods={}
local mods=getActivatedMods()
for i=0,mods:size()-1 do result.mods[#result.mods+1]=mods:get(i) end
result.vehicles={}
local vehicles=getCell() and getCell():getVehicles()
if vehicles then
    local iterator=vehicles:iterator()
    while iterator:hasNext() do
        local v=iterator:next()
        local zone=getVehicleZoneAt(math.floor(v:getX()),math.floor(v:getY()),math.floor(v:getZ()))
        result.vehicles[#result.vehicles+1]={id=v:getId(),sqlId=v:getSqlId(),script=v:getScriptName(),skin=v:getSkinIndex(),skinCount=v:getSkinCount(),
            x=v:getX(),y=v:getY(),z=v:getZ(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode(),
            zone=zone and zone:getName(),created=v:isCreated(),data=v:getModData()}
    end
end
result.pools={}
for _,name in ipairs({'modified_trfjm','trafficjams','parkingstall','military','military_vehicle_light','military_vehicle_heavy'}) do
    local pool=VehicleZoneDistribution and VehicleZoneDistribution[name]
    if pool then result.pools[name]=pool end
end
return result
