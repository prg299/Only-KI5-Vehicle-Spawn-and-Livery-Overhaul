-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.CVPIgunrack = {
    rolls = 1,
    items = {
    	"Shotgun", 100,
    }
}

VehicleDistributions.LTD91pd = {

	GloveBox = VehicleDistributions.PoliceGloveBox;
	LTD91Trunk = VehicleDistributions.PoliceTruckBed;
	LTD91Gunrack = VehicleDistributions.CVPIgunrack;
}

distributionTable["91fordLTDpdMeade"] = { Normal = VehicleDistributions.LTD91pd; }
distributionTable["91fordLTDpdLouisville"] = { Normal = VehicleDistributions.LTD91pd; }
distributionTable["91fordLTDpdBulletin"] = { Normal = VehicleDistributions.LTD91pd; }
distributionTable["91fordLTDpdWestPoint"] = { Normal = VehicleDistributions.LTD91pd; }
distributionTable["91fordLTDpdLCPD"] = { Normal = VehicleDistributions.LTD91pd; }
distributionTable["91fordLTDpdMuldraugh"] = { Normal = VehicleDistributions.LTD91pd; }

