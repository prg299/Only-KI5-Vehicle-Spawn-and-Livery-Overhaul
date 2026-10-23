-- Server-authoritative silent police lightbars for the Only KI5: Vehicle Spawn & Livery Overhaul.

if isClient and isClient() then
    return
end

local Catalog = require "OnlyKI5VehicleSpawnLiveryOverhaul_Catalog"
local LIGHTBAR_CHANCE_PERCENT = 50
local MOD_DATA_KEY = "OnlyKI5VehicleSpawnLiveryOverhaul.PoliceLightbarSpawnV1"
local stationZoneTypes = { police = true, fire = true, ambulance = true, prison = true, ranger = true, military = true }

local function isPoliceScript(scriptName)
    if not scriptName then return false end
    if Catalog.policeScripts[scriptName] then return true end
    local normalized = string.lower(scriptName)
    return string.find(normalized, "police", 1, true) ~= nil
        or string.find(normalized, "sheriff", 1, true) ~= nil
        or string.find(normalized, "ksp", 1, true) ~= nil
        or string.find(normalized, "swat", 1, true) ~= nil
        or string.match(normalized, "pd$") ~= nil
        or string.match(normalized, "pdu$") ~= nil
end

local function zoneTypeForVehicle(vehicle)
    if not getCell or not vehicle then return nil end
    local cell = getCell()
    if not cell then return nil end
    local square = cell:getGridSquare(math.floor(vehicle:getX()), math.floor(vehicle:getY()), math.floor(vehicle:getZ()))
    local zone = square and square:getZone()
    local zoneType = zone and zone:getType()
    return zoneType and zoneType ~= "" and string.lower(tostring(zoneType)) or nil
end

local function applyLightbar(vehicle)
    if not vehicle or not isPoliceScript(vehicle:getScriptName()) or not vehicle:hasLightbar() then return end
    -- Police lightbars may arrive with a siren mode already active from the
    -- vehicle script or another spawn hook. Enforce silent lights before any
    -- idempotence, station, or existing-light checks.
    if vehicle:getLightbarSirenMode() > 0 then
        vehicle:setLightbarSirenMode(0)
        if getGameTime then
            local gameTime = getGameTime()
            if gameTime then vehicle:setSirenStartTime(gameTime:getWorldAgeHours()) end
        end
    end
    local data = vehicle:getModData()
    if data[MOD_DATA_KEY] then return end
    local zoneType = zoneTypeForVehicle(vehicle)
    if zoneType and stationZoneTypes[zoneType] then data[MOD_DATA_KEY] = "station:" .. zoneType; return end
    if vehicle:getLightbarLightsMode() > 0 then data[MOD_DATA_KEY] = "preexisting"; return end
    local lightbarPart = vehicle:getPartById("lightbar")
    if lightbarPart and lightbarPart:getCondition() == 0 then data[MOD_DATA_KEY] = "broken"; return end
    if ZombRand(100) >= LIGHTBAR_CHANCE_PERCENT then data[MOD_DATA_KEY] = "off"; return end
    vehicle:setLightbarLightsMode(2)
    data[MOD_DATA_KEY] = "on"
end

if isServer and isServer() and Events and Events.OnSpawnVehicleEnd then
    Events.OnSpawnVehicleEnd.Add(applyLightbar)
end
