-- Integrated from More Car Variants (KI5) (MCV93fordFseries).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.F3502McCoy = {

	GloveBox = VehicleDistributions.McCoyGloveBox;
	F3502Trunk = VehicleDistributions.McCoyTruckBed;
	F3502SideStorageLT = VehicleDistributions.McCoyGloveBox;
    F3502SideStorageLF = VehicleDistributions.McCoyGloveBox;
    F3502SideStorageLM = VehicleDistributions.McCoyGloveBox;
    F3502SideStorageLR = VehicleDistributions.McCoyGloveBox;
    F3502SideStorageRT = VehicleDistributions.McCoyGloveBox;
    F3502SideStorageRF = VehicleDistributions.McCoyGloveBox;
    F3502SideStorageRM = VehicleDistributions.McCoyGloveBox;
    F3502SideStorageRR = VehicleDistributions.McCoyGloveBox;
}

VehicleDistributions.F3502Fossoil = {

	GloveBox = VehicleDistributions.FossoilGloveBox;
	F3502Trunk = VehicleDistributions.FossoilTruckBed;
    F3502Roofrack = VehicleDistributions.FossoilTruckBed;
	F3502HeadacheRack = VehicleDistributions.FossoilTruckBed;
}

VehicleDistributions.F3502AS = {

	GloveBox = VehicleDistributions.PoliceGloveBox;
	F3502Trunk = VehicleDistributions.PickUpTruckLights_AirportTruckBed;
    F3502Roofrack = VehicleDistributions.PickUpTruckLights_AirportTruckBed;
	F3502HeadacheRack = VehicleDistributions.PoliceGloveBox;
}

VehicleDistributions.F3502Airport = {

	GloveBox = VehicleDistributions.PickUpTruckLights_AirportGloveBox;
	F3502Trunk = VehicleDistributions.PickUpTruckLights_AirportTruckBed;
    F3502Roofrack = VehicleDistributions.PickUpTruckLights_AirportTruckBed;
	F3502HeadacheRack = VehicleDistributions.PickUpTruckLights_AirportTruckBed;
}

VehicleDistributions.F2502Gardener = {

	GloveBox = VehicleDistributions.GardenerGloveBox;
	F3502Trunk = VehicleDistributions.GardenerTruckBed;
    F3502Roofrack = VehicleDistributions.GardenerTruckBed;
	F3502HeadacheRack = VehicleDistributions.GardenerTruckBed;
}

distributionTable["93fordF350mccoy"] = { Normal = VehicleDistributions.F3502McCoy; }
distributionTable["93fordF350fossoil"] = { Normal = VehicleDistributions.F3502Fossoil; }
distributionTable["93fordF250jplandscaping"] = { Normal = VehicleDistributions.F2502Gardener; }
distributionTable["93fordF350as"] = { Normal = VehicleDistributions.F3502AS; }
distributionTable["93fordF350airport"] = { Normal = VehicleDistributions.F3502Airport; }