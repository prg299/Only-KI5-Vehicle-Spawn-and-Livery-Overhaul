-- Integrated from More Car Variants (KI5) (MCV76chevyKseries).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.CH76Mccoy = {

	GloveBox = VehicleDistributions.McCoyGloveBox;
	CH76Trunk = VehicleDistributions.McCoyTruckBed;
	CH76Roofrack = VehicleDistributions.McCoyTruckBed;
}

VehicleDistributions.CH76Fossoil = {

	GloveBox = VehicleDistributions.FossoilGloveBox;
	CH76Trunk = VehicleDistributions.FossoilTruckBed;
	CH76Roofrack = VehicleDistributions.FossoilTruckBed;
}

VehicleDistributions.CH76Construction = {

	GloveBox = VehicleDistributions.ConstructionWorkerGloveBox;
	CH76Trunk = VehicleDistributions.ConstructionWorkerTruckBed;
	CH76Roofrack = VehicleDistributions.ConstructionWorkerTruckBed;
}

VehicleDistributions.CH76Metal = {

	GloveBox = VehicleDistributions.MetalWelderGloveBox;
	CH76Trunk = VehicleDistributions.MetalWelderTruckBed;
	CH76Roofrack = VehicleDistributions.MetalWelderTruckBed;
}

VehicleDistributions.CH76Carpenter = {

	GloveBox = VehicleDistributions.CarpenterGloveBox;
	CH76Trunk = VehicleDistributions.CarpenterTruckBed;
	CH76Roofrack = VehicleDistributions.CarpenterTruckBed;
}

VehicleDistributions.CH76Gardener = {

	GloveBox = VehicleDistributions.GardenerGloveBox;
	CH76Trunk = VehicleDistributions.GardenerTruckBed;
	CH76Roofrack = VehicleDistributions.GardenerTruckBed;
}

VehicleDistributions.CH76UMcCoy = {

	GloveBox = VehicleDistributions.McCoyGloveBox;
	CH76Trunk = VehicleDistributions.McCoyTruckBed;
	CH76SideStorageLT = VehicleDistributions.McCoyGloveBox;
    CH76SideStorageLF = VehicleDistributions.McCoyGloveBox;
    CH76SideStorageLM = VehicleDistributions.McCoyGloveBox;
    CH76SideStorageLR = VehicleDistributions.McCoyGloveBox;
    CH76SideStorageRT = VehicleDistributions.McCoyGloveBox;
    CH76SideStorageRF = VehicleDistributions.McCoyGloveBox;
    CH76SideStorageRM = VehicleDistributions.McCoyGloveBox;
    CH76SideStorageRR = VehicleDistributions.McCoyGloveBox;
}

VehicleDistributions.CH76UFossoil = {

	GloveBox = VehicleDistributions.FossoilGloveBox;
	CH76Trunk = VehicleDistributions.FossoilTruckBed;
	CH76SideStorageLT = VehicleDistributions.FossoilGloveBox;
    CH76SideStorageLF = VehicleDistributions.FossoilGloveBox;
    CH76SideStorageLM = VehicleDistributions.FossoilGloveBox;
    CH76SideStorageLR = VehicleDistributions.FossoilGloveBox;
    CH76SideStorageRT = VehicleDistributions.FossoilGloveBox;
    CH76SideStorageRF = VehicleDistributions.FossoilGloveBox;
    CH76SideStorageRM = VehicleDistributions.FossoilGloveBox;
    CH76SideStorageRR = VehicleDistributions.FossoilGloveBox;
}

VehicleDistributions.CH76UConstructionWorker = {

	GloveBox = VehicleDistributions.ConstructionWorkerGloveBox;
	CH76Trunk = VehicleDistributions.ConstructionWorkerTruckBed;
	CH76SideStorageLT = VehicleDistributions.ConstructionWorkerGloveBox;
    CH76SideStorageLF = VehicleDistributions.ConstructionWorkerGloveBox;
    CH76SideStorageLM = VehicleDistributions.ConstructionWorkerGloveBox;
    CH76SideStorageLR = VehicleDistributions.ConstructionWorkerGloveBox;
    CH76SideStorageRT = VehicleDistributions.ConstructionWorkerGloveBox;
    CH76SideStorageRF = VehicleDistributions.ConstructionWorkerGloveBox;
    CH76SideStorageRM = VehicleDistributions.ConstructionWorkerGloveBox;
    CH76SideStorageRR = VehicleDistributions.ConstructionWorkerGloveBox;
}

distributionTable["76chevyK20mccoy"] = { Normal = VehicleDistributions.CH76Mccoy; }
distributionTable["76chevyK10fossoil"] = { Normal = VehicleDistributions.CH76Fossoil; }
distributionTable["76chevyK20brickingit"] = { Normal = VehicleDistributions.CH76Construction; }
distributionTable["76chevyK20kimble"] = { Normal = VehicleDistributions.CH76Construction; }
distributionTable["76chevyK20mrc"] = { Normal = VehicleDistributions.CH76Construction; }
distributionTable["76chevyK20helton"] = { Normal = VehicleDistributions.CH76Metal; }
distributionTable["76chevyK10camille"] = { Normal = VehicleDistributions.CH76Metal; }
distributionTable["76chevyK10kentuckylumber"] = { Normal = VehicleDistributions.CH76Carpenter; }
distributionTable["76chevyK10yingswood"] = { Normal = VehicleDistributions.CH76Carpenter; }
distributionTable["76chevyK10calloway"] = { Normal = VehicleDistributions.CH76UMcCoy; }

distributionTable["76chevyK20utilityDpw"] = { Normal = VehicleDistributions.CH76UConstructionWorker; }
distributionTable["76chevyK20utilityFossoil"] = { Normal = VehicleDistributions.CH76UFossoil; }
distributionTable["76chevyK20utilityMcCoy"] = { Normal = VehicleDistributions.CH76Gardener; }

distributionTable["76chevyK30CCutilityDpw"] = { Normal = VehicleDistributions.CH76UConstructionWorker; }
distributionTable["76chevyK30CCutilityFossoil"] = { Normal = VehicleDistributions.CH76UFossoil; }
distributionTable["76chevyK30CCutilityMcCoy"] = { Normal = VehicleDistributions.CH76UMcCoy; }