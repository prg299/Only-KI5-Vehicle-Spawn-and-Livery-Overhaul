-- Integrated from More Car Variants (KI5) (MCV93fordFseries).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
if not require("OnlyKI5VehicleSpawnLiveryOverhaul_Fleet").active("93fordF350") then return end
if not VehicleZoneDistribution then return end

VehicleZoneDistribution.mccoy.vehicles["Base.93fordF350mccoy"] = {index = -1, spawnChance = 25};

VehicleZoneDistribution.fossoil.vehicles["Base.93fordF350fossoil"] = {index = -1, spawnChance = 20};

local function MCVplusVVR()
	if getActivatedMods():contains("\\VVR") == false or SandboxVars.VVR.Professional == false then
		VehicleZoneDistribution.business.vehicles["Base.93fordF250jplandscaping"] = {index = -1, spawnChance = 4};
	end
end

VehicleZoneDistribution.airportservice.vehicles["Base.93fordF350as"] = {index = -1, spawnChance = 15};
VehicleZoneDistribution.airportservice.vehicles["Base.93fordF350airport"] = {index = -1, spawnChance = 20};

Events.OnLoadMapZones.Add(MCVplusVVR)