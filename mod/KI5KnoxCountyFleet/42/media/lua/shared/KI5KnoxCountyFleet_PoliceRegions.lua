-- Canonical regional KI5 police livery routing shared by map zones,
-- ProfessionVehicles stories, and the final pre-creation spawn hook.
local PoliceRegions = {}

PoliceRegions.liveries = {
    louisville = { "Base.92fordCVPILouisville", "Base.92fordCVPI2Louisville", "Base.91fordLTDpdLouisville", "Base.93chevySuburbanpdLouisville", "Base.93chevySilveradoCClongLouisville", "Base.93fordF350pdLouisville", "Base.85chevyImpalaSedanCLPD", "Base.93chevySuburbanPoliceCLPD", "Base.92amgeneralM998SWAT", "Base.87fordF700Lswat", "Base.87fordF700swat", "Base.85chevyStepVanSWAT", "Base.90fordF350SWAT" },
    louisvilleCounty = { "Base.91fordLTDpdLCPD", "Base.85chevyImpalaSedanLCPD", "Base.93chevySuburbanPoliceLCPD" },
    muldraugh = { "Base.92fordCVPIMuldraugh", "Base.92fordCVPI2Muldraugh", "Base.91fordLTDpdMuldraugh", "Base.93chevySuburbanpdMuldraugh", "Base.93chevySilveradoCClongMuldraugh", "Base.89fordBroncoMuldraugh", "Base.93fordF350pdMuldraugh", "Base.85chevyImpalaSedanMPD", "Base.93chevySuburbanPoliceMPD", "Base.92fordCVPIMeade", "Base.92fordCVPI2Meade", "Base.91fordLTDpdMeade", "Base.93chevySuburbanpdMeade", "Base.89fordBroncoMeade", "Base.93fordF350pdMeade" },
    meade = { "Base.92fordCVPIMeade", "Base.92fordCVPI2Meade", "Base.91fordLTDpdMeade", "Base.93chevySuburbanpdMeade", "Base.89fordBroncoMeade", "Base.93fordF350pdMeade", "Base.85chevyImpalaSedanMCS", "Base.93chevySuburbanPoliceMCS", "Base.93chevySilveradoPoliceMCS" },
    westPoint = { "Base.92fordCVPIWestPoint", "Base.92fordCVPI2WestPoint", "Base.91fordLTDpdWestPoint", "Base.93chevySuburbanpdWestPoint", "Base.89fordBroncoWestPoint", "Base.93fordF350pdWestPoint", "Base.85chevyImpalaSedanWPPD", "Base.93chevySuburbanPoliceWPPD" },
    bulletin = { "Base.92fordCVPIBulletin", "Base.92fordCVPI2Bulletin", "Base.91fordLTDpdBulletin", "Base.93chevySuburbanpdBulletin", "Base.89fordBroncoBulletin", "Base.93fordF350pdBulletin", "Base.85chevyImpalaSedanBCS", "Base.93chevySuburbanPoliceBCS", "Base.93chevySilveradoPoliceBCS" },
    airportSecurity = { "Base.93chevySilveradoCClongSecurity", "Base.93chevySilveradoAirport", "Base.93chevySuburbanAirportSec" },
    prisonTransport = { "Base.87fordB700Ksprison", "Base.93chevySuburbanPrison" },
}

-- Tactical bodies are not routine patrol vehicles. In particular the F350
-- SWAT skin says Knox County Sheriff and the base Step Van/F700 can choose
-- multi-jurisdiction skins at random. Only the fixed black Louisville SWAT
-- livery is eligible for a very rare city police-zone spawn.
PoliceRegions.tacticalScripts = {
    ["Base.85chevyStepVanSWAT"] = true,
    ["Base.90fordF350SWAT"] = true,
    ["Base.87fordF700swat"] = true,
    ["Base.92amgeneralM998SWAT"] = true,
    ["Base.87fordF700Lswat"] = true,
}
PoliceRegions.allowedTactical = {
    louisville = { "Base.87fordF700Lswat" },
}
PoliceRegions.generalPatrol = { "Base.91fordLTDksp", "Base.92fordCVPI2ksp" }
PoliceRegions.patrolLiveries = {}
for key, scripts in pairs(PoliceRegions.liveries) do
    local patrol = {}
    for _, scriptName in ipairs(scripts) do
        if not PoliceRegions.tacticalScripts[scriptName] then
            patrol[#patrol + 1] = scriptName
        end
    end
    PoliceRegions.patrolLiveries[key] = patrol
end

PoliceRegions.distributionForRegion = {
    jefferson = "knox_fleet_police_louisville_county",
    louisville = "knox_fleet_police_louisville",
    muldraugh = "knox_fleet_police_muldraugh",
    riverside = "knox_fleet_police_meade",
    rosewood = "knox_fleet_police_meade",
    westpoint = "knox_fleet_police_westpoint",
    valleystation = "knox_fleet_police_bulletin",
}

PoliceRegions.liveryKeyForRegion = {
    jefferson = "louisvilleCounty",
    louisville = "louisville",
    muldraugh = "muldraugh",
    riverside = "meade",
    rosewood = "meade",
    westpoint = "westPoint",
    valleystation = "bulletin",
    laa = "airportSecurity",
}

PoliceRegions.professionRegions = {
    Jefferson = "louisvilleCounty",
    Louisville = "louisville",
    Muldraugh = "muldraugh",
    Riverside = "meade",
    Rosewood = "meade",
    WestPoint = "westPoint",
    ValleyStation = "bulletin",
    LAA = "airportSecurity",
}

PoliceRegions.regionPriority = {
    louisville = 1, jefferson = 2, muldraugh = 3, westpoint = 4,
    riverside = 5, rosewood = 6, valleystation = 7, laa = 8,
}

local liveryMembership = {}
local prisonTransportMembership = {}
for key, scripts in pairs(PoliceRegions.liveries) do
    for _, scriptName in ipairs(scripts) do
        liveryMembership[scriptName] = liveryMembership[scriptName] or {}
        liveryMembership[scriptName][key] = true
        if key == "prisonTransport" then prisonTransportMembership[scriptName] = true end
    end
end

function PoliceRegions.normalizeRegion(region)
    if type(region) ~= "string" then return nil end
    return string.lower(region)
end

function PoliceRegions.liveryKeyFor(region)
    local normalized = PoliceRegions.normalizeRegion(region)
    return normalized and PoliceRegions.liveryKeyForRegion[normalized] or nil
end

function PoliceRegions.isAssignedLivery(scriptName, liveryKey)
    return liveryMembership[scriptName] ~= nil and liveryMembership[scriptName][liveryKey] == true
end

function PoliceRegions.isLivery(scriptName)
    return liveryMembership[scriptName] ~= nil
end

function PoliceRegions.isPrisonTransport(scriptName)
    return prisonTransportMembership[scriptName] == true
end

function PoliceRegions.isTactical(scriptName)
    return PoliceRegions.tacticalScripts[scriptName] == true
end

function PoliceRegions.isAllowedTactical(scriptName, liveryKey)
    for _, allowed in ipairs(PoliceRegions.allowedTactical[liveryKey] or {}) do
        if allowed == scriptName then return true end
    end
    return false
end

return PoliceRegions
