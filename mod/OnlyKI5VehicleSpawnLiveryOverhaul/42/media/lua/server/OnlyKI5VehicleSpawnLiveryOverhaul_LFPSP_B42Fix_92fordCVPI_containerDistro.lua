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

VehicleDistributions.CVPI92 = {

	GloveBox = VehicleDistributions.PoliceGloveBox;
	CVPI92Trunk = VehicleDistributions.PoliceTruckBed;
	CVPI92Gunrack = VehicleDistributions.CVPIgunrack;
}

distributionTable["92fordCVPI2WestPoint"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPI2Muldraugh"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPI2Bulletin"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPI2Meade"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPI2Louisville"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPIWestPoint"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPIMuldraugh"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPIBulletin"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPIMeade"] = { Normal = VehicleDistributions.CVPI92; }
distributionTable["92fordCVPILouisville"] = { Normal = VehicleDistributions.CVPI92; }
