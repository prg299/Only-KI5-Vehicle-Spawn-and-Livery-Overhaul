-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
--
ISCarMechanicsOverlay.PartList["CVPI92BumperFront"] = {img="bullbar", vehicles = {}};
ISCarMechanicsOverlay.PartList["CVPI92WindshieldArmor"] = {img="windshield_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["CVPI92WindowFrontLeftArmor"] = {img="door_front_left_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["CVPI92WindowFrontRightArmor"] = {img="door_front_right_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["CVPI92WindowRearLeftArmor"] = {img="door_rear_left_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["CVPI92WindowRearRightArmor"] = {img="door_rear_right_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["CVPI92WindshieldRearArmor"] = {img="windshield_rear_armor", vehicles = {}};

--##########92fordCVPIPolice##########
--
ISCarMechanicsOverlay.CarList["Base.92fordCVPIMuldraugh"] = ISCarMechanicsOverlay.CarList["Base.92fordCVPI"];
ISCarMechanicsOverlay.CarList["Base.92fordCVPIWestPoint"] = ISCarMechanicsOverlay.CarList["Base.92fordCVPI"];
ISCarMechanicsOverlay.CarList["Base.92fordCVPIMeade"] = ISCarMechanicsOverlay.CarList["Base.92fordCVPI"];
ISCarMechanicsOverlay.CarList["Base.92fordCVPIBulletin"] = ISCarMechanicsOverlay.CarList["Base.92fordCVPI"];
ISCarMechanicsOverlay.CarList["Base.92fordCVPILouisville"] = ISCarMechanicsOverlay.CarList["Base.92fordCVPI"];

--

ISCarMechanicsOverlay.PartList["Battery"].vehicles["92fordCVPI_"] = {img="battery", x=228,y=103,x2=270,y2=134};
--
ISCarMechanicsOverlay.PartList["SuspensionFrontLeft"].vehicles["92fordCVPI_"] = {img="suspension_front_left", x=13,y=143,x2=55,y2=181};
ISCarMechanicsOverlay.PartList["SuspensionFrontRight"].vehicles["92fordCVPI_"] = {img="suspension_front_right", x=228,y=143,x2=270,y2=181};
ISCarMechanicsOverlay.PartList["SuspensionRearLeft"].vehicles["92fordCVPI_"] = {x=13,y=357,x2=55,y2=396};
ISCarMechanicsOverlay.PartList["SuspensionRearRight"].vehicles["92fordCVPI_"] = {x=228,y=357,x2=270,y2=396};
--
ISCarMechanicsOverlay.PartList["BrakeFrontLeft"].vehicles["92fordCVPI_"] = {img="brake_front_left", x=14,y=181,x2=55,y2=218};
ISCarMechanicsOverlay.PartList["BrakeFrontRight"].vehicles["92fordCVPI_"] = {img="brake_front_right", x=228,y=181,x2=270,y2=218};
ISCarMechanicsOverlay.PartList["BrakeRearLeft"].vehicles["92fordCVPI_"] = {x=13,y=396,x2=55,y2=431};
ISCarMechanicsOverlay.PartList["BrakeRearRight"].vehicles["92fordCVPI_"] = {x=228,y=396,x2=270,y2=431};
--
ISCarMechanicsOverlay.PartList["TireFrontLeft"].vehicles["92fordCVPI_"] = {x=13,y=218,x2=55,y2=258};
ISCarMechanicsOverlay.PartList["TireFrontRight"].vehicles["92fordCVPI_"] = {x=228,y=218,x2=270,y2=258};
ISCarMechanicsOverlay.PartList["TireRearLeft"].vehicles["92fordCVPI_"] = {x=13,y=431,x2=55,y2=471};
ISCarMechanicsOverlay.PartList["TireRearRight"].vehicles["92fordCVPI_"] = {x=228,y=431,x2=270,y2=471};
--
ISCarMechanicsOverlay.PartList["DoorFrontLeft"].vehicles["92fordCVPI_"] = {x=69,y=227,x2=77,y2=312};
ISCarMechanicsOverlay.PartList["DoorFrontRight"].vehicles["92fordCVPI_"] = {x=204,y=227,x2=211,y2=312};
ISCarMechanicsOverlay.PartList["DoorRearLeft"].vehicles["92fordCVPI_"] = {x=69,y=312,x2=77,y2=380};
ISCarMechanicsOverlay.PartList["DoorRearRight"].vehicles["92fordCVPI_"] = {x=204,y=312,x2=211,y2=380};
--
ISCarMechanicsOverlay.PartList["Engine"].vehicles["92fordCVPI_"] = {x=141,y=126,x2=196,y2=225};
--
ISCarMechanicsOverlay.PartList["EngineDoor"].vehicles["92fordCVPI_"] = {x=82,y=126,x2=141,y2=225};

ISCarMechanicsOverlay.PartList["TrunkDoor"] = {img="trunk", vehicles = {"92fordCVPI_"}};
ISCarMechanicsOverlay.PartList["TrunkDoor"].vehicles["92fordCVPI_"] = {x=86,y=430,x2=195,y2=485};
--
ISCarMechanicsOverlay.PartList["WindowFrontLeft"].vehicles["92fordCVPI_"] = {x=77,y=247,x2=95,y2=316};
ISCarMechanicsOverlay.PartList["WindowFrontRight"].vehicles["92fordCVPI_"] = {x=186,y=247,x2=204,y2=316};
ISCarMechanicsOverlay.PartList["WindowRearLeft"].vehicles["92fordCVPI_"] = {x=77,y=316,x2=95,y2=376};
ISCarMechanicsOverlay.PartList["WindowRearRight"].vehicles["92fordCVPI_"] = {x=186,y=316,x2=204,y2=376};
--
ISCarMechanicsOverlay.PartList["Windshield"].vehicles["92fordCVPI_"] = {x=93,y=225,x2=188,y2=276};
ISCarMechanicsOverlay.PartList["WindshieldRear"].vehicles["92fordCVPI_"] = {x=92,y=386,x2=189,y2=430};
--
ISCarMechanicsOverlay.PartList["GasTank"].vehicles["92fordCVPI_"] = {img="gastank", x=14,y=527,x2=70,y2=565};
--
ISCarMechanicsOverlay.PartList["Muffler"].vehicles["92fordCVPI_"] = {x=200,y=527,x2=269,y2=564};

ISCarMechanicsOverlay.PartList["CVPI92BumperFront"].vehicles["92fordCVPI_"] = {x=98,y=48,x2=141,y2=86};
ISCarMechanicsOverlay.PartList["CVPI92WindshieldArmor"].vehicles["92fordCVPI_"] = {x=144,y=48,x2=187,y2=86};
ISCarMechanicsOverlay.PartList["CVPI92WindowFrontLeftArmor"].vehicles["92fordCVPI_"] = {x=13,y=268,x2=55,y2=306};
ISCarMechanicsOverlay.PartList["CVPI92WindowFrontRightArmor"].vehicles["92fordCVPI_"] = {x=228,y=268,x2=270,y2=306};
ISCarMechanicsOverlay.PartList["CVPI92WindowRearLeftArmor"].vehicles["92fordCVPI_"] = {x=13,y=310,x2=55,y2=346};
ISCarMechanicsOverlay.PartList["CVPI92WindowRearRightArmor"].vehicles["92fordCVPI_"] = {x=228,y=310,x2=270,y2=346};
ISCarMechanicsOverlay.PartList["CVPI92WindshieldRearArmor"].vehicles["92fordCVPI_"] = {x=120,y=526,x2=163,y2=564};
--