-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.M998PD = {

	GloveBox = VehicleDistributions.PoliceSWATGloveBox;
	M998Trunk = VehicleDistributions.PoliceSWATTruckBed;
}

VehicleDistributions.M101A3 = {

	M101A3Trunk = VehicleDistributions.TrunkHeavy;
}

distributionTable["92amgeneralM998SWAT"] = { Normal = VehicleDistributions.M998PD; }
distributionTable["92amgeneralM998Meade"] = { Normal = VehicleDistributions.M998PD; }
