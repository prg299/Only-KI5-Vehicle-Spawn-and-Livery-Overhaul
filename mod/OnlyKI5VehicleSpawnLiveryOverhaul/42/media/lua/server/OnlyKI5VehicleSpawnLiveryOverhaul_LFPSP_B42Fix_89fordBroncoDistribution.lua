-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.BR89PD = {

	GloveBox = VehicleDistributions.PoliceGloveBox;
	BR89Trunk = VehicleDistributions.PoliceTruckBed;
}

distributionTable["89fordBroncoMeade"] = { Normal = VehicleDistributions.BR89PD; }
distributionTable["89fordBroncoBulletin"] = { Normal = VehicleDistributions.BR89PD; }
distributionTable["89fordBroncoWestPoint"] = { Normal = VehicleDistributions.BR89PD; }
distributionTable["89fordBroncoMuldraugh"] = { Normal = VehicleDistributions.BR89PD; }
