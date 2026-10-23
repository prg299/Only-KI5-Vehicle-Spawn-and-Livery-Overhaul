-- Integrated from More Car Variants (KI5) (MCV67commando).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.V100Ranger = {

	GloveBox = VehicleDistributions.RangerGloveBox;
	V100Trunk = VehicleDistributions.RangerTruckBed;
	V100Toolbox = VehicleDistributions.RangerGloveBox;
}

distributionTable["67commandoRanger"] = { Normal = VehicleDistributions.V100Ranger; }

