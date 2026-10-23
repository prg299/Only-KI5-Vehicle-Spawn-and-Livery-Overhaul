-- Integrated from Vehicle Military Zones (VMZNEW).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3436499337
-- Third-party contribution; excluded from the project MIT license.
local VZUtils = require("OnlyKI5VehicleSpawnLiveryOverhaul_MilitaryZones")
local vanillaMilitaryZones = require("OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_Vanilla_Map")
local modsMilitaryZones = require("OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_Map_Mods")

Events.OnLoadMapZones.Add(function()
	VZUtils.register(vanillaMilitaryZones, true)
end)

Events.OnLoadMapZones.Add(function()
	VZUtils.register(modsMilitaryZones, false)
end)

print(modsMilitaryZones)