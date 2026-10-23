-- Integrated from More Car Variants (KI5) (MCV76chevyKseries).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
require "DAMN_MechOverlay";
--
--##########76chevyKseries##########
--
DAMN.MechOverlay:addParts({
    ["Base.76chevyK10calloway"] = "76chevyKseries_",
    ["Base.76chevyK20mccoy"] = "76chevyKseries_",
	["Base.76chevyK20brickingIt"] = "76chevyKseries_",
	["Base.76chevyK20kimble"] = "76chevyKseries_",
	["Base.76chevyK20mrc"] = "76chevyKseries_",
	["Base.76chevyK10fossoil"] = "76chevyKseries_",
	["Base.76chevyK20helton"] = "76chevyKseries_",
	["Base.76chevyK10camille"] = "76chevyKseries_",
	["Base.76chevyK10kentuckylumber"] = "76chevyKseries_",
	["Base.76chevyK10yingswood"] = "76chevyKseries_",
}, {
    Battery = {img="battery", x=228,y=111,x2=270,y2=143},
    --
    SuspensionFrontLeft = {img="suspension_front_left", x=13,y=153,x2=55,y2=191},
    SuspensionFrontRight = {img="suspension_front_right", x=228,y=153,x2=270,y2=191},
    SuspensionRearLeft = {img="suspension_rear_left", x=13,y=367,x2=55,y2=406},
    SuspensionRearRight = {img="suspension_rear_right", x=228,y=367,x2=270,y2=406},
    --
    BrakeFrontLeft = {img="brake_front_left", x=14,y=191,x2=55,y2=228},
    BrakeFrontRight = {img="brake_front_right", x=228,y=191,x2=270,y2=228},
    BrakeRearLeft = {img="brake_rear_left", x=13,y=406,x2=55,y2=441},
    BrakeRearRight = {img="brake_rear_right", x=228,y=406,x2=270,y2=441},
    --
    TireFrontLeft = {img="wheel_front_left", x=13,y=228,x2=55,y2=268},
    TireFrontRight = {img="wheel_front_right", x=228,y=228,x2=270,y2=268},
    TireRearLeft = {img="wheel_rear_left", x=13,y=441,x2=55,y2=481},
    TireRearRight = {img="wheel_rear_right", x=228,y=441,x2=270,y2=481},
    --
    DoorFrontLeft = {img="door_front_left", x=73,y=237,x2=79,y2=294},
    DoorFrontRight = {img="door_front_right", x=206,y=237,x2=213,y2=294},
    --
    Engine = {img="engine", x=141,y=141,x2=203,y2=219},
    --
    EngineDoor = {img="hood", x=83,y=141,x2=141,y2=219},
    --
    TrunkDoor = {img="trunk", x=80,y=485,x2=202,y2=492},
    --
    WindowFrontLeft = {img="window_front_left", x=79,y=237,x2=90,y2=294},
    WindowFrontRight = {img="window_front_right", x=195,y=237,x2=206,y2=294},
    --
    Windshield = {img="window_windshield", x=90,y=223,x2=195,y2=248},
    WindshieldRear = {img="window_rear_windshield", x=93,y=301,x2=190,y2=307},
    --
    GasTank = {img="gastank", x=13,y=537,x2=70,y2=575},
    --
    Muffler = {img="muffler", x=200,y=537,x2=269,y2=575},
    --
    DAMNBumperFront = {img="bullbar", x=98,y=25,x2=141,y2=63},
    DAMNBumperRear = {img="bullbarr", x=146,y=536,x2=187,y2=574},
    DAMNWindshieldArmor = {img="windshield_armor", x=144,y=25,x2=187,y2=63},
    DAMNFrontLeftArmor = {img="window_front_left_armor", x=13,y=278,x2=55,y2=316},
    DAMNFrontRightArmor = {img="window_front_right_armor", x=228,y=278,x2=270,y2=316},
    CH76TruckBedExtras = {img="windshield_rear_armor", x=99,y=536,x2=140,y2=574},
}, 10, 10);
--
--##########76chevyKseriesutil##########
--
DAMN.MechOverlay:addParts({
    ["Base.76chevyK20utilityDpw"] = "76chevyKseriesutil_",
	["Base.76chevyK20utilityFossoil"] = "76chevyKseriesutil_",
    ["Base.76chevyK20utilityMcCoy"] = "76chevyKseriesutil_",
}, {
    Battery = {img="battery", x=228,y=111,x2=270,y2=143},
    --
    SuspensionFrontLeft = {img="suspension_front_left", x=13,y=153,x2=55,y2=191},
    SuspensionFrontRight = {img="suspension_front_right", x=228,y=153,x2=270,y2=191},
    SuspensionRearLeft = {img="suspension_rear_left", x=13,y=367,x2=55,y2=406},
    SuspensionRearRight = {img="suspension_rear_right", x=228,y=367,x2=270,y2=406},
    --
    BrakeFrontLeft = {img="brake_front_left", x=14,y=191,x2=55,y2=228},
    BrakeFrontRight = {img="brake_front_right", x=228,y=191,x2=270,y2=228},
    BrakeRearLeft = {img="brake_rear_left", x=13,y=406,x2=55,y2=441},
    BrakeRearRight = {img="brake_rear_right", x=228,y=406,x2=270,y2=441},
    --
    TireFrontLeft = {img="wheel_front_left", x=13,y=228,x2=55,y2=268},
    TireFrontRight = {img="wheel_front_right", x=228,y=228,x2=270,y2=268},
    TireRearLeft = {img="wheel_rear_left", x=13,y=441,x2=55,y2=481},
    TireRearRight = {img="wheel_rear_right", x=228,y=441,x2=270,y2=481},
    --
    DoorFrontLeft = {img="door_front_left", x=73,y=237,x2=79,y2=294},
    DoorFrontRight = {img="door_front_right", x=206,y=237,x2=213,y2=294},
    --
    Engine = {img="engine", x=141,y=141,x2=203,y2=219},
    --
    EngineDoor = {img="hood", x=83,y=141,x2=141,y2=219},
    --
    TrunkDoor = {img="trunk", x=98,y=485,x2=185,y2=492},
    --
    WindowFrontLeft = {img="window_front_left", x=79,y=237,x2=90,y2=294},
    WindowFrontRight = {img="window_front_right", x=195,y=237,x2=206,y2=294},
    --
    Windshield = {img="window_windshield", x=90,y=223,x2=195,y2=248},
    WindshieldRear = {img="window_rear_windshield", x=93,y=301,x2=190,y2=307},
    --
    GasTank = {img="gastank", x=13,y=537,x2=70,y2=575},
    --
    Muffler = {img="muffler", x=200,y=537,x2=269,y2=575},
    --
    DAMNBumperFront = {img="bullbar", x=98,y=25,x2=141,y2=63},
    DAMNBumperRear = {img="bullbarr", x=146,y=536,x2=187,y2=574},
    DAMNWindshieldArmor = {img="windshield_armor", x=144,y=25,x2=187,y2=63},
    DAMNFrontLeftArmor = {img="window_front_left_armor", x=13,y=278,x2=55,y2=316},
    DAMNFrontRightArmor = {img="window_front_right_armor", x=228,y=278,x2=270,y2=316},
    DAMNWindshieldRearArmor = {img="windshield_rear_armor", x=99,y=536,x2=140,y2=574},
}, 10, 10);
--
--##########76chevyK30CCutility##########
--
DAMN.MechOverlay:addParts({
    ["Base.76chevyK30CCutilityDpw"] = "76chevyK30util_",
	["Base.76chevyK30CCutilityFossoil"] = "76chevyK30util_",
    ["Base.76chevyK30CCutilityMcCoy"] = "76chevyK30util_",
}, {
    Battery = {img="battery", x=228,y=111,x2=270,y2=143},
    --
    SuspensionFrontLeft = {img="suspension_front_left", x=13,y=153,x2=55,y2=191},
    SuspensionFrontRight = {img="suspension_front_right", x=228,y=153,x2=270,y2=191},
    SuspensionRearLeft = {img="suspension_rear_left", x=13,y=367,x2=55,y2=406},
    SuspensionRearRight = {img="suspension_rear_right", x=228,y=367,x2=270,y2=406},
    --
    BrakeFrontLeft = {img="brake_front_left", x=14,y=191,x2=55,y2=228},
    BrakeFrontRight = {img="brake_front_right", x=228,y=191,x2=270,y2=228},
    BrakeRearLeft = {img="brake_rear_left", x=13,y=406,x2=55,y2=441},
    BrakeRearRight = {img="brake_rear_right", x=228,y=406,x2=270,y2=441},
    --
    TireFrontLeft = {img="wheel_front_left", x=13,y=228,x2=55,y2=268},
    TireFrontRight = {img="wheel_front_right", x=228,y=228,x2=270,y2=268},
    TireRearLeft = {img="wheel_rear_left", x=13,y=441,x2=55,y2=481},
    TireRearRight = {img="wheel_rear_right", x=228,y=441,x2=270,y2=481},
    --
    DoorFrontLeft = {img="door_front_left", x=73,y=204,x2=79,y2=260},
    DoorFrontRight = {img="door_front_right", x=203,y=204,x2=211,y2=260},
    DoorRearLeft = {img="door_rear_left", x=73,y=260,x2=79,y2=318},
    DoorRearRight = {img="door_rear_right", x=203,y=260,x2=211,y2=318},
    --
    Engine = {img="engine", x=141,y=107,x2=203,y2=187},
    --
    EngineDoor = {img="hood", x=83,y=107,x2=141,y2=187},
    --
    TrunkDoor = {img="trunk", x=98,y=506,x2=185,y2=512},
    --
    WindowFrontLeft = {img="window_front_left", x=79,y=217,x2=90,y2=260},
    WindowFrontRight = {img="window_front_right", x=193,y=217,x2=203,y2=260},
    WindowRearLeft = {img="window_rear_left", x=79,y=260,x2=90,y2=318},
    WindowRearRight = {img="window_rear_right", x=193,y=260,x2=203,y2=318},
    --
    Windshield = {img="window_windshield", x=90,y=189,x2=195,y2=214},
    WindshieldRear = {img="window_rear_windshield", x=93,y=323,x2=190,y2=327},
    --
    GasTank = {img="gastank", x=13,y=537,x2=70,y2=575},
    --
    Muffler = {img="muffler", x=200,y=537,x2=269,y2=575},
    --
    DAMNBumperFront = {img="bullbar", x=98,y=25,x2=141,y2=63},
    DAMNBumperRear = {img="bullbarr", x=146,y=536,x2=187,y2=574},
    DAMNWindshieldArmor = {img="windshield_armor", x=144,y=25,x2=187,y2=63},
    DAMNFrontLeftArmor = {img="window_front_left_armor", x=13,y=278,x2=55,y2=316},
    DAMNFrontRightArmor = {img="window_front_right_armor", x=228,y=278,x2=270,y2=316},
    DAMNRearLeftArmor = {img="window_rear_left_armor", x=13,y=320,x2=55,y2=357},
    DAMNRearRightArmor = {img="window_rear_right_armor", x=228,y=320,x2=270,y2=357},
    DAMNWindshieldRearArmor = {img="windshield_rear_armor", x=99,y=536,x2=140,y2=574},
}, 10, 10);