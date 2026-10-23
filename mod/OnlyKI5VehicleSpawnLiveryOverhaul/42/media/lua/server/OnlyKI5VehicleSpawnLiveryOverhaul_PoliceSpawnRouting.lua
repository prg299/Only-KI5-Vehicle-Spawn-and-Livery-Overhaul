-- Final regional police-livery guard for any pre-creation vehicle path,
-- including scripted stories, smashed/crash distributions, and burnt pools.
local Catalog = require "OnlyKI5VehicleSpawnLiveryOverhaul_Catalog"
local SpawnAliases = require "OnlyKI5VehicleSpawnLiveryOverhaul_SpawnAliases"
local PoliceRegions = require "OnlyKI5VehicleSpawnLiveryOverhaul_PoliceRegions"
local MOD_TAG = "[OnlyKI5VehicleSpawnLiveryOverhaul]"
local routablePoliceScripts = {}

for scriptName in pairs(Catalog.policeScripts or {}) do
    routablePoliceScripts[scriptName] = true
end
for _, scriptName in ipairs(Catalog.groups.policeGeneric or {}) do
    routablePoliceScripts[scriptName] = true
end

local vanillaPoliceSources = {
    ["Base.CarLightsPolice"] = true,
    ["Base.PickUpVanLightsPolice"] = true,
    ["Base.PickUpTruckLightsPolice"] = true,
    ["Base.NormalCarBurntPolice"] = true,
    ["Base.PickUpVanLightsBurnt"] = true,
    ["Base.CarLightsSmashedRear"] = true,
    ["Base.CarLightsSmashedRight"] = true,
    ["Base.CarLightsSmashedLeft"] = true,
    ["Base.CarLightsSmashedFront"] = true,
    ["Base.PickUpVanLightsSmashedRear"] = true,
    ["Base.PickUpVanLightsSmashedRight"] = true,
    ["Base.PickUpVanLightsSmashedLeft"] = true,
    ["Base.PickUpVanLightsSmashedFront"] = true,
    ["Base.PickUpTruckLightsSmashedRear"] = true,
    ["Base.PickUpTruckLightsSmashedRight"] = true,
    ["Base.PickUpTruckLightsSmashedLeft"] = true,
    ["Base.PickUpTruckLightsSmashedFront"] = true,
}

local function getFullScriptName(vehicle)
    local script = vehicle and vehicle:getScript()
    if not script then return nil end
    local fullName = script:getFullName()
    if type(fullName) == "string" and fullName ~= "" then return fullName end
    local shortName = script:getName()
    if type(shortName) ~= "string" or shortName == "" then return nil end
    if string.find(shortName, ".", 1, true) then return shortName end
    return "Base." .. shortName
end

local function routePoliceVehicleToRegion(vehicle)
    if not vehicle or vehicle:isCreated() then return end
    -- Native/randomized stories can bypass both Lua creation wrappers and pools.
    -- Resolve exact non-police aliases before the existing regional guard.
    SpawnAliases.routeNewVehicle(vehicle)
    local square = vehicle:getSquare()
    if not square then return end

    local sourceScript = getFullScriptName(vehicle)
    if not sourceScript then return end
    if sourceScript == "Base.90fordF350ambulance" then
        -- The script's random skin list mixes white EMS with Brush/Rescue
        -- liveries. Keep story, crash, burnt, and map-zone selections on the
        -- intended white EMS texture, matching the ambulance distribution.
        vehicle:setSkinIndex(0)
        return
    end
    if PoliceRegions.isPrisonTransport(sourceScript) then return end
    if not vanillaPoliceSources[sourceScript]
        and not routablePoliceScripts[sourceScript]
        and not PoliceRegions.isLivery(sourceScript) then
        return
    end

    local liveryKey = PoliceRegions.liveryKeyFor(square:getSquareRegion())
    if not liveryKey and getWorld then
        local world = getWorld()
        local metaGrid = world and world:getMetaGrid()
        local regions = metaGrid and metaGrid:getZonesAt(square:getX(), square:getY(), square:getZ())
        if regions then
            for index = 0, regions:size() - 1 do
                local region = regions:get(index)
                if region and string.lower(region:getType() or "") == "region" then
                    liveryKey = PoliceRegions.liveryKeyFor(region:getName())
                    if liveryKey then break end
                end
            end
        end
    end
    local candidates = liveryKey and PoliceRegions.patrolLiveries[liveryKey]
        or PoliceRegions.generalPatrol
    if type(candidates) ~= "table" or #candidates == 0 then return end
    if PoliceRegions.isTactical(sourceScript) then
        if PoliceRegions.isAllowedTactical(sourceScript, liveryKey) then return end
    elseif liveryKey and PoliceRegions.isAssignedLivery(sourceScript, liveryKey) then
        return
    elseif not liveryKey then
        for _, generalScript in ipairs(PoliceRegions.generalPatrol) do
            if sourceScript == generalScript then return end
        end
    end

    local index = ZombRand(#candidates) + 1
    local targetScript = candidates[index]
    if targetScript and targetScript ~= sourceScript then
        vehicle:setScriptName(targetScript)
        vehicle:scriptReloaded(true)
    end
end

if Events and Events.OnSpawnVehicleStart then
    -- Registered after the vanilla ProfessionVehicles.CheckSwap hook. Story
    -- arrays already choose their regional pool; this catches every other
    -- coordinate-bearing police spawn before the vehicle is finalized.
    Events.OnSpawnVehicleStart.Add(routePoliceVehicleToRegion)
    if Events.OnLoadedMapZones then
        Events.OnLoadedMapZones.Add(function()
            Events.OnSpawnVehicleStart.Remove(routePoliceVehicleToRegion)
            Events.OnSpawnVehicleStart.Add(routePoliceVehicleToRegion)
        end)
    end
else
    print(MOD_TAG .. " cannot register regional spawn guard: OnSpawnVehicleStart is unavailable")
end
