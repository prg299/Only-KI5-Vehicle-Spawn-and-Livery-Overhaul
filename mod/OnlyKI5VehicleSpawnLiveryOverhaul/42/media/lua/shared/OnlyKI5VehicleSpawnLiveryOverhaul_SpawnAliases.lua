-- One exact alias authority for pool, profession, direct-Lua and native spawns.
-- No prefix matching: third-party KI5 scripts and existing vehicles are untouched.
local Catalog = require "OnlyKI5VehicleSpawnLiveryOverhaul_Catalog"
local Aliases = {}
Aliases.targets = {
    ["Base.VanRadioJJ"] = "Base.86fordE150LBMWradio",
    ["Base.Trailer"] = "Base.TrailerKI5utilitySmall",
    ["Base.TrailerCover"] = "Base.TrailerKI5cargoSmall",
    ["Base.TrailerAdvert"] = "Base.TrailerKI5cargoMedium",
    ["Base.Trailer_Livestock"] = "Base.TrailerKI5livestock",
    ["Base.Trailer_Horsebox"] = "Base.TrailerKI5livestock",
}
Aliases.groups = {}
for source, target in pairs(Aliases.targets) do
    local group = "suiteAlias_" .. string.sub(source, 6)
    Catalog.groups[group] = { target }
    Aliases.groups[source] = group
end

-- Generated/native B42 profession variants missing from the older registry.
local supplemental = {
    policeGeneric = { "CarLightsBulletinSheriff", "CarLightsKST", "CarLightsLouisvilleCounty", "CarLightsMuldraughPolice", "ModernCarLightsCityLouisvillePD", "ModernCarLightsMeadeSheriff", "ModernCarLightsWestPoint", "PickUpVanLightsLouisvilleCounty", "PickUpVanLightsStatePolice", "StepVan_LouisvilleSWAT" },
    modern = { "ModernCar_Martin" },
    sports = { "RaceCar12", "RaceCar34", "RaceCar58", "SportsCar_ez" },
    van = { "VanSeats_Creature", "VanSeats_LadyDelighter", "VanSeats_Space", "VanSeats_Trippy", "VanSeats_Valkyrie" },
    commercial = {
        "PickUpTruckJPLandscaping", "PickUpVanBrickingIt", "PickUpVanCallowayLandscaping", "PickUpVanHeltonMetalWorking", "PickUpVanKimbleKonstruction", "PickUpVanLightsKentuckyLumber", "PickUpVanMarchRidgeConstruction", "PickUpVanMetalworker", "PickUpVanWeldingbyCamille", "PickUpVanYingsWood",
        "StepVan_CompleteRepairShop", "StepVan_Jorgensen", "StepVan_LouisvilleMotorShop", "StepVan_RandisPlants",
        "VanBeckmans", "VanBrewsterHarbin", "VanCoastToCoast", "VanGardenGods", "VanJohnMcCoy", "VanJonesFabrication", "VanKerrHomes", "VanKorshunovs", "VanLouisvilleLandscaping", "VanMetalheads", "VanMicheles", "VanMooreMechanics", "VanPennSHam", "VanPlattAuto", "VanRiversideFabrication", "VanRosewoodworking", "VanSchwabSheetMetal", "VanTreyBaines", "VanUtility", "VanWPCarpentry",
    },
}
for group, names in pairs(supplemental) do
    for _, name in ipairs(names) do Aliases.groups["Base." .. name] = group end
end

function Aliases.resolve(scriptName)
    if type(scriptName) ~= "string" then return nil end
    if not string.find(scriptName, ".", 1, true) then scriptName = "Base." .. scriptName end
    if Aliases.targets[scriptName] then return Aliases.targets[scriptName] end
    local group = Aliases.groups[scriptName]
    if not group then return nil end
    local candidates = Catalog.weightedCopy(group, 1000, "direct-spawn")
    if #candidates == 0 then return nil end
    return candidates[ZombRand(#candidates) + 1]
end

function Aliases.routeNewVehicle(vehicle)
    if not vehicle or vehicle:isCreated() then return false end
    local script = vehicle:getScript()
    local target = script and Aliases.resolve(script:getFullName())
    if not target then return false end
    vehicle:setScriptName(target)
    vehicle:scriptReloaded(true)
    -- A vanilla index (e.g. advertising skin 8) is not valid for a KI5 body.
    vehicle:setSkinIndex(0)
    return true
end

return Aliases
