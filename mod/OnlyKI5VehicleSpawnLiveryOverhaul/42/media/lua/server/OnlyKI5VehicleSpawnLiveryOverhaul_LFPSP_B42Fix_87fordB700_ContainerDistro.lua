-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.F700gunrack = {
    rolls = 1,
    items = {
    	"Shotgun", 130,
    }
}

VehicleDistributions.F700guncab = {
    rolls = 2,
    items = {
    	"Shotgun", 15,
        "Pistol", 20,
        "AssaultRifle", 10,
        "ShotgunShellsBox", 30,
        "Bullets9mmBox", 40,
        "556Box", 20,
    }
}

VehicleDistributions.F700monehz = {
    rolls =100,
    items = {
    	"Money", 100,
        "CreditCard", 90,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
        "Money", 80,
    }
}

VehicleDistributions.B700 = {
	
	GloveBox = VehicleDistributions.GloveBox;

    B700Trunk = VehicleDistributions.TrunkHeavy;
	B700TrunkLeft = VehicleDistributions.GloveBox;
    B700TrunkRight = VehicleDistributions.GloveBox;
    B700Roofrack = VehicleDistributions.TrunkHeavy;
}

VehicleDistributions.F700SWAT = {
	
	GloveBox = VehicleDistributions.PoliceSWATGloveBox;

	F700TrunkSW = VehicleDistributions.PoliceSWATTruckBed;
    F700TrunkSWGunrack = VehicleDistributions.F700gunrack;
    F700TrunkSWGuncabinet = VehicleDistributions.F700guncab;
}

VehicleDistributions.F700BANK = {
	
	GloveBox = VehicleDistributions.PoliceGloveBox;

	F700TrunkBN = VehicleDistributions.F700monehz;
}

VehicleDistributions.F700BOX = {
	
	GloveBox = VehicleDistributions.GloveBox;

	F700TrunkBX = VehicleDistributions.TrunkHeavy;
    F700TrunkLeftBX = VehicleDistributions.GloveBox;
}


distributionTable["87fordB700Ksprison"] = { Normal = VehicleDistributions.B700; }
distributionTable["87fordF700Lswat"] = { Normal = VehicleDistributions.F700SWAT; }
