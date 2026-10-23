-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.

-- common custom parts

ISCarMechanicsOverlay.PartList["SUB93BumperFront"] = {img="bullbar", vehicles = {}};
ISCarMechanicsOverlay.PartList["SUB93BumperRear"] = {img="bullbarr", vehicles = {}};
ISCarMechanicsOverlay.PartList["SUB93WindshieldArmor"] = {img="windshield_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["SUB93WindowFrontLeftArmor"] = {img="window_front_left_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["SUB93WindowFrontRightArmor"] = {img="window_front_right_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["SUB93WindowRearLeftArmor"] = {img="window_rear_left_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["SUB93WindowRearRightArmor"] = {img="window_rear_right_armor", vehicles = {}};
ISCarMechanicsOverlay.PartList["SUB93WindshieldRearArmor"] = {img="windshield_rear_armor", vehicles = {}};
if not ISCarMechanicsOverlay.PartList["SUB93RollbarToolbox"] then
	ISCarMechanicsOverlay.PartList["SUB93RollbarToolbox"] = {img="windshield_rear_armor2", vehicles = {}};
end
--
--##########93chevySuburbanKYR##########
--
ISCarMechanicsOverlay.CarList["Base.93chevySuburbanpdMuldraugh"] = ISCarMechanicsOverlay.CarList["Base.93chevySuburban"]
ISCarMechanicsOverlay.CarList["Base.93chevySuburbanpdWestPoint"] = ISCarMechanicsOverlay.CarList["Base.93chevySuburban"]
ISCarMechanicsOverlay.CarList["Base.93chevySuburbanpdLouisville"] = ISCarMechanicsOverlay.CarList["Base.93chevySuburban"]
ISCarMechanicsOverlay.CarList["Base.93chevySuburbanpdMeade"] = ISCarMechanicsOverlay.CarList["Base.93chevySuburban"]
ISCarMechanicsOverlay.CarList["Base.93chevySuburbanpdBulletin"] = ISCarMechanicsOverlay.CarList["Base.93chevySuburban"]
--
ISCarMechanicsOverlay.PartList["Battery"].vehicles["93chevySuburban_"] = {img="battery", x=228,y=67,x2=270,y2=98};
--
ISCarMechanicsOverlay.PartList["SuspensionFrontLeft"].vehicles["93chevySuburban_"] = {img="suspension_front_left", x=13,y=153,x2=55,y2=191};
ISCarMechanicsOverlay.PartList["SuspensionFrontRight"].vehicles["93chevySuburban_"] = {img="suspension_front_right", x=228,y=153,x2=270,y2=191};
ISCarMechanicsOverlay.PartList["SuspensionRearLeft"].vehicles["93chevySuburban_"] = {x=13,y=367,x2=55,y2=406};
ISCarMechanicsOverlay.PartList["SuspensionRearRight"].vehicles["93chevySuburban_"] = {x=228,y=367,x2=270,y2=406};
--
ISCarMechanicsOverlay.PartList["BrakeFrontLeft"].vehicles["93chevySuburban_"] = {img="brake_front_left", x=14,y=191,x2=55,y2=228};
ISCarMechanicsOverlay.PartList["BrakeFrontRight"].vehicles["93chevySuburban_"] = {img="brake_front_right", x=228,y=191,x2=270,y2=228};
ISCarMechanicsOverlay.PartList["BrakeRearLeft"].vehicles["93chevySuburban_"] = {x=13,y=406,x2=55,y2=441};
ISCarMechanicsOverlay.PartList["BrakeRearRight"].vehicles["93chevySuburban_"] = {x=228,y=406,x2=270,y2=441};
--
ISCarMechanicsOverlay.PartList["TireFrontLeft"].vehicles["93chevySuburban_"] = {x=13,y=228,x2=55,y2=268};
ISCarMechanicsOverlay.PartList["TireFrontRight"].vehicles["93chevySuburban_"] = {x=228,y=228,x2=270,y2=268};
ISCarMechanicsOverlay.PartList["TireRearLeft"].vehicles["93chevySuburban_"] = {x=13,y=441,x2=55,y2=481};
ISCarMechanicsOverlay.PartList["TireRearRight"].vehicles["93chevySuburban_"] = {x=228,y=441,x2=270,y2=481};
--
ISCarMechanicsOverlay.PartList["DoorFrontLeft"].vehicles["93chevySuburban_"] = {x=73,y=203,x2=79,y2=293};
ISCarMechanicsOverlay.PartList["DoorFrontRight"].vehicles["93chevySuburban_"] = {x=206,y=203,x2=213,y2=293};
ISCarMechanicsOverlay.PartList["DoorRearLeft"].vehicles["93chevySuburban_"] = {x=73,y=293,x2=79,y2=365};
ISCarMechanicsOverlay.PartList["DoorRearRight"].vehicles["93chevySuburban_"] = {x=206,y=293,x2=213,y2=365};
--
ISCarMechanicsOverlay.PartList["Engine"].vehicles["93chevySuburban_"] = {x=141,y=105,x2=203,y2=187};
--
ISCarMechanicsOverlay.PartList["EngineDoor"].vehicles["93chevySuburban_"] = {x=83,y=105,x2=141,y2=187};
--
ISCarMechanicsOverlay.PartList["TruckBed"].vehicles["93chevySuburban_"] = {x=83,y=491,x2=200,y2=496};
--
ISCarMechanicsOverlay.PartList["WindowFrontLeft"].vehicles["93chevySuburban_"] = {x=79,y=238,x2=90,y2=286};
ISCarMechanicsOverlay.PartList["WindowFrontRight"].vehicles["93chevySuburban_"] = {x=195,y=238,x2=206,y2=286};
ISCarMechanicsOverlay.PartList["WindowRearLeft"].vehicles["93chevySuburban_"] = {x=79,y=300,x2=90,y2=356};
ISCarMechanicsOverlay.PartList["WindowRearRight"].vehicles["93chevySuburban_"] = {x=195,y=300,x2=206,y2=356};
--
ISCarMechanicsOverlay.PartList["Windshield"].vehicles["93chevySuburban_"] = {x=90,y=198,x2=195,y2=238};
ISCarMechanicsOverlay.PartList["WindshieldRear"].vehicles["93chevySuburban_"] = {x=83,y=468,x2=200,y2=491};
--
ISCarMechanicsOverlay.PartList["GasTank"].vehicles["93chevySuburban_"] = {img="gastank", x=13,y=537,x2=70,y2=575};
--
ISCarMechanicsOverlay.PartList["Muffler"].vehicles["93chevySuburban_"] = {x=200,y=537,x2=269,y2=575};

ISCarMechanicsOverlay.PartList["SUB93BumperFront"].vehicles["93chevySuburban_"] = {x=98,y=25,x2=141,y2=63};
ISCarMechanicsOverlay.PartList["SUB93BumperRear"].vehicles["93chevySuburban_"] = {x=146,y=536,x2=187,y2=574};
ISCarMechanicsOverlay.PartList["SUB93WindshieldArmor"].vehicles["93chevySuburban_"] = {x=144,y=25,x2=187,y2=63};
ISCarMechanicsOverlay.PartList["SUB93WindowFrontLeftArmor"].vehicles["93chevySuburban_"] = {x=13,y=278,x2=55,y2=316};
ISCarMechanicsOverlay.PartList["SUB93WindowFrontRightArmor"].vehicles["93chevySuburban_"] = {x=228,y=278,x2=270,y2=316};
ISCarMechanicsOverlay.PartList["SUB93WindowRearLeftArmor"].vehicles["93chevySuburban_"] = {x=13,y=320,x2=55,y2=356};
ISCarMechanicsOverlay.PartList["SUB93WindowRearRightArmor"].vehicles["93chevySuburban_"] = {x=228,y=320,x2=270,y2=356};
--
--##########93chevySilveradoXClong##########
--
ISCarMechanicsOverlay.CarList["Base.93chevySilveradoCClongSecurity"] = ISCarMechanicsOverlay.CarList["Base.93chevySilveradoCClong"]
ISCarMechanicsOverlay.CarList["Base.93chevySilveradoCClongLouisville"] = ISCarMechanicsOverlay.CarList["Base.93chevySilveradoCClong"]
ISCarMechanicsOverlay.CarList["Base.93chevySilveradoCClongMuldraugh"] = ISCarMechanicsOverlay.CarList["Base.93chevySilveradoCClong"]
--
ISCarMechanicsOverlay.PartList["Battery"].vehicles["93chevySilveradoXClong_"] = {img="battery", x=228,y=67,x2=270,y2=98};
--
ISCarMechanicsOverlay.PartList["SuspensionFrontLeft"].vehicles["93chevySilveradoXClong_"] = {img="suspension_front_left", x=13,y=153,x2=55,y2=191};
ISCarMechanicsOverlay.PartList["SuspensionFrontRight"].vehicles["93chevySilveradoXClong_"] = {img="suspension_front_right", x=228,y=153,x2=270,y2=191};
ISCarMechanicsOverlay.PartList["SuspensionRearLeft"].vehicles["93chevySilveradoXClong_"] = {x=13,y=367,x2=55,y2=406};
ISCarMechanicsOverlay.PartList["SuspensionRearRight"].vehicles["93chevySilveradoXClong_"] = {x=228,y=367,x2=270,y2=406};
--
ISCarMechanicsOverlay.PartList["BrakeFrontLeft"].vehicles["93chevySilveradoXClong_"] = {img="brake_front_left", x=14,y=191,x2=55,y2=228};
ISCarMechanicsOverlay.PartList["BrakeFrontRight"].vehicles["93chevySilveradoXClong_"] = {img="brake_front_right", x=228,y=191,x2=270,y2=228};
ISCarMechanicsOverlay.PartList["BrakeRearLeft"].vehicles["93chevySilveradoXClong_"] = {x=13,y=406,x2=55,y2=441};
ISCarMechanicsOverlay.PartList["BrakeRearRight"].vehicles["93chevySilveradoXClong_"] = {x=228,y=406,x2=270,y2=441};
--
ISCarMechanicsOverlay.PartList["TireFrontLeft"].vehicles["93chevySilveradoXClong_"] = {x=13,y=228,x2=55,y2=268};
ISCarMechanicsOverlay.PartList["TireFrontRight"].vehicles["93chevySilveradoXClong_"] = {x=228,y=228,x2=270,y2=268};
ISCarMechanicsOverlay.PartList["TireRearLeft"].vehicles["93chevySilveradoXClong_"] = {x=13,y=441,x2=55,y2=481};
ISCarMechanicsOverlay.PartList["TireRearRight"].vehicles["93chevySilveradoXClong_"] = {x=228,y=441,x2=270,y2=481};
--
ISCarMechanicsOverlay.PartList["DoorFrontLeft"].vehicles["93chevySilveradoXClong_"] = {x=73,y=203,x2=79,y2=293};
ISCarMechanicsOverlay.PartList["DoorFrontRight"].vehicles["93chevySilveradoXClong_"] = {x=206,y=203,x2=213,y2=293};
--
ISCarMechanicsOverlay.PartList["Engine"].vehicles["93chevySilveradoXClong_"] = {x=141,y=105,x2=203,y2=187};
--
ISCarMechanicsOverlay.PartList["EngineDoor"].vehicles["93chevySilveradoXClong_"] = {x=83,y=105,x2=141,y2=187};
--
ISCarMechanicsOverlay.PartList["TruckBed"].vehicles["93chevySilveradoXClong_"] = {x=83,y=491,x2=200,y2=496};
--
ISCarMechanicsOverlay.PartList["WindowFrontLeft"].vehicles["93chevySilveradoXClong_"] = {x=79,y=238,x2=90,y2=286};
ISCarMechanicsOverlay.PartList["WindowFrontRight"].vehicles["93chevySilveradoXClong_"] = {x=195,y=238,x2=206,y2=286};
ISCarMechanicsOverlay.PartList["WindowRearLeft"].vehicles["93chevySilveradoXClong_"] = {x=79,y=300,x2=90,y2=356};
ISCarMechanicsOverlay.PartList["WindowRearRight"].vehicles["93chevySilveradoXClong_"] = {x=195,y=300,x2=206,y2=356};
--
ISCarMechanicsOverlay.PartList["Windshield"].vehicles["93chevySilveradoXClong_"] = {x=90,y=198,x2=195,y2=238};
--
ISCarMechanicsOverlay.PartList["GasTank"].vehicles["93chevySilveradoXClong_"] = {img="gastank", x=13,y=537,x2=70,y2=575};
--
ISCarMechanicsOverlay.PartList["Muffler"].vehicles["93chevySilveradoXClong_"] = {x=200,y=537,x2=269,y2=575};

ISCarMechanicsOverlay.PartList["SUB93BumperFront"].vehicles["93chevySilveradoXClong_"] = {x=98,y=25,x2=141,y2=63};
ISCarMechanicsOverlay.PartList["SUB93BumperRear"].vehicles["93chevySilveradoXClong_"] = {x=146,y=536,x2=187,y2=574};
ISCarMechanicsOverlay.PartList["SUB93WindshieldArmor"].vehicles["93chevySilveradoXClong_"] = {x=144,y=25,x2=187,y2=63};
ISCarMechanicsOverlay.PartList["SUB93WindowFrontLeftArmor"].vehicles["93chevySilveradoXClong_"] = {x=13,y=278,x2=55,y2=316};
ISCarMechanicsOverlay.PartList["SUB93WindowFrontRightArmor"].vehicles["93chevySilveradoXClong_"] = {x=228,y=278,x2=270,y2=316};
ISCarMechanicsOverlay.PartList["SUB93WindowRearLeftArmor"].vehicles["93chevySilveradoXClong_"] = {x=13,y=320,x2=55,y2=356};
ISCarMechanicsOverlay.PartList["SUB93WindowRearRightArmor"].vehicles["93chevySilveradoXClong_"] = {x=228,y=320,x2=270,y2=356};
ISCarMechanicsOverlay.PartList["SUB93RollbarToolbox"].vehicles["93chevySilveradoXClong_"] = {x=99,y=536,x2=140,y2=574};
ISCarMechanicsOverlay.PartList["SUB93WindshieldRearArmor"].vehicles["93chevySuburban_"] = {x=99,y=536,x2=140,y2=574};
