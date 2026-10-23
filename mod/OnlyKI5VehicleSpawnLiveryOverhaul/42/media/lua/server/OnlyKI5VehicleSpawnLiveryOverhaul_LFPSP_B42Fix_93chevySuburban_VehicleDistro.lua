-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.SUB93PDgunrack = {
    rolls = 1,
    items = {
    	"Shotgun", 100,
    }

}

VehicleDistributions.SUB93PD = {

	GloveBox = VehicleDistributions.PoliceGloveBox;
	SUB93Trunk2 = VehicleDistributions.PoliceTruckBed;
	SUB93Gunrack = VehicleDistributions.SUB93PDgunrack;
}

VehicleDistributions.SIL93PD = {

    GloveBox = VehicleDistributions.PoliceGloveBox;
	SIL93Trunk3 = VehicleDistributions.PoliceTruckBed;
    SUB93RollbarToolbox = VehicleDistributions.PoliceTruckBed;
    SUB93Roofrack = VehicleDistributions.PoliceGloveBox;
    SUB93Gunrack = VehicleDistributions.SUB93PDgunrack;
}


distributionTable["93chevySuburbanpdMuldraugh"] = { Normal = VehicleDistributions.SUB93PD; }
distributionTable["93chevySuburbanpdWestPoint"] = { Normal = VehicleDistributions.SUB93PD; }
distributionTable["93chevySuburbanpdMeade"] = { Normal = VehicleDistributions.SUB93PD; }
distributionTable["93chevySuburbanpdBulletin"] = { Normal = VehicleDistributions.SUB93PD; }
distributionTable["93chevySuburbanpdLouisville"] = { Normal = VehicleDistributions.SUB93PD; }

distributionTable["93chevySilveradoCClongLouisville"] = { Normal = VehicleDistributions.SIL93PD; }
distributionTable["93chevySilveradoCClongMuldraugh"] = { Normal = VehicleDistributions.SIL93PD; }
distributionTable["93chevySilveradoCClongSecurity"] = { Normal = VehicleDistributions.SIL93PD; }
