-- Only KI5: Vehicle Spawn & Livery Overhaul (Build 42)
--
-- One late server-side authority for the external KI5 fleet, integrated
-- variants/liveries and authored regional routing. The late
-- OnLoadMapZones execution is deliberate: WayMoreCars injects smashed pools
-- during this event, so a normal module-load override is incomplete.

if isClient and isClient() then
    return
end

local Catalog = require "OnlyKI5VehicleSpawnLiveryOverhaul_Catalog"
local TrafficPolicy = require "OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy"
local SpawnAliases = require "OnlyKI5VehicleSpawnLiveryOverhaul_SpawnAliases"
local DuplicateScripts = require "OnlyKI5VehicleSpawnLiveryOverhaul_DuplicateScripts"
-- Same-mod filenames no longer provide the original inter-mod load-order
-- edge. Register the upstream military callbacks before the final policy.
require "OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_VehicleZoneDistribution"
require "OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_RegisterZones"

local PoliceRegions = require "OnlyKI5VehicleSpawnLiveryOverhaul_PoliceRegions"
local MOD_TAG = "[OnlyKI5VehicleSpawnLiveryOverhaul]"
local groups = Catalog.groups

-- Some active mods create world vehicles directly with addVehicleDebug,
-- bypassing every distribution table managed below. Keep this list limited
-- to audited automatic-world-spawn inputs: WayMoreCars' fixed news van and
-- ProjectALife's roadside/outpost/support vehicles, plus exact trailer aliases.
-- Advertising trailers now use KI5 cargo bodies at the user's request.
-- The redirect is script-ID scoped: another server-side caller passing one
-- of these exact aliases receives the same KI5 replacement.
local directVanillaSpawnGroups = {
    ["Base.CarNormal"] = "normal",
    ["Base.SmallCar"] = "compact",
    ["Base.SmallCar02"] = "compact",
    ["Base.CarStationWagon"] = "wagon",
    ["Base.CarStationWagon2"] = "wagon",
    ["Base.PickUpTruck"] = "pickup",
    ["Base.PickUpVan"] = "pickup",
    ["Base.PickUpTruck_Camo"] = "pickup",
    ["Base.PickUpVan_Camo"] = "pickup",
    ["Base.SUV"] = "suv",
    ["Base.OffRoad"] = "offroad",
    ["Base.ModernCar"] = "modern",
    ["Base.ModernCar02"] = "modern",
    ["Base.Van"] = "van",
    ["Base.StepVan"] = "commercial",
    ["Base.CarNormalSmashedFront"] = "normal",
    ["Base.PickUpTruckSmashedLeft"] = "pickup",
    ["Base.SUVSmashedRear"] = "suv",
    ["Base.OffRoadSmashedRight"] = "offroad",
    ["Base.CarLightsPolice"] = "policeGeneric",
}

local directRedirectLogged = {}
local function pickDirectCatalogVehicle(groupName)
    local candidates = Catalog.groups[groupName] or {}
    local weighted, totalWeight = {}, 0
    for _, scriptName in ipairs(candidates) do
        local weight = Catalog.weight(groupName, scriptName, "direct-spawn")
        if weight and weight > 0 then
            totalWeight = totalWeight + weight
            weighted[#weighted + 1] = { script = scriptName, weight = weight }
        end
    end
    if #weighted == 0 or totalWeight <= 0 then return nil end

    local roll
    if type(ZombRandFloat) == "function" then
        roll = ZombRandFloat(0, totalWeight)
    elseif type(ZombRand) == "function" then
        roll = ZombRand(1000000) * totalWeight / 1000000
    else
        return weighted[1].script
    end
    local cursor = 0
    for _, entry in ipairs(weighted) do
        cursor = cursor + entry.weight
        if roll < cursor then return entry.script end
    end
    return weighted[#weighted].script
end

local function directVehicleReplacement(scriptName)
    local alias = SpawnAliases.resolve(scriptName)
    if alias then return alias, "exact-spawn-alias" end
    local groupName = directVanillaSpawnGroups[scriptName]
    if not groupName then return nil end
    return pickDirectCatalogVehicle(groupName), groupName
end

local function installDirectVanillaVehicleRedirect()
    local marker = "__OnlyKI5VehicleSpawnLiveryOverhaul_DirectVanillaRedirectInstalled"
    if rawget(_G, marker) then return true end
    local originalAddVehicleDebug = rawget(_G, "addVehicleDebug")
    if type(originalAddVehicleDebug) ~= "function" then return false end

    _G.addVehicleDebug = function(scriptName, ...)
        local replacement, category = directVehicleReplacement(scriptName)
        if replacement then
            if not directRedirectLogged[scriptName] then
                print(MOD_TAG .. " redirected direct vanilla vehicle " .. tostring(scriptName)
                    .. " to " .. tostring(replacement) .. " (" .. tostring(category) .. ")")
                directRedirectLogged[scriptName] = true
            end
            scriptName = replacement
            -- addVehicleDebug arguments: direction, skin, square, ... .
            -- Keep coordinates/towing callers intact but discard vanilla skins.
            local arguments = { ... }
            local count = select("#", ...)
            if count >= 2 then arguments[2] = -1 end
            return originalAddVehicleDebug(scriptName, unpack(arguments, 1, count))
        end
        return originalAddVehicleDebug(scriptName, ...)
    end
    rawset(_G, marker, true)
    print(MOD_TAG .. " installed direct vanilla vehicle redirects for audited world-spawn paths")
    return true
end

installDirectVanillaVehicleRedirect()
if Events and Events.OnInitGlobalModData then
    Events.OnInitGlobalModData.Add(installDirectVanillaVehicleRedirect)
end

local replacements, smashedSources, managedScripts = {}, {}, {}
local emergencyKindByScript = {}
for _, groupName in ipairs({ "ranger", "fire", "ambulance" }) do
    for _, scriptName in ipairs(groups[groupName] or {}) do
        emergencyKindByScript[scriptName] = groupName
    end
end
for scriptName in pairs(Catalog.policeScripts or {}) do emergencyKindByScript[scriptName] = "police" end
for _, scriptName in ipairs({
    "Base.CarLightsRanger", "Base.PickUpVanLightsRanger", "Base.PickUpTruckLightsRanger",
}) do emergencyKindByScript[scriptName] = "ranger" end
for _, scriptName in ipairs({
    "Base.CarLightsPolice", "Base.PickUpVanLightsPolice", "Base.PickUpTruckLightsPolice",
}) do emergencyKindByScript[scriptName] = "police" end
for _, scriptName in ipairs({ "Base.PickUpVanLightsFire", "Base.PickUpTruckLightsFire" }) do
    emergencyKindByScript[scriptName] = "fire"
end
emergencyKindByScript["Base.VanAmbulance"] = "ambulance"

local function register(groupName, names)
    local candidates = groups[groupName]
    if type(candidates) ~= "table" or #candidates == 0 then
        error(MOD_TAG .. " catalog group is empty: " .. tostring(groupName))
    end
    for _, name in ipairs(names) do
        replacements[name] = groupName
    end
end

local function registerSmashed(groupName, prefixes)
    local directions = { "Rear", "Right", "Left", "Front" }
    for _, prefix in ipairs(prefixes) do
        for _, direction in ipairs(directions) do
            local sourceKey = "Base." .. prefix .. "Smashed" .. direction
            replacements[sourceKey] = groupName
            smashedSources[sourceKey] = true
        end
    end
end

for _, candidates in pairs(groups) do
    for _, scriptName in ipairs(candidates) do
        managedScripts[scriptName] = true
    end
end
local wreckedGroups = Catalog.wreckedGroups or {}
local militaryGroupByScript = {}
for _, scriptName in ipairs(groups.militaryCar or {}) do
    managedScripts[scriptName] = true
    militaryGroupByScript[scriptName] = "militaryCar"
end
for _, scriptName in ipairs(groups.militaryTruck or {}) do
    managedScripts[scriptName] = true
    militaryGroupByScript[scriptName] = "militaryTruck"
end
for _, scriptName in ipairs(groups.militaryTrailer or {}) do
    managedScripts[scriptName] = true
    militaryGroupByScript[scriptName] = "militaryTrailer"
end
for _, scriptName in ipairs(wreckedGroups.militaryCar or {}) do
    managedScripts[scriptName] = true
    militaryGroupByScript[scriptName] = "militaryCarWreck"
end
for _, scriptName in ipairs(wreckedGroups.militaryTruck or {}) do
    managedScripts[scriptName] = true
    militaryGroupByScript[scriptName] = "militaryTruckWreck"
end

-- Every non-burnt native B42 VehicleZoneDistribution selection is mapped to a
-- semantic KI5 category. Burnt pools intentionally do not appear here.
register("normal", { "Base.CarNormal" })
register("race", { "Base.RaceCar12", "Base.RaceCar34", "Base.RaceCar58" })
register("compact", { "Base.SmallCar", "Base.SmallCar02" })
register("taxi", { "Base.CarTaxi", "Base.CarTaxi2" })
register("wagon", { "Base.CarStationWagon", "Base.CarStationWagon2" })
register("pickup", { "Base.PickUpTruck", "Base.PickUpVan" })
register("van", { "Base.VanSeats", "Base.Van", "Base.VanSeats_Mural", "Base.VanSeatsAirportShuttle" })
register("commercial", {
    "Base.StepVan", "Base.StepVan_Blacksmith", "Base.StepVan_Butchers", "Base.StepVan_Cereal",
    "Base.StepVan_Citr8", "Base.StepVan_Florist", "Base.StepVan_Genuine_Beer", "Base.StepVan_Glass",
    "Base.StepVan_Heralds", "Base.StepVan_HuangsLaundry", "Base.StepVan_MarineBites",
    "Base.StepVan_Masonry", "Base.StepVan_Mechanic", "Base.StepVan_MobileLibrary",
    "Base.StepVan_Plonkies", "Base.StepVan_Propane", "Base.StepVan_Scarlet", "Base.StepVan_SmartKut",
    "Base.StepVan_SouthEasternHosp", "Base.StepVan_SouthEasternPaint", "Base.StepVan_USL",
    "Base.StepVan_Zippee", "Base.StepVanAirportCatering", "Base.StepVanMail",
})
register("modern", { "Base.ModernCar", "Base.ModernCar02" })
register("suv", { "Base.SUV" })
register("offroad", { "Base.OffRoad" })
register("luxury", { "Base.CarLuxury" })
register("sports", { "Base.SportsCar" })
register("police", { "Base.CarLightsPolice", "Base.PickUpVanLightsPolice", "Base.PickUpTruckLightsPolice" })
register("prisonPolice", { "Base.VanSeats_Prison" })
register("fire", { "Base.PickUpVanLightsFire", "Base.PickUpTruckLightsFire" })
register("ranger", { "Base.CarLightsRanger", "Base.PickUpVanLightsRanger", "Base.PickUpTruckLightsRanger" })
register("commercial", { "Base.PickUpVanMccoy", "Base.PickUpTruckMccoy", "Base.VanMccoy" })
register("commercial", {
    "Base.PickUpVanLightsCarpenter", "Base.VanCarpenter", "Base.VanBuilder", "Base.VanGardener",
    "Base.VanMechanic", "Base.VanMeltingPointMetal", "Base.VanMetalworker", "Base.VanMobileMechanics",
    "Base.PickUpVanBuilder", "Base.PickUpTruckLightsAirport", "Base.PickUpTruckLightsAirportSecurity",
})
register("ambulance", { "Base.VanAmbulance" })
register("militaryTruck", { "Base.PickUpTruck_Camo" })
register("militaryCar", { "Base.PickUpVan_Camo" })
register("trailer", { "Base.Trailer", "Base.Trailer_Livestock", "Base.TrailerAdvert", "Base.TrailerCover" })
register("commercial", {
    "Base.Van_Blacksmith", "Base.Van_BugWipers", "Base.Van_Charlemange_Beer", "Base.Van_CraftSupplies",
    "Base.Van_Glass", "Base.Van_HeritageTailors", "Base.Van_KnoxDisti", "Base.Van_Leather",
    "Base.Van_LectroMax", "Base.Van_Locksmith", "Base.Van_Masonry", "Base.Van_MassGenFac",
    "Base.Van_Perfick_Potato", "Base.Van_Transit", "Base.Van_VoltMojo", "Base.VanDeerValley",
    "Base.VanFossoil", "Base.VanGreenes", "Base.VanKnobCreekGas", "Base.VanKnoxCom", "Base.VanMail",
    "Base.VanOldMill", "Base.VanOvoFarm", "Base.VanPluggedInElectrics", "Base.VanRadio",
    "Base.VanRadio_3N", "Base.VanRadioJJ", "Base.VanSpiffo", "Base.VanUncloggers", "Base.PickUpTruckLightsFossoil",
    "Base.PickUpVanLightsFossoil",
})

registerSmashed("luxury", { "CarLuxury" })
registerSmashed("modern", { "ModernCar", "ModernCar02" })
registerSmashed("normal", { "CarNormal" })
registerSmashed("compact", { "CarSmall", "CarSmall02" })
registerSmashed("wagon", { "CarStationWagon" })
registerSmashed("offroad", { "OffRoad" })
registerSmashed("pickup", { "PickUpTruck", "PickUpVan" })
registerSmashed("commercial", { "StepVan", "StepVanMail" })
registerSmashed("suv", { "SUV" })
registerSmashed("police", { "CarLights", "PickUpTruckLights", "PickUpVanLights" })

-- Override broad trailer/commercial choices with body-appropriate aliases.
-- All zone tables (including modded children) use this same registry.
for source, group in pairs(SpawnAliases.groups) do
    register(group, { source })
end

local fallbackByZone = {
    police = "police", prison = "prisonPolice", fire = "fire", ranger = "ranger",
    mccoy = "commercial", carpenter = "commercial", postal = "commercial", ambulance = "ambulance",
    radio = "commercial", fossoil = "commercial", scarlet = "commercial", massgenfac = "commercial",
    transit = "commercial", network3 = "commercial", kyheralds = "commercial", lectromax = "commercial",
    knoxdisti = "commercial", advertising = "trailer", airportshuttle = "van",
    airportservice = "commercial", farm = "pickup", trades = "commercial", delivery = "commercial",
    professional = "luxury", middleClass = "normal", struggling = "compact", evacuee = "wagon",
    racecar = "race", spiffo = "commercial", military = "military",
}

local function copyProperties(properties, chance)
    local copy = {}
    if type(properties) == "table" then
        for key, value in pairs(properties) do copy[key] = value end
    end
    copy.index = copy.index or -1
    copy.spawnChance = chance
    return copy
end

local function setAmbulanceSkinIndex(scriptName, properties, zoneName)
    if scriptName == "Base.90fordF350ambulance" and type(properties) == "table" then
        -- KI5's index 0 is the intended white EMS livery. Index 1 is the
        -- red Brush/Rescue paint and must not be randomly used as an EMS unit.
        properties.index = 0
    end
end

local function addCandidates(vehicles, groupName, properties, zoneName)
    local candidates = groups[groupName] or {}
    if #candidates == 0 then return 0 end
    local totalChance = type(properties) == "table" and tonumber(properties.spawnChance) or nil
    totalChance = totalChance or 100
    local totalWeight = 0
    for _, scriptName in ipairs(candidates) do totalWeight = totalWeight + Catalog.weight(groupName, scriptName, zoneName) end
    if totalWeight <= 0 then return 0 end

    local added = 0
    for _, scriptName in ipairs(candidates) do
        local weight=Catalog.weight(groupName,scriptName,zoneName)
        local chance = totalChance * weight / totalWeight
        if weight>0 then
        if vehicles[scriptName] == nil then
            local copy = copyProperties(properties, chance)
            -- Source skin numbers belong to the replaced vanilla model.
            copy.index = -1
            setAmbulanceSkinIndex(scriptName, copy, zoneName)
            vehicles[scriptName] = copy
        elseif type(vehicles[scriptName]) == "table" and vehicles[scriptName].spawnChance ~= nil then
            vehicles[scriptName].spawnChance = vehicles[scriptName].spawnChance + chance
            vehicles[scriptName].index = -1
            setAmbulanceSkinIndex(scriptName, vehicles[scriptName], zoneName)
        end
        added = added + 1
        end
    end
    return added
end

local function rebalanceAmbulanceDistribution(vehicles, zoneName)
    if type(vehicles) ~= "table" then return 0 end
    local totalChance, template, found = 0, nil, false
    for _, scriptName in ipairs(groups.ambulance or {}) do
        local properties = vehicles[scriptName]
        if properties ~= nil then
            found = true
            if not template and type(properties) == "table" then template = properties end
            local chance = type(properties) == "table" and tonumber(properties.spawnChance) or nil
            totalChance = totalChance + (chance == nil and 100 or chance)
        end
    end
    if not found or totalChance <= 0 then
        for _, scriptName in ipairs(groups.ambulance or {}) do
            setAmbulanceSkinIndex(scriptName, vehicles[scriptName], zoneName)
        end
        return 0
    end

    local totalWeight = 0
    for _, scriptName in ipairs(groups.ambulance or {}) do
        totalWeight = totalWeight + Catalog.weight("ambulance", scriptName, zoneName)
    end
    if totalWeight <= 0 then return 0 end

    for _, scriptName in ipairs(groups.ambulance or {}) do vehicles[scriptName] = nil end
    local added = 0
    for _, scriptName in ipairs(groups.ambulance or {}) do
        local weight = Catalog.weight("ambulance", scriptName, zoneName)
        if weight > 0 then
            local properties = copyProperties(template, totalChance * weight / totalWeight)
            setAmbulanceSkinIndex(scriptName, properties, zoneName)
            vehicles[scriptName] = properties
            added = added + 1
        end
    end
    return added
end

local function addWreckedCandidates(vehicles, groupName, properties, zoneName)
    local candidates = wreckedGroups[groupName] or {}
    if #candidates == 0 then return 0 end
    local totalChance = type(properties) == "table" and tonumber(properties.spawnChance) or nil
    totalChance = totalChance or 100
    local totalWeight = 0
    for _, scriptName in ipairs(candidates) do totalWeight = totalWeight + Catalog.wreckedWeight(groupName, scriptName, zoneName) end
    if totalWeight <= 0 then return 0 end

    local added = 0
    for _, scriptName in ipairs(candidates) do
        local chance = totalChance * Catalog.wreckedWeight(groupName, scriptName, zoneName) / totalWeight
        if vehicles[scriptName] == nil then
            vehicles[scriptName] = copyProperties(properties, chance)
        elseif type(vehicles[scriptName]) == "table" and vehicles[scriptName].spawnChance ~= nil then
            vehicles[scriptName].spawnChance = vehicles[scriptName].spawnChance + chance
        end
        added = added + 1
    end
    return added
end

local function rebalanceMilitaryZone(vehicles)
    local totals = { militaryCar = 0, militaryTruck = 0, militaryCarWreck = 0, militaryTruckWreck = 0, militaryTrailer = 0 }
    for scriptName, properties in pairs(vehicles) do
        local groupName = militaryGroupByScript[scriptName]
        if groupName then
            local chance = type(properties) == "table" and tonumber(properties.spawnChance) or 0
            totals[groupName] = totals[groupName] + (chance or 0)
            vehicles[scriptName] = nil
        elseif emergencyKindByScript[scriptName] then
            -- A source mod can place a fire/police support vehicle in the raw
            -- military table. Keep those service vehicles out of VMZ's input;
            -- military roles are added back from the role catalog below.
            vehicles[scriptName] = nil
        end
    end
    local total = 0
    for _, chance in pairs(totals) do total = total + chance end
    if total <= 0 then return end

    -- Rebalance the dedicated base as one coherent military fleet instead of
    -- allowing the much larger upstream truck subtotal to drown out Humvees.
    -- Keep only small shares for trailers and wrecks; within the car/truck
    -- roles Catalog still enforces the requested 95% M998 / 75% AM General mix.
    local trailerBudget = math.min(total * 0.05, totals.militaryTrailer)
    local wreckInput = totals.militaryCarWreck + totals.militaryTruckWreck
    local wreckBudget = math.min(total * 0.10, wreckInput)
    local activeBudget = math.max(0, total - trailerBudget - wreckBudget)
    local properties = { index = -1 }
    properties.spawnChance = activeBudget * 0.5
    addCandidates(vehicles, "militaryCar", properties, "military")
    properties = { index = -1, spawnChance = activeBudget * 0.5 }
    addCandidates(vehicles, "militaryTruck", properties, "military")
    if trailerBudget > 0 then
        addCandidates(vehicles, "militaryTrailer", { index = -1, spawnChance = trailerBudget }, "military")
    end
    if wreckBudget > 0 then
        local carShare, truckShare = 0, 0
        if wreckInput > 0 then
            carShare = wreckBudget * totals.militaryCarWreck / wreckInput
            truckShare = wreckBudget * totals.militaryTruckWreck / wreckInput
        end
        if carShare > 0 then addWreckedCandidates(vehicles, "militaryCar", { index = -1, spawnChance = carShare }, "military") end
        if truckShare > 0 then addWreckedCandidates(vehicles, "militaryTruck", { index = -1, spawnChance = truckShare }, "military") end
    end
end

local function replaceEmergencyBurntVehicles()
    if type(VehicleZoneDistribution) ~= "table" then return 0 end
    local substitutions = {
        ["Base.NormalCarBurntPolice"] = "policeGeneric",
        ["Base.AmbulanceBurnt"] = "ambulance",
        ["Base.PickUpVanLightsBurnt"] = "policeGeneric",
    }
    local changed = 0
    for zoneName, zone in pairs(VehicleZoneDistribution) do
        if type(zone) == "table" and type(zone.vehicles) == "table" then
            for sourceName, groupName in pairs(substitutions) do
                local properties = zone.vehicles[sourceName]
                if properties ~= nil then
                    zone.vehicles[sourceName] = nil
                    addCandidates(zone.vehicles, groupName, properties, zoneName)
                    rebalanceAmbulanceDistribution(zone.vehicles, zoneName)
                    changed = changed + 1
                end
            end
        end
    end
    return changed
end

-- VMZ clearSpawnZones removes these inputs from non-military tables before
-- OnLoadMapZones consumers run. Capture authored role budgets, not vehicle IDs,
-- so finalization can restore rare roadside slots using canonical KI5 weights.
local roadsideMilitaryBudgets = {}
-- WayMoreCars builds modified_trfjm from trafficjams after VMZ has removed
-- military inputs, and may share the same vehicles table across all five names.
-- Use one zone meaning for military and emergency policy, including its budget
-- source; otherwise a later alias pass deletes the earlier pass's candidates.
local function policyZoneName(zoneName)
    if zoneName == "modified_trfjm" then return "trafficjams" end
    return type(zoneName) == "string" and string.lower(zoneName) or ""
end

local function isTrafficJamZone(zoneName)
    return string.find(policyZoneName(zoneName), "trafficjam", 1, true) ~= nil
end

local function roadsideBudgetForZone(zoneName, vehicles)
    local sourceName = policyZoneName(zoneName)
    local south = VehicleZoneDistribution and VehicleZoneDistribution.trafficjams
    if isTrafficJamZone(zoneName) and type(south) == "table" and south.vehicles == vehicles then
        -- WMC copies the south pool into every direction. Preserve that source
        -- role mix, rather than whichever alias Lua happens to visit first.
        sourceName = "trafficjams"
    end
    return roadsideMilitaryBudgets[sourceName] or roadsideMilitaryBudgets[zoneName]
end

local function captureRoadsideMilitaryBudgets()
    for zoneName, zone in pairs(VehicleZoneDistribution or {}) do
        if type(zone) == "table" and type(zone.vehicles) == "table" then
            local totals = { militaryCar = 0, militaryTruck = 0 }
            for script, properties in pairs(zone.vehicles) do
                local group = militaryGroupByScript[script]
                if totals[group] ~= nil and type(properties) == "table" then
                    totals[group] = totals[group] + (tonumber(properties.spawnChance) or 0)
                end
            end
            if totals.militaryCar + totals.militaryTruck > 0 and not roadsideMilitaryBudgets[zoneName] then
                roadsideMilitaryBudgets[zoneName] = totals
            end
        end
    end
end
captureRoadsideMilitaryBudgets()
if Events and Events.OnInitGlobalModData then Events.OnInitGlobalModData.Add(captureRoadsideMilitaryBudgets) end

local function normalizeMilitaryOutsideBase(vehicles, zoneName)
    local text = policyZoneName(zoneName)
    local allowWreck = text == "bad" or text == "medium" or text == "junkyard"
        or isTrafficJamZone(zoneName)
        or string.find(text, "crash", 1, true) ~= nil
        or string.find(text, "wreck", 1, true) ~= nil
    local wreckTotals = { militaryCarWreck = 0, militaryTruckWreck = 0 }
    local activeTotals = { militaryCar = 0, militaryTruck = 0 }
    local removedActive, removedWreck = false, false
    for scriptName, properties in pairs(vehicles) do
        local groupName = militaryGroupByScript[scriptName]
        if groupName then
            local chance = type(properties) == "table" and tonumber(properties.spawnChance) or 0
            if groupName == "militaryCarWreck" or groupName == "militaryTruckWreck" then
                if allowWreck then wreckTotals[groupName] = wreckTotals[groupName] + (chance or 0) end
                vehicles[scriptName] = nil
                removedWreck = true
            else
                -- Preserve rare roadside military slots, but distribute them
                -- through the same role weights as VMZ instead of source weights.
                if allowWreck and activeTotals[groupName] ~= nil then
                    activeTotals[groupName] = activeTotals[groupName] + (chance or 0)
                end
                vehicles[scriptName] = nil
                removedActive = true
            end
        end
    end
    local rawWreck = wreckTotals.militaryCarWreck + wreckTotals.militaryTruckWreck
    local savedBudget = roadsideBudgetForZone(zoneName, vehicles)
    if allowWreck and activeTotals.militaryCar + activeTotals.militaryTruck == 0 and savedBudget then
        activeTotals = savedBudget
    end
    local rawActive = activeTotals.militaryCar + activeTotals.militaryTruck
    if rawWreck <= 0 and rawActive <= 0 then return removedActive or removedWreck end

    local ordinaryWeight = 0
    for _, properties in pairs(vehicles) do
        if type(properties) == "table" then ordinaryWeight = ordinaryWeight + (tonumber(properties.spawnChance) or 0) end
    end
    if ordinaryWeight <= 0 then return removedActive or removedWreck end
    local cap = isTrafficJamZone(zoneName) and 0.0025 or (text == "junkyard" and 0.01 or 0.005)
    if rawActive > 0 then
        local activeBudget = math.min(rawActive, ordinaryWeight * cap)
        for _, group in ipairs({ "militaryCar", "militaryTruck" }) do
            if activeTotals[group] > 0 then
                addCandidates(vehicles, group, { index = -1, spawnChance = activeBudget * activeTotals[group] / rawActive }, zoneName)
            end
        end
    end
    local capped = math.min(rawWreck, ordinaryWeight * cap)
    local carShare = rawWreck > 0 and capped * wreckTotals.militaryCarWreck / rawWreck or 0
    local truckShare = rawWreck > 0 and capped * wreckTotals.militaryTruckWreck / rawWreck or 0
    if carShare > 0 then addWreckedCandidates(vehicles, "militaryCar", { index = -1, spawnChance = carShare }, zoneName) end
    if truckShare > 0 then addWreckedCandidates(vehicles, "militaryTruck", { index = -1, spawnChance = truckShare }, zoneName) end
    return true
end

-- Vehicle Military Zones (VMZNEW) turns the source `military` table into the
-- actual pools used by parking stalls. Those child pools must not be treated as
-- ordinary zones by normalizeMilitaryOutsideBase: that would erase them after
-- VMZ has already split the source list. Rebuild each pool after VMZ runs.
local vmzMilitaryPoolKinds = {
    military_vehicle = "active-all",
    military_vehicle_angled = "active-all",
    military_vehicle_light = "active-light",
    military_vehicle_light_angled = "active-light",
    military_vehicle_heavy = "active-heavy",
    military_vehicle_heavy_angled = "active-heavy",
    military_burnt = "burnt",
    military_trailer = "trailer-all",
    military_trailer_angled = "trailer-all",
    military_trailer_light = "trailer-light",
    military_trailer_light_angled = "trailer-light",
    military_trailer_heavy = "trailer-heavy",
    military_trailer_heavy_angled = "trailer-heavy",
}

local vmzMilitaryPoolDefinitions = {
    { name = "military_vehicle", kind = "active-all" },
    { name = "military_vehicle_angled", kind = "active-all" },
    { name = "military_vehicle_light", kind = "active-light" },
    { name = "military_vehicle_light_angled", kind = "active-light" },
    { name = "military_vehicle_heavy", kind = "active-heavy" },
    { name = "military_vehicle_heavy_angled", kind = "active-heavy" },
    { name = "military_burnt", kind = "burnt" },
    { name = "military_trailer", kind = "trailer-all" },
    { name = "military_trailer_angled", kind = "trailer-all" },
    { name = "military_trailer_light", kind = "trailer-light" },
    { name = "military_trailer_light_angled", kind = "trailer-light" },
    { name = "military_trailer_heavy", kind = "trailer-heavy" },
    { name = "military_trailer_heavy_angled", kind = "trailer-heavy" },
}

local vmzVehicleHeavyCache = {}
local vmzTrailerHeavyCache = {}

local function vmzVehicleIsHeavy(scriptName)
    if vmzVehicleHeavyCache[scriptName] ~= nil then return vmzVehicleHeavyCache[scriptName] end
    local script = ScriptManager and ScriptManager.instance and ScriptManager.instance:getVehicle(scriptName)
    if not script then return nil end
    local mass = tonumber(script:getMass()) or 0
    local force = tonumber(script:getEngineForce()) or 0
    local loudness = tonumber(script:getEngineLoudness()) or 0
    local heavy = (mass * force * loudness) / 1000000 > 425
    vmzVehicleHeavyCache[scriptName] = heavy
    return heavy
end

local function vmzTrailerIsHeavy(scriptName)
    if vmzTrailerHeavyCache[scriptName] ~= nil then return vmzTrailerHeavyCache[scriptName] end
    local script = ScriptManager and ScriptManager.instance and ScriptManager.instance:getVehicle(scriptName)
    if not script then return nil end
    local heavy = (tonumber(script:getOffroadEfficiency()) or 0) > 1.01
    vmzTrailerHeavyCache[scriptName] = heavy
    return heavy
end

local isAMGeneralTruck = TrafficPolicy.isAMGeneralTruck

local function isM35TransportTruck(scriptName)
    return scriptName == "Base.78amgeneralM35A2" or scriptName == "Base.78amgeneralM35A2Burnt"
end

local function militaryCandidateWeight(groupName, scriptName, wrecked)
    if wrecked then return Catalog.wreckedWeight(groupName, scriptName, "military") end
    return Catalog.weight(groupName, scriptName, "military")
end

local function militaryGroupCandidates(groupName, wrecked)
    if wrecked then return wreckedGroups[groupName] or {} end
    return groups[groupName] or {}
end

local function hasMilitaryCandidates(groupName, includeCandidate, wrecked)
    for _, scriptName in ipairs(militaryGroupCandidates(groupName, wrecked)) do
        if (not includeCandidate or includeCandidate(scriptName))
            and militaryCandidateWeight(groupName, scriptName, wrecked) > 0 then
            return true
        end
    end
    return false
end

local function addWeightedMilitaryCandidates(vehicles, groupName, budget, includeCandidate, wrecked, preferredShare, isPreferred)
    local preferred, others, otherWeight = {}, {}, 0
    for _, scriptName in ipairs(militaryGroupCandidates(groupName, wrecked)) do
        if not includeCandidate or includeCandidate(scriptName) then
            local weight = militaryCandidateWeight(groupName, scriptName, wrecked)
            if weight and weight > 0 then
                if isPreferred and isPreferred(scriptName) then
                    table.insert(preferred, scriptName)
                else
                    table.insert(others, { script = scriptName, weight = weight })
                    otherWeight = otherWeight + weight
                end
            end
        end
    end

    local added = 0
    local preferredBudget = 0
    if #preferred > 0 then
        preferredBudget = otherWeight > 0 and budget * preferredShare or budget
        for _, scriptName in ipairs(preferred) do
            vehicles[scriptName] = copyProperties({ index = -1 }, preferredBudget / #preferred)
            added = added + 1
        end
    end
    local otherBudget = budget - preferredBudget
    if otherWeight > 0 then
        for _, entry in ipairs(others) do
            vehicles[entry.script] = copyProperties({ index = -1 }, otherBudget * entry.weight / otherWeight)
            added = added + 1
        end
    end
    return added
end

local function addVMZMilitaryTruckCandidates(vehicles, budget, includeCandidate, wrecked)
    local amFilter = function(scriptName)
        return isAMGeneralTruck(scriptName) and (not includeCandidate or includeCandidate(scriptName))
    end
    local otherFilter = function(scriptName)
        return not isAMGeneralTruck(scriptName) and (not includeCandidate or includeCandidate(scriptName))
    end
    local hasAM = hasMilitaryCandidates("militaryTruck", amFilter, wrecked)
    local hasOther = hasMilitaryCandidates("militaryTruck", otherFilter, wrecked)
    if not hasAM and not hasOther then return 0 end

    local amBudget = hasAM and hasOther and budget * TrafficPolicy.amGeneralTruckShare() or (hasAM and budget or 0)
    local otherBudget = budget - amBudget
    local added = 0
    if amBudget > 0 then
        -- Keep the 75% AM General family share, but make the M35A2 cargo
        -- transport 85% of that family instead of splitting it evenly across
        -- rarer tankers, wreckers, and specialized variants.
        added = added + addWeightedMilitaryCandidates(
            vehicles, "militaryTruck", amBudget, amFilter, wrecked, 0.85, isM35TransportTruck)
    end
    if otherBudget > 0 then
        added = added + addWeightedMilitaryCandidates(
            vehicles, "militaryTruck", otherBudget, otherFilter, wrecked, nil, nil)
    end
    return added
end

local function activePoolClassFilter(kind)
    if kind == "active-all" then return nil end
    local expectHeavy = kind == "active-heavy"
    return function(scriptName)
        local heavy = vmzVehicleIsHeavy(scriptName)
        return heavy ~= nil and heavy == expectHeavy
    end
end

local function addVMZActivePool(vehicles, kind)
    local filter = activePoolClassFilter(kind)
    local roles = {}
    local includeCars = kind ~= "active-heavy"
    local includeTrucks = kind ~= "active-light"
    if includeCars and hasMilitaryCandidates("militaryCar", filter, false) then
        table.insert(roles, { name = "militaryCar", share = TrafficPolicy.humveeShare(), preferred = function(name) return name == "Base.92amgeneralM998" end })
    end
    if includeTrucks and hasMilitaryCandidates("militaryTruck", filter, false) then
        table.insert(roles, { name = "militaryTruck" })
    end
    if #roles == 0 then return 0 end

    local budget = 100 / #roles
    local added = 0
    for _, role in ipairs(roles) do
        if role.name == "militaryTruck" then
            added = added + addVMZMilitaryTruckCandidates(vehicles, budget, filter, false)
        else
            added = added + addWeightedMilitaryCandidates(vehicles, role.name, budget, filter, false, role.share, role.preferred)
        end
    end
    return added
end

local function addVMZBurntPool(vehicles)
    local roles = {}
    if hasMilitaryCandidates("militaryCar", nil, true) then
        table.insert(roles, { name = "militaryCar", share = TrafficPolicy.humveeShare(), preferred = function(name) return name == "Base.92amgeneralM998Burnt" end })
    end
    if hasMilitaryCandidates("militaryTruck", nil, true) then
        table.insert(roles, { name = "militaryTruck" })
    end
    if #roles == 0 then return 0 end

    local budget = 100 / #roles
    local added = 0
    for _, role in ipairs(roles) do
        if role.name == "militaryTruck" then
            added = added + addVMZMilitaryTruckCandidates(vehicles, budget, nil, true)
        else
            added = added + addWeightedMilitaryCandidates(vehicles, role.name, budget, nil, true, role.share, role.preferred)
        end
    end
    return added
end

local function addVMZTrailerPool(vehicles, kind)
    local filter = nil
    if kind ~= "trailer-all" then
        local expectHeavy = kind == "trailer-heavy"
        filter = function(scriptName)
            local heavy = vmzTrailerIsHeavy(scriptName)
            return heavy ~= nil and heavy == expectHeavy
        end
    end
    return addWeightedMilitaryCandidates(vehicles, "militaryTrailer", 100, filter, false, nil, nil)
end

local function militaryGroupShare(vehicles, groupName, isPreferred)
    if type(vehicles) ~= "table" then return nil end
    local total, preferred = 0, 0
    for scriptName, properties in pairs(vehicles) do
        if militaryGroupByScript[scriptName] == groupName and type(properties) == "table" then
            local chance = tonumber(properties.spawnChance) or 0
            total = total + chance
            if isPreferred(scriptName) then preferred = preferred + chance end
        end
    end
    if total <= 0 then return nil end
    return preferred * 100 / total
end

local function percentText(value)
    if value == nil then return "n/a" end
    return string.format("%.1f%%", value)
end

local function rebalanceVMZMilitaryPools()
    local stats = { poolTables = 0, vehicleCandidates = 0 }
    if type(VehicleZoneDistribution) ~= "table" then return stats end

    local processedTables = {}
    for _, definition in ipairs(vmzMilitaryPoolDefinitions) do
        local zone = VehicleZoneDistribution[definition.name]
        if type(zone) == "table" and type(zone.vehicles) == "table" and not processedTables[zone.vehicles] then
            local vehicles = zone.vehicles
            processedTables[vehicles] = true
            for scriptName in pairs(vehicles) do vehicles[scriptName] = nil end

            local added = 0
            if string.sub(definition.kind, 1, 6) == "active" then
                added = addVMZActivePool(vehicles, definition.kind)
            elseif definition.kind == "burnt" then
                added = addVMZBurntPool(vehicles)
            else
                added = addVMZTrailerPool(vehicles, definition.kind)
            end
            stats.poolTables = stats.poolTables + 1
            stats.vehicleCandidates = stats.vehicleCandidates + added
        end
    end

    local allVehicles = VehicleZoneDistribution.military_vehicle and VehicleZoneDistribution.military_vehicle.vehicles
    local lightVehicles = VehicleZoneDistribution.military_vehicle_light and VehicleZoneDistribution.military_vehicle_light.vehicles
    local heavyVehicles = VehicleZoneDistribution.military_vehicle_heavy and VehicleZoneDistribution.military_vehicle_heavy.vehicles
    local burntVehicles = VehicleZoneDistribution.military_burnt and VehicleZoneDistribution.military_burnt.vehicles
    stats.allCarShare = militaryGroupShare(allVehicles, "militaryCar", function(name) return name == "Base.92amgeneralM998" end)
    stats.allTruckShare = militaryGroupShare(allVehicles, "militaryTruck", isAMGeneralTruck)
    stats.allM35TruckShare = militaryGroupShare(allVehicles, "militaryTruck", isM35TransportTruck)
    stats.lightHumveeShare = militaryGroupShare(lightVehicles, "militaryCar", function(name) return name == "Base.92amgeneralM998" end)
    stats.heavyAMGeneralShare = militaryGroupShare(heavyVehicles, "militaryTruck", isAMGeneralTruck)
    stats.heavyM35TruckShare = militaryGroupShare(heavyVehicles, "militaryTruck", isM35TransportTruck)
    stats.burntHumveeShare = militaryGroupShare(burntVehicles, "militaryCarWreck", function(name) return name == "Base.92amgeneralM998Burnt" end)
    stats.burntAMGeneralShare = militaryGroupShare(burntVehicles, "militaryTruckWreck", isAMGeneralTruck)
    stats.burntM35TruckShare = militaryGroupShare(burntVehicles, "militaryTruckWreck", isM35TransportTruck)
    return stats
end

local function militaryPoolLog(stats)
    stats = stats or {}
    local highway = VehicleZoneDistribution and VehicleZoneDistribution.modified_trfjm
    local highwayVehicles = type(highway) == "table" and highway.vehicles or nil
    local highwayHumvees = militaryGroupShare(highwayVehicles, "militaryCar", function(name) return name == "Base.92amgeneralM998" end)
    local highwayTrucks = militaryGroupShare(highwayVehicles, "militaryTruck", isAMGeneralTruck)
    return string.format("vmzPools=%d vmzCandidates=%d militaryAllCarShare=%s militaryAllTruckShare=%s militaryAllM35TruckShare=%s militaryLightHumveeShare=%s militaryHeavyAMGeneralShare=%s militaryHeavyM35TruckShare=%s militaryBurntHumveeShare=%s militaryBurntAMGeneralShare=%s militaryBurntM35TruckShare=%s highwayPool=modified_trfjm highwayHumveeShare=%s highwayAMGeneralShare=%s",
        stats.poolTables or 0, stats.vehicleCandidates or 0, percentText(stats.allCarShare), percentText(stats.allTruckShare),
        percentText(stats.allM35TruckShare), percentText(stats.lightHumveeShare), percentText(stats.heavyAMGeneralShare),
        percentText(stats.heavyM35TruckShare), percentText(stats.burntHumveeShare), percentText(stats.burntAMGeneralShare), percentText(stats.burntM35TruckShare),
        percentText(highwayHumvees), percentText(highwayTrucks))
end

local originalRangerSpawnRate = nil
local function reduceRangerSpawnRate()
    local zone = type(VehicleZoneDistribution) == "table" and VehicleZoneDistribution.ranger or nil
    if type(zone) ~= "table" then return nil, nil end
    local current = tonumber(zone.spawnRate) or 16
    if current <= 0 then return current, current end
    originalRangerSpawnRate = originalRangerSpawnRate or current
    local reduced = math.max(1, math.floor(originalRangerSpawnRate * 0.25 + 0.5))
    zone.spawnRate = reduced
    zone.specialCar = false
    return current, reduced
end

local function stripRangersOutsideRangerZones()
    local removed = 0
    if type(VehicleZoneDistribution) ~= "table" then return removed end
    for zoneName, zone in pairs(VehicleZoneDistribution) do
        if type(zoneName) == "string" and not string.find(zoneName, "ranger", 1, true)
            and type(zone) == "table" and type(zone.vehicles) == "table" then
            for scriptName in pairs(zone.vehicles) do
                if emergencyKindByScript[scriptName] == "ranger" then
                    zone.vehicles[scriptName] = nil
                    removed = removed + 1
                end
            end
        end
    end
    return removed
end

local function balanceTrafficEmergency()
    if type(VehicleZoneDistribution) ~= "table" then return 0 end
    local seen, changed = {}, 0
    local caps = { police = 0.01, fire = 0.005, ambulance = 0.005 }
    for zoneName, zone in pairs(VehicleZoneDistribution) do
        local traffic = isTrafficJamZone(zoneName)
        local vehicles = traffic and type(zone) == "table" and zone.vehicles or nil
        if type(vehicles) == "table" and not seen[vehicles] then
            seen[vehicles] = true -- the directional vanilla jams may share this table
            local civilianWeight, totals = 0, { police = 0, fire = 0, ambulance = 0 }
            for scriptName, properties in pairs(vehicles) do
                local kind = emergencyKindByScript[scriptName]
                if kind == "ranger" or PoliceRegions.isTactical(scriptName) then
                    vehicles[scriptName] = nil
                    changed = changed + 1
                else
                    local weight = type(properties) == "table" and tonumber(properties.spawnChance) or 0
                    if totals[kind] ~= nil then totals[kind] = totals[kind] + (weight or 0)
                    else civilianWeight = civilianWeight + (weight or 0) end
                end
            end
            if civilianWeight > 0 then
                for kind, cap in pairs(caps) do
                    -- Using the civilian weight as the base guarantees the
                    -- final share stays below the cap even if the other
                    -- emergency categories are absent from this zone.
                    local target = civilianWeight * cap
                    if totals[kind] > target then
                        local factor = target / totals[kind]
                        for scriptName, properties in pairs(vehicles) do
                            if emergencyKindByScript[scriptName] == kind and type(properties) == "table" then
                                properties.spawnChance = (tonumber(properties.spawnChance) or 0) * factor
                                changed = changed + 1
                            end
                        end
                    end
                end
            end
        end
    end
    return changed
end

local function addMilitaryFallback(vehicles, zoneName)
    local properties = { index = -1, spawnChance = 50 }
    addCandidates(vehicles, "militaryCar", properties, zoneName)
    addCandidates(vehicles, "militaryTruck", properties, zoneName)
end

local function hasManagedVehicle(vehicles)
    for scriptName, _ in pairs(vehicles) do
        if managedScripts[scriptName] then return true end
    end
    return false
end

local function hasMilitaryVehicle(vehicles)
    for scriptName in pairs(vehicles) do
        local groupName = militaryGroupByScript[scriptName]
        if groupName == "militaryCar" or groupName == "militaryTruck" or groupName == "militaryTrailer" then
            return true
        end
    end
    return false
end

local function applyZoneRegistry()
    if type(VehicleZoneDistribution) ~= "table" then return false, 0, 0, 0 end
    TrafficPolicy.normalizeRegistryKeys()
    local converted, smashedConverted, fallbackCount = 0, 0, 0
    for zoneName, zone in pairs(VehicleZoneDistribution) do
        if type(zone) == "table" and type(zone.vehicles) == "table" then
            local vehicles = zone.vehicles
            for sourceKey, groupName in pairs(replacements) do
                local properties = vehicles[sourceKey]
                if properties ~= nil then
                    vehicles[sourceKey] = nil
                    local targetGroup = groupName
                    if zoneName == "military" and groupName == "trailer" then targetGroup = "militaryTrailer" end
                    addCandidates(vehicles, targetGroup, properties, zoneName)
                    converted = converted + 1
                    if smashedSources[sourceKey] then smashedConverted = smashedConverted + 1 end
                end
            end
            local fallbackGroup = fallbackByZone[zoneName]
            local hasFallbackVehicle = false
            if fallbackGroup == "military" then
                hasFallbackVehicle = hasMilitaryVehicle(vehicles)
            elseif fallbackGroup then
                hasFallbackVehicle = hasManagedVehicle(vehicles)
            end
            if fallbackGroup and not hasFallbackVehicle then
                if fallbackGroup == "military" then
                    addMilitaryFallback(vehicles, zoneName)
                else
                    addCandidates(vehicles, fallbackGroup, { index = -1, spawnChance = 100 }, zoneName)
                end
                fallbackCount = fallbackCount + 1
            end
            rebalanceAmbulanceDistribution(vehicles, zoneName)
            if zoneName == "military" or zoneName == "army" then
                rebalanceMilitaryZone(vehicles)
            elseif not vmzMilitaryPoolKinds[zoneName] then
                normalizeMilitaryOutsideBase(vehicles, zoneName)
            end
        end
    end
    return true, converted, smashedConverted, fallbackCount
end

local function suppressDuplicateVehicles()
    if type(VehicleZoneDistribution) ~= "table" then return 0 end
    local removed = 0
    for _, zone in pairs(VehicleZoneDistribution) do
        if type(zone) == "table" and type(zone.vehicles) == "table" then
            for scriptName, _ in pairs(DuplicateScripts) do
                if zone.vehicles[scriptName] ~= nil then
                    zone.vehicles[scriptName] = nil
                    removed = removed + 1
                end
            end
        end
    end
    return removed
end

local function applyProfessionRegistry()
    if type(ProfessionVehicles) ~= "table" then return false, 0 end
    local registry = {}
    local function role(name, groupName, alternateGroup)
        registry[name] = { General = Catalog.weightedCopy(groupName, 250), Alternate = Catalog.weightedCopy(alternateGroup or groupName, 250) }
    end
    local function weightedRole(name, groupName)
        registry[name] = { General = Catalog.weightedCopy(groupName, 1000), Alternate = Catalog.weightedCopy(groupName, 1000) }
    end
    local function scene(name, ...)
        registry[name] = Catalog.weightedCombine(250, ...)
    end
    local function regionalPoliceRole()
        local result = { General = Catalog.weightedCopy("policeGeneric", 250), Alternate = Catalog.weightedCopy("policeGeneric", 250) }
        for storyRegion, liveryKey in pairs(PoliceRegions.professionRegions) do
            local scripts = PoliceRegions.patrolLiveries[liveryKey] or {}
            result[storyRegion] = Catalog.weightedList("police", scripts, 250)
        end
        return result
    end

    scene("Louisville", "commercial", "van")
    scene("MarchRidge", "commercial", "pickup")
    scene("Muldraugh", "commercial", "pickup")
    scene("Riverside", "commercial", "pickup")
    scene("Rosewood", "commercial", "van")
    scene("WestPoint", "commercial", "pickup")
    registry.LAA = Catalog.weightedCombine(250, "commercial", "fire")
    for _, scriptName in ipairs(Catalog.weightedList("police", PoliceRegions.liveries.airportSecurity, 125)) do
        registry.LAA[#registry.LAA + 1] = scriptName
    end

    registry.CarLightsPolice = regionalPoliceRole()
    registry.PickUpVanLightsPolice = regionalPoliceRole()
    registry.PickUpTruckLightsPolice = regionalPoliceRole()
    role("VanSeats_Prison", "prisonPolice")
    role("PickUpTruckLightsFire", "fire")
    role("PickUpVanLightsFire", "fire")
    role("CarLightsRanger", "ranger")
    role("PickUpVanLightsRanger", "ranger")
    role("PickUpTruckLightsRanger", "ranger")
    role("CarNormal", "normal")
    role("CarStationWagon", "wagon")
    role("CarStationWagon2", "wagon")
    role("SUV", "suv")
    role("CarLuxury", "luxury")
    role("OffRoad", "offroad")
    role("Van", "van")
    role("VanSeats", "van")
    role("VanSeats_Mural", "van")
    role("PickUpVan", "suv")
    role("PickUpTruck", "pickup")
    weightedRole("PickUpTruck_Camo", "militaryTruck")
    weightedRole("PickUpVan_Camo", "militaryCar")
    role("VanAmbulance", "ambulance")
    role("VanMail", "commercial")
    role("VanRadio_3N", "commercial")
    role("VanMechanic", "commercial")
    role("VanBuilder", "commercial")
    role("VanCarpenter", "commercial")
    role("VanGardener", "commercial")
    role("VanMeltingPointMetal", "commercial")
    role("VanMetalworker", "commercial")
    role("StepVan_Heralds", "commercial")
    role("StepVan_MobileLibrary", "commercial")
    role("StepVan_SouthEasternHosp", "ambulance", "commercial")
    role("Trailer", "trailer")
    role("TrailerCover", "trailer")
    role("TrailerAdvert", "trailer")
    for source, group in pairs(SpawnAliases.groups) do
        role(string.sub(source, 6), group)
    end

    local aliases = {
        PickUpVanBuilder = "VanBuilder", PickUpVanLightsCarpenter = "VanCarpenter",
        PickUpVanMetalworker = "VanMetalworker", StepVan_Mechanic = "VanMechanic",
        PickUpTruckLightsFossoil = "PickUpTruck", PickUpTruckMccoy = "PickUpTruck",
        CarLights = "CarLightsRanger", VanRadio = "VanRadio_3N",
    }
    local applied = 0
    for name, replacement in pairs(registry) do ProfessionVehicles[name] = replacement; applied = applied + 1 end
    for target, source in pairs(aliases) do ProfessionVehicles[target] = registry[source]; applied = applied + 1 end
    return true, applied
end

-- Authored Only KI5: Vehicle Spawn & Livery Overhaul regional routing. After capturing
-- KI5 source weights, it removes only KI5 livery IDs from broad/global pools.
-- The vanilla police source models are replaced by the KI5 registry, and each
-- regional police distribution contains only the KI5 liveries assigned there.
local allSkinScripts = {
    "Base.92fordCVPIWestPoint", "Base.92fordCVPIMeade", "Base.92fordCVPILouisville", "Base.92fordCVPIMuldraugh", "Base.92fordCVPIBulletin",
    "Base.92fordCVPI2WestPoint", "Base.92fordCVPI2Meade", "Base.92fordCVPI2Louisville", "Base.92fordCVPI2Muldraugh", "Base.92fordCVPI2Bulletin",
    "Base.91fordLTDpdMeade", "Base.91fordLTDpdWestPoint", "Base.91fordLTDpdMuldraugh", "Base.91fordLTDpdBulletin", "Base.91fordLTDpdLouisville", "Base.91fordLTDpdLCPD",
    "Base.93chevySuburbanpdWestPoint", "Base.93chevySuburbanpdMuldraugh", "Base.93chevySuburbanpdBulletin", "Base.93chevySuburbanpdLouisville", "Base.93chevySuburbanpdMeade",
    "Base.93chevySilveradoCClongLouisville", "Base.93chevySilveradoCClongMuldraugh", "Base.93chevySilveradoCClongSecurity",
    "Base.89fordBroncoMeade", "Base.89fordBroncoBulletin", "Base.89fordBroncoWestPoint", "Base.89fordBroncoMuldraugh",
    "Base.93fordF350pdWestPoint", "Base.93fordF350pdBulletin", "Base.93fordF350pdMeade", "Base.93fordF350pdMuldraugh", "Base.93fordF350pdLouisville",
    "Base.85chevyImpalaSedanBCS", "Base.85chevyImpalaSedanCLPD", "Base.85chevyImpalaSedanLCPD", "Base.85chevyImpalaSedanMCS", "Base.85chevyImpalaSedanMPD", "Base.85chevyImpalaSedanWPPD",
    "Base.93chevySuburbanPoliceBCS", "Base.93chevySuburbanPoliceCLPD", "Base.93chevySuburbanPoliceLCPD", "Base.93chevySuburbanPoliceMCS", "Base.93chevySuburbanPoliceMPD", "Base.93chevySuburbanPoliceWPPD",
    "Base.93chevySilveradoPoliceBCS", "Base.93chevySilveradoPoliceMCS", "Base.93chevySuburbanAirportSec", "Base.93chevySuburbanPrison", "Base.93chevySilveradoAirport",
    "Base.85chevyStepVanSWAT", "Base.90fordF350SWAT", "Base.87fordF700swat",
    "Base.92amgeneralM998SWAT", "Base.87fordF700Lswat", "Base.87fordB700Ksprison",
}
local skinSet = {}
for _, scriptName in ipairs(allSkinScripts) do skinSet[scriptName] = true end
for _, scriptName in ipairs(Catalog.regionalPoliceScripts or {}) do skinSet[scriptName] = true end
local liveryScripts = PoliceRegions.patrolLiveries
local distributionForRegion = PoliceRegions.distributionForRegion
local vanillaGeneralFallbacks = {
    ["1428:5850:22:5"] = true, ["1434:5862:5:42"] = true, ["1441:5862:5:42"] = true, ["2033:5960:18:5"] = true,
    ["7262:8366:5:9"] = true, ["7258:8383:3:5"] = true, ["2483:13949:5:15"] = true, ["2496:13963:3:5"] = true,
    ["2496:13957:3:5"] = true, ["2496:13940:3:5"] = true, ["2496:13928:3:5"] = true,
}

local function copyDistributionShell(source)
    local result = {}
    for key, value in pairs(source) do
        if key == "vehicles" and type(value) == "table" then result.vehicles = {}
        else result[key] = value end
    end
    result.vehicles = result.vehicles or {}
    return result
end

local function captureWeights(vehicles, sourceWeights, overwrite)
    for scriptName, _ in pairs(skinSet) do
        local properties = vehicles[scriptName]
        if type(properties) == "table" and type(properties.spawnChance) == "number" and (overwrite or sourceWeights[scriptName] == nil) then
            sourceWeights[scriptName] = properties.spawnChance
        end
    end
end

local function removeSkinScripts(vehicles)
    for scriptName, _ in pairs(skinSet) do vehicles[scriptName] = nil end
end

local function addLiveries(distribution, scripts, sourceWeights)
    for _, scriptName in ipairs(scripts) do distribution.vehicles[scriptName] = { index = -1, spawnChance = sourceWeights[scriptName] or 11 } end
end

local function addRareTactical(distribution, scripts)
    if type(scripts) ~= "table" or #scripts == 0 then return end
    local patrolWeight = 0
    for _, properties in pairs(distribution.vehicles) do
        patrolWeight = patrolWeight + (tonumber(properties.spawnChance) or 0)
    end
    local eachWeight = patrolWeight * 0.0025 / (0.9975 * #scripts)
    for _, scriptName in ipairs(scripts) do
        distribution.vehicles[scriptName] = { index = -1, spawnChance = eachWeight }
    end
end

local function applyRegionalPolice()
    if type(VehicleZoneDistribution) ~= "table" then return false, {} end
    local police = VehicleZoneDistribution.police
    if type(police) ~= "table" or type(police.vehicles) ~= "table" then return false, {} end
    local sourceWeights, created = {}, {}
    captureWeights(police.vehicles, sourceWeights, true)
    if type(VehicleZoneDistribution.parkingstall) == "table" and type(VehicleZoneDistribution.parkingstall.vehicles) == "table" then
        captureWeights(VehicleZoneDistribution.parkingstall.vehicles, sourceWeights, false)
    end
    if type(VehicleZoneDistribution.trafficjams) == "table" and type(VehicleZoneDistribution.trafficjams.vehicles) == "table" then
        captureWeights(VehicleZoneDistribution.trafficjams.vehicles, sourceWeights, false)
    end
    for _, distribution in pairs(VehicleZoneDistribution) do
        if type(distribution) == "table" and type(distribution.vehicles) == "table" then
            captureWeights(distribution.vehicles, sourceWeights, false)
        end
    end
    for distributionName, distribution in pairs(VehicleZoneDistribution) do
        if string.sub(distributionName, 1, 19) ~= "only_ki5_overhaul_police_"
            and type(distribution) == "table" and type(distribution.vehicles) == "table" then
            removeSkinScripts(distribution.vehicles)
        end
    end

    local definitions = {
        { "only_ki5_overhaul_police_louisville", "police", liveryScripts.louisville, "louisville" },
        { "only_ki5_overhaul_police_louisville_county", "police", liveryScripts.louisvilleCounty },
        { "only_ki5_overhaul_police_muldraugh", "police", liveryScripts.muldraugh },
        { "only_ki5_overhaul_police_meade", "police", liveryScripts.meade },
        { "only_ki5_overhaul_police_westpoint", "police", liveryScripts.westPoint },
        { "only_ki5_overhaul_police_bulletin", "police", liveryScripts.bulletin },
        { "only_ki5_overhaul_police_airport_security", "airportservice", liveryScripts.airportSecurity },
        { "only_ki5_overhaul_police_prison_transport", "prison", liveryScripts.prisonTransport },
    }
    for _, definition in ipairs(definitions) do
        local source = VehicleZoneDistribution[definition[2]]
        if type(source) == "table" and type(source.vehicles) == "table" then
            local copy = copyDistributionShell(source)
            addLiveries(copy, definition[3], sourceWeights)
            addRareTactical(copy, PoliceRegions.allowedTactical[definition[4]])
            VehicleZoneDistribution[definition[1]] = copy
            created[definition[1]] = true
        end
    end
    return true, created
end

local function normalized(value) return string.lower(value or "") end
local function zoneKey(zone) return string.format("%d:%d:%d:%d", zone:getX(), zone:getY(), zone:getWidth(), zone:getHeight()) end
local function originalName(zone)
    local original = zone:getOriginalName()
    if original and original ~= "" then return normalized(original) end
    return normalized(zone:getName())
end
local function regionForZone(metaGrid, zone)
    local regions = metaGrid:getZonesAt(zone:getX(), zone:getY(), zone:getZ())
    if not regions then return nil end
    local selected, selectedPriority = nil, nil
    for index = 0, regions:size() - 1 do
        local candidate = regions:get(index)
        if candidate and normalized(candidate:getType()) == "region" then
            local name = normalized(candidate:getName())
            local priority = PoliceRegions.regionPriority[name]
            if priority and (selectedPriority == nil or priority < selectedPriority) then
                selected, selectedPriority = name, priority
            end
        end
    end
    return selected
end

local function routeRegionalPolice(created)
    if not getWorld then return 0, 0, 0 end
    local world = getWorld()
    local metaGrid = world and world:getMetaGrid()
    if not metaGrid then return 0, 0, 0 end
    local zones = metaGrid:getZones()
    local routedPolice, routedAirport, routedPrison = 0, 0, 0
    for index = 0, zones:size() - 1 do
        local zone = zones:get(index)
        if zone and normalized(zone:getType()) == "parkingstall" then
            local sourceName = originalName(zone)
            if sourceName == "police" then
                local region = regionForZone(metaGrid, zone)
                local destination = distributionForRegion[region]
                if not destination and vanillaGeneralFallbacks[zoneKey(zone)] then destination = "only_ki5_overhaul_police_meade" end
                if destination and created[destination] then zone:setName(destination); routedPolice = routedPolice + 1 end
            elseif sourceName == "airportservice" and regionForZone(metaGrid, zone) == "laa" and created["only_ki5_overhaul_police_airport_security"] then
                zone:setName("only_ki5_overhaul_police_airport_security"); routedAirport = routedAirport + 1
            elseif sourceName == "prison" and created["only_ki5_overhaul_police_prison_transport"] then
                zone:setName("only_ki5_overhaul_police_prison_transport"); routedPrison = routedPrison + 1
            end
        end
    end
    return routedPolice, routedAirport, routedPrison
end

local applied = false
local function applySuite()
    if applied then return end
    local zonesReady, converted, smashed, fallbacks = applyZoneRegistry()
    if not zonesReady then
        print(MOD_TAG .. " deferred: VehicleZoneDistribution is unavailable during OnLoadMapZones")
        return
    end
    local duplicates = suppressDuplicateVehicles()
    local professionsReady, professions = applyProfessionRegistry()
    local emergencyBurnt = replaceEmergencyBurntVehicles()
    local rangerBefore, rangerAfter = reduceRangerSpawnRate()
    local regionalReady, created = applyRegionalPolice()
    local routedPolice, routedAirport, routedPrison = 0, 0, 0
    if regionalReady then routedPolice, routedAirport, routedPrison = routeRegionalPolice(created) end
    local rangersRemoved = stripRangersOutsideRangerZones()
    local trafficAdjusted = balanceTrafficEmergency()
    local militaryPools = rebalanceVMZMilitaryPools()
    TrafficPolicy.apply(Catalog,SpawnAliases)
    applied = true
    print(string.format(MOD_TAG .. " ready converted=%d smashed=%d fallback=%d duplicates=%d professions=%d professionReady=%s regionalReady=%s routedPolice=%d routedAirport=%d routedPrison=%d emergencyBurnt=%d rangerSpawnRate=%s->%s rangerPoolRemoved=%d trafficAdjusted=%d %s", converted, smashed, fallbacks, duplicates, professions, tostring(professionsReady), tostring(regionalReady), routedPolice, routedAirport, routedPrison, emergencyBurnt, tostring(rangerBefore), tostring(rangerAfter), rangersRemoved, trafficAdjusted, militaryPoolLog(militaryPools)))
end

if Events and Events.OnLoadMapZones then
    Events.OnLoadMapZones.Add(applySuite)
elseif Events and Events.OnInitWorld then
    Events.OnInitWorld.Add(applySuite)
else
    print(MOD_TAG .. " cannot register: Build 42 map-zone events are unavailable")
end

local finalized = false
local function finalizeLoadedZones()
    if finalized then return end
    if not applied then applySuite() end
    if not applied then return end
    -- Other vehicle mods may append pools after OnLoadMapZones. Re-run the
    -- complete, idempotent policy after all map-zone callbacks so source
    -- variants cannot bypass rarity, service scoping, or military caps.
    local _, converted, smashed = applyZoneRegistry()
    local duplicates = suppressDuplicateVehicles()
    local professionsReady, professions = applyProfessionRegistry()
    local emergencyBurnt = replaceEmergencyBurntVehicles()
    local rangerBefore, rangerAfter = reduceRangerSpawnRate()
    local regionalReady, created = applyRegionalPolice()
    if not regionalReady then created = {} end
    local rangersRemoved = stripRangersOutsideRangerZones()
    local trafficAdjusted = balanceTrafficEmergency()
    local police, airport, prison = routeRegionalPolice(created)
    local militaryPools = rebalanceVMZMilitaryPools()
    TrafficPolicy.apply(Catalog,SpawnAliases)
    finalized = true
    print(string.format(MOD_TAG .. " loaded-zones converted=%d smashed=%d duplicates=%d professions=%d professionReady=%s regionalReady=%s police=%d airport=%d prison=%d emergencyBurnt=%d rangerSpawnRate=%s->%s rangerPoolRemoved=%d trafficAdjusted=%d %s", converted or 0, smashed or 0, duplicates, professions, tostring(professionsReady), tostring(regionalReady), police, airport, prison, emergencyBurnt, tostring(rangerBefore), tostring(rangerAfter), rangersRemoved, trafficAdjusted, militaryPoolLog(militaryPools)))
end
if Events and Events.OnLoadedMapZones then
    Events.OnLoadedMapZones.Add(finalizeLoadedZones)
end
