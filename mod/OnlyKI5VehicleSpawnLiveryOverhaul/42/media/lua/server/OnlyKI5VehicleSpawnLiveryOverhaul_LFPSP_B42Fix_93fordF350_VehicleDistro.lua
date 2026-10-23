-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.F3502PDgunrack = {
    rolls = 1,
    items = {
    	"Shotgun", 100,
    }
}

VehicleDistributions.F3502 = {

	GloveBox = VehicleDistributions.GloveBox;
	F3502Trunk = VehicleDistributions.TrunkHeavy;
    F3502Roofrack = VehicleDistributions.TrunkHeavy;
	F3502HeadacheRack = VehicleDistributions.TrunkHeavy;
}

VehicleDistributions.F3502PD = {

	GloveBox = VehicleDistributions.PoliceGloveBox;
	F3502Trunk = VehicleDistributions.PoliceTruckBed;
	F3502Gunrack = VehicleDistributions.F3502PDgunrack;
    F3502Roofrack = VehicleDistributions.TrunkHeavy;
	F3502HeadacheRack = VehicleDistributions.PoliceGloveBox;
}

VehicleDistributions.F3502FD = {

	GloveBox = VehicleDistributions.FireGloveBox;
	F3502Trunk = VehicleDistributions.FireTruckBed;
    F3502Roofrack = VehicleDistributions.TrunkHeavy;
	F3502HeadacheRack = VehicleDistributions.FireGloveBox;
}

VehicleDistributions.F3502U = {

	GloveBox = VehicleDistributions.GloveBox;
	F3502Trunk = VehicleDistributions.TruckBed;
	F3502SideStorageLT = VehicleDistributions.FireGloveBox;
    F3502SideStorageLF = VehicleDistributions.GloveBox;
    F3502SideStorageLM = VehicleDistributions.GloveBox;
    F3502SideStorageLR = VehicleDistributions.FireGloveBox;
    F3502SideStorageRT = VehicleDistributions.GloveBox;
    F3502SideStorageRF = VehicleDistributions.GloveBox;
    F3502SideStorageRM = VehicleDistributions.FireGloveBox;
    F3502SideStorageRR = VehicleDistributions.GloveBox;
}

VehicleDistributions.F3502FDU = {

	GloveBox = VehicleDistributions.FireGloveBox;
	F3502Trunk = VehicleDistributions.FireTruckBed;
	F3502SideStorageLT = VehicleDistributions.FireGloveBox;
    F3502SideStorageLF = VehicleDistributions.FireGloveBox;
    F3502SideStorageLM = VehicleDistributions.FireGloveBox;
    F3502SideStorageLR = VehicleDistributions.FireGloveBox;
    F3502SideStorageRT = VehicleDistributions.FireGloveBox;
    F3502SideStorageRF = VehicleDistributions.FireGloveBox;
    F3502SideStorageRM = VehicleDistributions.FireGloveBox;
    F3502SideStorageRR = VehicleDistributions.FireGloveBox;
}

distributionTable["93fordF350pdWestPoint"] = { Normal = VehicleDistributions.F3502PD; }
distributionTable["93fordF350pdBulletin"] = { Normal = VehicleDistributions.F3502PD; }
distributionTable["93fordF350pdMeade"] = { Normal = VehicleDistributions.F3502PD; }
distributionTable["93fordF350pdMuldraugh"] = { Normal = VehicleDistributions.F3502PD; }
distributionTable["93fordF350pdLouisville"] = { Normal = VehicleDistributions.F3502PD; }




