-- Read-only live-game registry audit, additional to visual/native input checks.
local catalog=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local seen,missing,police={}, {}, 0
for _,collection in ipairs({catalog.groups,catalog.wreckedGroups}) do
    for _,list in pairs(collection) do for _,name in ipairs(list) do seen[name]=true end end
end
for name in pairs(catalog.policeScripts) do seen[name]=true;police=police+1 end
local count=0
for name in pairs(seen) do
    count=count+1
    if not ScriptManager.instance:getVehicle(name) then missing[#missing+1]=name end
end
local military={}
for _,group in ipairs({'militaryCar','militaryTruck','militaryCarWreck','militaryTruckWreck','militaryTrailer'}) do
    for _,name in ipairs(catalog.groups[group] or {}) do military[name]=group end
    for _,name in ipairs(catalog.wreckedGroups[group] or {}) do military[name]=group end
end
local pools={}
for _,name in ipairs({'modified_trfjm','trafficjams','parkingstall','military_vehicle_light','military_vehicle_heavy'}) do
    local pool=VehicleZoneDistribution[name]
    local total,mil,car,humvee,truck,am=0,0,0,0,0,0
    local forbidden={}
    for script,entry in pairs(pool and pool.vehicles or {}) do
        local weight=entry.spawnChance or 0
        total=total+weight
        if military[script] then mil=mil+weight end
        if military[script]=='militaryCar' then car=car+weight;if script=='Base.92amgeneralM998' then humvee=humvee+weight end end
        if military[script]=='militaryTruck' then truck=truck+weight;if string.find(script,'amgeneral',1,true) then am=am+weight end end
        if string.find(script,'MedicalExaminer',1,true) or script=='Base.PickUpTruck_Camo' or script=='Base.PickUpVan_Camo' then forbidden[#forbidden+1]=script end
    end
    pools[name]={total=total,military=mil,ordinary=total-mil,
        militaryToOrdinary=total>mil and mil/(total-mil) or nil,
        car=car,humveeShare=car>0 and humvee/car or nil,truck=truck,amGeneralShare=truck>0 and am/truck or nil,
        forbidden=forbidden,spawnRate=pool and pool.spawnRate}
end
local armorKeys={}
for key in pairs(DAMN and DAMN.Armor or {}) do armorKeys[#armorKeys+1]=tostring(key) end
return {scripts=count,missing=missing,policeScripts=police,pools=pools,
    sharedHighway=VehicleZoneDistribution.modified_trfjm.vehicles==VehicleZoneDistribution.trafficjams.vehicles,
    armorKeys=armorKeys,stories=require('OnlyKI5VehicleSpawnLiveryOverhaul_RoadStories').getVehicleStoriesList(),
    camoTextureLoaded=not isServer() and getTexture('media/textures/Vehicles/Vehicles_92amgeneralM998_Shell_merdc_summer.png')~=nil}
