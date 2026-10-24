-- Integrated from More Car Variants (KI5) (MCV86chevyCUCV).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136
-- Third-party contribution; excluded from the project MIT license.
if not require("OnlyKI5VehicleSpawnLiveryOverhaul_Fleet").active("86chevyCUCV") then return end
require "DAMN_MechOverlay";
--
--##########86chevyM1010##########
--
DAMN.MechOverlay:addParts({
    ["Base.86chevyM1010ambulance"] = "86chevyM1010_",
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