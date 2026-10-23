-- Integrated from More Car Variants (KI5) (MCV76chevyKseries).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
if not VehicleZoneDistribution then return end

VehicleZoneDistribution.mccoy.vehicles["Base.76chevyK20mccoy"] = {index = -1, spawnChance = 25};
VehicleZoneDistribution.mccoy.vehicles["Base.76chevyK20utilityMcCoy"] = {index = -1, spawnChance = 15};
VehicleZoneDistribution.mccoy.vehicles["Base.76chevyK30CCutilityMcCoy"] = {index = -1, spawnChance = 10};

VehicleZoneDistribution.fossoil.vehicles["Base.76chevyK10fossoil"] = {index = -1, spawnChance = 25};
VehicleZoneDistribution.fossoil.vehicles["Base.76chevyK20utilityFossoil"] = {index = -1, spawnChance = 15};
VehicleZoneDistribution.fossoil.vehicles["Base.76chevyK30CCutilityFossoil"] = {index = -1, spawnChance = 10};

if not getActivatedMods():contains("\\VVR") then
	VehicleZoneDistribution.trafficjams.vehicles["Base.76chevyK20utilityDpw"] = {index = -1, spawnChance = 1};
	VehicleZoneDistribution.trafficjams.vehicles["Base.76chevyK30CCutilityDpw"] = {index = -1, spawnChance = 1};
end

local function MCVplusVVR()
	if getActivatedMods():contains("\\VVR") == false or SandboxVars.VVR.Professional == false then
		VehicleZoneDistribution.business.vehicles["Base.76chevyK20brickingIt"] = {index = -1, spawnChance = 2};
		VehicleZoneDistribution.business.vehicles["Base.76chevyK20kimble"] = {index = -1, spawnChance = 2};
		VehicleZoneDistribution.business.vehicles["Base.76chevyK20helton"] = {index = -1, spawnChance = 4};
		VehicleZoneDistribution.business.vehicles["Base.76chevyK10kentuckylumber"] = {index = -1, spawnChance = 4};
		VehicleZoneDistribution.business.vehicles["Base.76chevyK20mrc"] = {index = -1, spawnChance = 2};
		VehicleZoneDistribution.business.vehicles["Base.76chevyK10yingswood"] = {index = -1, spawnChance = 4};
		VehicleZoneDistribution.business.vehicles["Base.76chevyK10camille"] = {index = -1, spawnChance = 4};
		VehicleZoneDistribution.business.vehicles["Base.76chevyK10calloway"] = {index = -1, spawnChance = 4};
	end
end

Events.OnLoadMapZones.Add(MCVplusVVR)