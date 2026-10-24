-- Integrated from More Car Variants (KI5) (MCV93fordFseries).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
if not require("OnlyKI5VehicleSpawnLiveryOverhaul_Fleet").active("93fordF350") then return end
require "DAMN_MechOverlay";
--
--##########93fordF350##########
--
DAMN.MechOverlay:addParts({
    ["Base.93fordF350fossoil"] = "93fordF350_",
	["Base.93fordF350as"] = "93fordF350_",
	["Base.93fordF350airport"] = "93fordF350_",
}, {
    Battery = {img="battery", x=228,y=67,x2=270,y2=98},
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
    DoorFrontLeft = {img="door_front_left", x=73,y=196,x2=79,y2=258},
    DoorFrontRight = {img="door_front_right", x=203,y=196,x2=210,y2=258},
    DoorRearLeft = {img="door_rear_left", x=73,y=271,x2=79,y2=317},
    DoorRearRight = {img="door_rear_right", x=203,y=271,x2=210,y2=317},
    --
    Engine = {img="engine", x=141,y=87,x2=210,y2=174},
    --
    EngineDoor = {img="hood", x=83,y=87,x2=141,y2=174},
    --
    TrunkDoor = {img="trunk", x=79,y=503,x2=204,y2=509},
    --
    WindowFrontLeft = {img="window_front_left", x=79,y=196,x2=90,y2=258},
    WindowFrontRight = {img="window_front_right", x=193,y=196,x2=203,y2=258},
    WindowRearLeft = {img="window_rear_left", x=79,y=271,x2=90,y2=317},
    WindowRearRight = {img="window_rear_right", x=193,y=271,x2=203,y2=317},
    --
    Windshield = {img="window_windshield", x=90,y=176,x2=193,y2=214},
    WindshieldRear = {img="window_rear_windshield", x=92,y=324,x2=190,y2=329},
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
    DAMNRearLeftArmor = {img="window_rear_left_armor", x=13,y=320,x2=55,y2=356},
    DAMNRearRightArmor = {img="window_rear_right_armor", x=228,y=320,x2=270,y2=356},
    F3502HeadacheRack = {img="windshield_rear_armor", x=99,y=536,x2=140,y2=574},
}, 10, 10);
--
--##########93fordF350utility##########
--
DAMN.MechOverlay:addParts({
    ["Base.93fordF350mccoy"] = "93fordF350utility_",
}, {
    Battery = {img="battery", x=228,y=67,x2=270,y2=98},
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
    DoorFrontLeft = {img="door_front_left", x=73,y=196,x2=79,y2=258},
    DoorFrontRight = {img="door_front_right", x=203,y=196,x2=210,y2=258},
    DoorRearLeft = {img="door_rear_left", x=73,y=271,x2=79,y2=317},
    DoorRearRight = {img="door_rear_right", x=203,y=271,x2=210,y2=317},
    --
    Engine = {img="engine", x=141,y=87,x2=210,y2=174},
    --
    EngineDoor = {img="hood", x=83,y=87,x2=141,y2=174},
    --
    TrunkDoor = {img="trunk", x=97,y=503,x2=186,y2=509},
    --
    WindowFrontLeft = {img="window_front_left", x=79,y=196,x2=90,y2=258},
    WindowFrontRight = {img="window_front_right", x=193,y=196,x2=203,y2=258},
    WindowRearLeft = {img="window_rear_left", x=79,y=271,x2=90,y2=317},
    WindowRearRight = {img="window_rear_right", x=193,y=271,x2=203,y2=317},
    --
    Windshield = {img="window_windshield", x=90,y=176,x2=193,y2=214},
    WindshieldRear = {img="window_rear_windshield", x=92,y=324,x2=190,y2=329},
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
    DAMNRearLeftArmor = {img="window_rear_left_armor", x=13,y=320,x2=55,y2=356},
    DAMNRearRightArmor = {img="window_rear_right_armor", x=228,y=320,x2=270,y2=356},
    DAMNWindshieldRearArmor = {img="windshield_rear_armor", x=99,y=536,x2=140,y2=574},
}, 10, 10);
--
--##########93fordF150##########
--
DAMN.MechOverlay:addParts({
    ["Base.93fordF250jplandscaping"] = "93fordF150_",
}, {
    Battery = {img="battery", x=228,y=67,x2=270,y2=98},
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
    DoorFrontLeft = {img="door_front_left", x=73,y=250,x2=79,y2=313},
    DoorFrontRight = {img="door_front_right", x=203,y=250,x2=210,y2=313},
    --
    Engine = {img="engine", x=141,y=140,x2=210,y2=229},
    --
    EngineDoor = {img="hood", x=83,y=140,x2=141,y2=229},
    --
    TrunkDoor = {img="trunk", x=79,y=492,x2=204,y2=498},
    --
    WindowFrontLeft = {img="window_front_left", x=79,y=250,x2=90,y2=313},
    WindowFrontRight = {img="window_front_right", x=193,y=250,x2=203,y2=313},
    --
    Windshield = {img="window_windshield", x=90,y=229,x2=193,y2=269},
    WindshieldRear = {img="window_rear_windshield", x=92,y=313,x2=190,y2=317},
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
    DAMNRearLeftArmor = {img="window_rear_left_armor", x=13,y=320,x2=55,y2=356},
    DAMNRearRightArmor = {img="window_rear_right_armor", x=228,y=320,x2=270,y2=356},
    F3502HeadacheRack = {img="windshield_rear_armor", x=99,y=536,x2=140,y2=574},
}, 10, 10);