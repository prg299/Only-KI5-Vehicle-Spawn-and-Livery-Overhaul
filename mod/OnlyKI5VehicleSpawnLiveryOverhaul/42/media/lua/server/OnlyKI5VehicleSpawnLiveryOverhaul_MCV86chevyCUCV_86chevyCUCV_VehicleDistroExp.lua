-- Integrated from More Car Variants (KI5) (MCV86chevyCUCV).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
local distributionTable = VehicleDistributions[1]

VehicleDistributions.CUCV86Ambulance = {

	GloveBox = VehicleDistributions.AmbulanceGloveBox;
    M1010Trunk = VehicleDistributions.AmbulanceTruckBed;

}

distributionTable["86chevyM1010ambulance"] = { Normal = VehicleDistributions.CUCV86Ambulance; }
