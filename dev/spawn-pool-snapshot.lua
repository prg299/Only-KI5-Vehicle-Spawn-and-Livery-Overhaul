-- Read-only inventory of every final native vanilla/modded selection pool.
local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local P=require 'OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy'
local result={zones={},professions={},scripts={},classifications={},mods={},groups={}}
local sm=getScriptManager()
local function script(name)
    if result.scripts[name]==nil then result.scripts[name]=sm:getVehicle(name)~=nil end
    result.classifications[name]={canonical=P.canonical(name),category=P.category(C,name),
        custom=P.isCustom(C,name),suppressed=P.suppressed(C,name)}
end
for name,zone in pairs(VehicleZoneDistribution or {}) do
    if type(zone)=='table' and type(zone.vehicles)=='table' then
        local record={vehicles={},settings={}}
        for key,value in pairs(zone) do
            if type(value)=='number' or type(value)=='boolean' or type(value)=='string' then record.settings[key]=value end
        end
        for name,properties in pairs(zone.vehicles) do
            if type(name)=='string' then
                script(name)
                record.vehicles[name]={weight=type(properties)=='table' and properties.spawnChance or -1,
                                       skin=type(properties)=='table' and properties.index or -1,
                                       customOriginal=type(properties)=='table' and P.originalCustomWeight(properties) or nil}
            end
        end
        result.zones[tostring(name)]=record
    end
end
local function roles(value,path,ancestors)
    if type(value)~='table' or ancestors[value] then return end
    ancestors[value]=true
    local counts,slots={},0
    for key,child in pairs(value) do
        if type(child)=='string' then
            local name=string.find(child,'.',1,true) and child or 'Base.'..child
            counts[name]=(counts[name] or 0)+1;slots=slots+1;script(name)
        elseif type(child)=='table' then roles(child,path..'.'..tostring(key),ancestors) end
    end
    if slots>0 then
        local weights={};local original={};local effective=P.professionPool(value)
        if effective then for name,p in pairs(effective) do
            script(name);weights[name]=p.spawnChance;original[name]=P.originalCustomWeight(p)
        end else for name,count in pairs(counts) do weights[name]=count end end
        result.professions[path]={counts=counts,slots=slots,weights=weights,customOriginal=original}
    end
    ancestors[value]=nil
end
roles(ProfessionVehicles,'ProfessionVehicles',{})
for name,candidates in pairs(C.groups) do
    result.groups[name]={count=#candidates}
    for _,name in ipairs(candidates) do script(name) end
end
local active=getActivatedMods()
for i=0,active:size()-1 do result.mods[#result.mods+1]=active:get(i) end
result.suppressCustom=P.suppressionEnabled()
result.civilianWeightPercent=P.numberOption('CustomCivilianChance',.025)
result.humveeChance=P.percentOption('HumveeSpawnChance',95)
result.policeLightsChance=P.percentOption('PoliceLightsChance',50)
result.truckChance=P.percentOption('AMGeneralTruckChance',75)
result.trafficPolicy=rawget(_G,'OnlyKI5TrafficPolicyAudit')
return result
