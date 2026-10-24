-- Drive production callbacks and all four imported scenes without any library
-- loaders. Native world/physics services are spies, so this is functional Lua
-- coverage, not an in-game visual or multiplayer acceptance test.
local client, server = false, true
function isClient() return client end
function isServer() return server end
function isMultiplayer() return server end
function getChunkSizeInSquares() return 8 end
local errors = {}
function print(message) errors[#errors + 1] = message end
function round(value, digits)
    local scale = 10 ^ (digits or 0)
    return math.floor(value * scale + 0.5) / scale
end
local function event()
    local e = {callbacks = {}}
    function e.Add(f) e.callbacks[#e.callbacks + 1] = f end
    function e.fire(...) for _, f in ipairs(e.callbacks) do f(...) end end
    return e
end
Events = {OnLoadMapZones = event(), OnLoadedMapZones = event(),
    OnSpawnVehicleStart = event(), OnSpawnVehicleEnd = event(), OnInitGlobalModData = event(),
    LoadChunk = event(), OnTick = event()}
local randomQueue = {}
function ZombRand(a, b) if b then return a end return 0 end
function ZombRandFloat(a, b)
    if #randomQueue > 0 then return table.remove(randomQueue, 1) end
    return a
end
local days = 10
function getGameTime() return {getWorldAgeHours = function() return days * 24 end} end
local mapObjects, reloads, registrations = {}, 0, {}
function reloadLuaFile(path)
    reloads = reloads + 1
    objects = mapObjects[path] or {}
    return "original-return", 42
end
function getLotDirectories()
    return {size = function() return 2 end,
        get = function(_, index) return index == 0 and "Muldraugh, KY" or "OverrideTown" end}
end
function fileExists(path)
    return path == "media/maps/OverrideTown/1_1.lotheader"
end
function getWorld()
    return {registerVehiclesZone = function(_, name, kind, x, y, z, width, height, properties)
        registrations[#registrations + 1] = {name=name, x=x, y=y, props=properties}
        return {}
    end}
end
local angularZone
function getVehicleZoneAt() return angularZone end
local directions = {N = -math.pi/2, E = 0, S = math.pi/2, W = math.pi}
IsoDirections = {}
for name, angle in pairs(directions) do
    local directionName, directionAngle = name, angle
    IsoDirections[name] = setmetatable({
        ToVector = function() return {getDirection = function() return directionAngle end} end,
    }, {__tostring = function() return directionName end})
end
local Support = require "OnlyKI5VehicleSpawnLiveryOverhaul_WorldSupport"
local Zones = require "OnlyKI5VehicleSpawnLiveryOverhaul_MilitaryZones"

-- Existing loader chaining, exact file/coordinate matching and property merge.
local edited = "media/maps/Muldraugh, KY/objects.lua"
Zones.change("Muldraugh, KY", {
    ["10,20,0"] = {name="military_vehicle_light", width=5, properties={Direction="E"}},
    ["11,20,0"] = "remove",
})
mapObjects[edited] = {
    {type="ParkingStall",name="old",x=10,y=20,z=0,width=3,height=4,
        properties={FaceDirection=true,Other="retained"}},
    {type="ParkingStall",name="removed",x=11,y=20,z=0},
    {type="Nav",name="unchanged",x=10,y=20,z=0},
}
local one, two = reloadLuaFile(edited)
assert(one == "original-return" and two == 42 and reloads == 1)
assert(#objects == 2 and objects[1].name == "military_vehicle_light")
assert(objects[1].width == 5 and objects[1].height == 4)
assert(objects[1].properties.Direction == "E" and objects[1].properties.FaceDirection)
assert(objects[1].properties.Other == "retained" and objects[2].name == "unchanged")
local unrelated = {{type="ParkingStall",name="keep",x=10,y=20,z=0}}
mapObjects["unrelated.lua"] = unrelated
reloadLuaFile("unrelated.lua")
assert(objects == unrelated and objects[1].name == "keep")

-- A non-first map directory can replace a cell; repeated registrations dedupe.
local records = {
    {name="military_vehicle",type="ParkingStall",x=400,y=400,z=0,width=3,height=4},
    {name="military_vehicle",type="ParkingStall",x=800,y=800,z=0,width=3,height=4},
}
Zones.register(records, true)
Zones.register(records, true)
assert(#registrations == 1 and registrations[1].x == 800)
local row={name='military_vehicle',type='ParkingStall',x=5586,y=12447,z=0,width=5,height=25,properties={Direction='W'}}
Zones.register({row},false)
Zones.register({row},false)
assert(#registrations==5,'spaced row registration/deduplication')
for i=2,5 do
    assert(registrations[i].y==12447+(i-2)*6)
    assert(registrations[i].props.Direction=='W' and registrations[i].props.FaceDirection)
end
assert(row.height==25 and not row.properties.FaceDirection,'upstream row mutated')
VehicleZoneDistribution = {
    military = {vehicles={MockCar={spawnChance=10}}},
    military_vehicle_light = {vehicles={MockCar={spawnChance=10}}},
    civilian = {vehicles={MockCar={spawnChance=10}}},
    skinned = {vehicles={MockCar={spawnChance=10,index=0,skins={0}}}},
    unrelated = false,
}
Zones.clearSpawnZones(VehicleZoneDistribution.military.vehicles, true, true)
assert(not VehicleZoneDistribution.civilian.vehicles.MockCar)
assert(VehicleZoneDistribution.skinned.vehicles.MockCar)
assert(VehicleZoneDistribution.military_vehicle_light.vehicles.MockCar)

-- Angles apply only to newly spawned military-zone vehicles, once.
VehicleZoneDistribution.military_vehicle_angled = {positionAngles={-30,30}}
angularZone = {getName = function() return "military_vehicle_angled" end}
local angleWrites = 0
local angled = {
    isCreated=function() return false end,
    getX=function() return 20 end,getY=function() return 30 end,getZ=function() return 0 end,
    getAngleX=function() return 1 end,getAngleY=function() return 2 end,getAngleZ=function() return 100 end,
    setAngles=function(_, x,y,z) assert(x==1 and y==2 and z==70); angleWrites=angleWrites+1 end,
}
Events.OnSpawnVehicleStart.fire(angled)
Events.OnSpawnVehicleEnd.fire(angled)
Events.OnSpawnVehicleEnd.fire(angled)
assert(angleWrites == 1)
angled.isCreated = function() return true end
Events.OnSpawnVehicleStart.fire(angled); Events.OnSpawnVehicleEnd.fire(angled)
assert(angleWrites == 1)
client = true
angled.isCreated = function() return false end
Events.OnSpawnVehicleStart.fire(angled); Events.OnSpawnVehicleEnd.fire(angled)
assert(angleWrites == 1)
client = false

-- Native API spies used by the actual imported road-scene recipes.
local sceneCalls = {vehicles=0, trailers=0, zombies=0, objects=0, floors=0, corpses=0, loot=0}
local squares, missing, occupied = {}, nil, nil
local cell = {}
local nativeChunk = {}
local function container(empty)
    return {isEmpty=function() return empty end,setExplored=function() end,
        markFilled=function() empty=false end}
end
local function worldObject(square)
    local inventory
    return {getSquare=function() return square end,
        getSprite=function() return nil end,setRenderYOffset=function() end,
        getItemContainer=function() return inventory end,
        setContainer=function(_, value) inventory=value end,
        transmitCompleteItemToClients=function() end}
end
local function squareAt(x,y,z)
    local key = x..":"..y..":"..z
    if key == missing then return nil end
    if not squares[key] then
        local data = {}
        local square = {
            getX=function() return x end,getY=function() return y end,getZ=function() return z end,
            getModData=function() return data end,getChunk=function() return nativeChunk end,
            getCell=function() return cell end,getBuilding=function() return nil end,
            isWaterSquare=function() return false end,
            isVehicleIntersecting=function() return key == occupied end,
            spawnRandomGenerator=function() end,
            AddWorldInventoryItem=function() return {} end,
            AddTileObject=function() sceneCalls.objects=sceneCalls.objects+1 end,
            getObjects=function() return {size=function() return 0 end} end,
        }
        square.getZone = function() return square.zone end
        square.addFloor = function() sceneCalls.floors=sceneCalls.floors+1; return worldObject(square) end
        squares[key] = square
    end
    return squares[key]
end
function cell:getGridSquare(x,y,z) return squareAt(x,y,z) end
function cell:getOrCreateGridSquare(x,y,z) return squareAt(x,y,z) end
function getCell() return cell end
IsoObject = {getNew=function(square) return worldObject(square) end}
IsoCurtain = {new=function(_,square) return worldObject(square) end}
IsoWindowFrame = {new=function(_,square) return worldObject(square) end}
IsoRadio = {new=function(_,square) return worldObject(square) end}
IsoSpriteManager = {instance={getSprite=function(_,name) return name end}}
MapObjects = {newGridSquare=function() end,loadGridSquare=function() end}
ItemContainer = {new=function() return container(true) end}
ItemPickerJava = {
    getItemContainer=function() return {} end,
    rollItem=function(_,inventory) sceneCalls.loot=sceneCalls.loot+1; inventory.markFilled() end,
}
function addBloodSplat() end
local function script(name)
    if name == "Missing" then return nil end
    return {getPartById=function(_,part)
        if name == "MockSemi" and part == "DAMNSemiTrailerHook" then return {} end
        if name == "MockTruck" and part == "DAMNSemiTrailerSaddle" then return {} end
    end,
    getExtents=function() return {z=function() return 6 end} end,
    getCenterOfMassOffset=function() return {z=function() return 0 end} end,
    getAttachmentById=function() return nil end}
end
ScriptManager = {instance={getVehicle=function(_,name) return script(name) end}}
local nativeWorld = {}
local lastNativeName
local failVehicle
local function vehicleAt(name,x,y,z)
    local square = squareAt(math.floor(x),math.floor(y),math.floor(z))
    return {
        getSquare=function() return square end,
        setAlarmed=function() end,setGeneralPartCondition=function() end,
        setHeadlightsOn=function() end,setLightbarLightsMode=function() end,
        hasLightbar=function() return false end,
        getBattery=function() return {setLastUpdated=function() end} end,
        getAllSeatParts=function() return {size=function() return 3 end} end,
        getZombieType=function() return nil end,getRandomZombieType=function() return "ArmyCamoGreen" end,
        getScriptName=function() return name end,
    }
end
function nativeWorld:addVehicle(zone,x,y,z,angle,zoneName,name,skin,specific)
    sceneCalls.vehicles = sceneCalls.vehicles + 1
    if failVehicle then error("simulated native rejection") end
    lastNativeName = name
    return vehicleAt(name,x,y,z)
end
function nativeWorld:addVehicleFlipped(...) return self:addVehicle(...) end
function nativeWorld:addTrailer(vehicle,zone,chunk,zoneName,distribution,name)
    assert(distribution == nil and name)
    sceneCalls.trailers=sceneCalls.trailers+1
    return {}
end
function nativeWorld:addZombiesOnVehicle(count,outfit,female,vehicle)
    assert(count>0 and vehicle); sceneCalls.zombies=sceneCalls.zombies+count
end
function nativeWorld:addTileObject(square,obj)
    sceneCalls.objects=sceneCalls.objects+1
    return obj
end
RandomizedWorldBase = {new=function() return nativeWorld end,
    createRandomDeadBody=function() sceneCalls.corpses=sceneCalls.corpses+1; return {} end}
local Scene = require "OnlyKI5VehicleSpawnLiveryOverhaul_RoadScene"
local enabledLightbar
Scene:enableVehicleLightbar({hasLightbar=function() return false end,
    setLightbarLightsMode=function() error('Cannot enable missing lightbar hardware') end})
Scene:enableVehicleLightbar({hasLightbar=function() return true end,
    setLightbarLightsMode=function(_,mode) enabledLightbar=mode end})
assert(enabledLightbar==2,'Actual lightbar hardware must retain the recipe mode')
local scene = setmetatable({spawnPoint={x=20.5,y=20.5,z=0},direction=IsoDirections.N}, {__index=Scene})
local expected = {N={2,-3},E={-3,-2},S={-2,3},W={3,2}}
for name, values in pairs(expected) do
    scene.direction=IsoDirections[name]
    local x,y=scene:calcOffset(2,3)
    assert(x==values[1] and y==values[2])
end
VehicleZoneDistribution.pick = {vehicles={MockCar={spawnChance=1},
    MockTruck={spawnChance=3},Missing={spawnChance=100}}}
assert(Scene.getVehicleFromZone("pick",{"MockCar"},true) == "MockTruck")
VehicleZoneDistribution.tow = {vehicles={MockSemi={spawnChance=10},MockSmall={spawnChance=1}}}
assert(Scene.getAllowedTrailerFromZone("MockCar","tow",{"MockSmall"},true) == nil)
assert(Scene.getAllowedTrailerFromZone("MockTruck","tow",{"MockSmall"},true) == "MockSemi")
local inventoryObject=worldObject(squareAt(30,30,0))
Support.refillContainer(inventoryObject,"armytent","locker","LockerArmyBedroom",false)
local lootBefore=sceneCalls.loot
Support.refillContainer(inventoryObject,"armytent","locker","LockerArmyBedroom",false)
assert(sceneCalls.loot == lootBefore, "existing inventory must not be cleared/rerolled")

-- Load all four real imported recipes. No external require is mocked or available.
SandboxVars = {VehicleStoryChance=7,VMZ={RoadStories=true,RoadStoriesMultiplier=1,
    RoadStoriesMinDay=5,RoadStoriesMaxDay=90}}
local Stories = require "OnlyKI5VehicleSpawnLiveryOverhaul_RoadStories"
for _, name in ipairs({"BiohazardCrash","MilitaryBlockade","MilitaryBlockpost","MilitaryConvoy"}) do
    require("OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_"..name)
end
require "OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_Sandbox"
Events.OnInitGlobalModData.fire()
assert(#Stories.getVehicleStoriesList() == 4)
VehicleZoneDistribution.military_vehicle_light={vehicles={MockCar={spawnChance=10}}}
VehicleZoneDistribution.military_vehicle_heavy={vehicles={MockTruck={spawnChance=10}}}
VehicleZoneDistribution.military_trailer_light={vehicles={MockSmall={spawnChance=10}}}
VehicleZoneDistribution.military_trailer_heavy={vehicles={MockSemi={spawnChance=10}}}
VehicleZoneDistribution.military_container={vehicles={MockContainer={spawnChance=10}}}
local checkpointKey="OnlyKI5VehicleSpawnLiveryOverhaul_RoadStory"
local function chunkAt(x,isNew)
    local stamp=0
    local zone={getType=function() return "Nav" end,getWidth=function() return 20 end,
        getHeight=function() return 1000 end,getX=function() return x-10 end,
        getY=function() return 0 end,isRectangle=function() return true end,
        haveCons=function() return false end,getLastActionTimestamp=function() return stamp end,
        setLastActionTimestamp=function(_,value) stamp=value end}
    local anchor=squareAt(x,100,0); anchor.zone=zone
    local chunk={
        getGridSquare=function(_,cx,cy,z)
            if cx==0 and cy==0 and z==0 then return anchor end
        end,isNewChunk=function() return isNew end}
    return chunk,anchor
end
local function tick() for _=1,30 do Events.OnTick.fire() end end
local old,oldAnchor=chunkAt(1000,false)
oldAnchor:getModData().playerValue="retained"
Events.LoadChunk.fire(old)
assert(not oldAnchor:getModData()[checkpointKey] and oldAnchor:getModData().playerValue=="retained")
client=true
local clientChunk,clientAnchor=chunkAt(1100,true)
Events.LoadChunk.fire(clientChunk)
assert(not clientAnchor:getModData()[checkpointKey])
client=false
local early,earlyAnchor=chunkAt(1200,true)
days=1; randomQueue={0}
Events.LoadChunk.fire(early)
assert(earlyAnchor:getModData()[checkpointKey].state=="checked")
days=10

local function selectStory(x,roll,name)
    local chunk,anchor=chunkAt(x,true)
    randomQueue={0,roll}
    Events.LoadChunk.fire(chunk)
    local data=anchor:getModData()[checkpointKey]
    assert(data.state=="pending" and data.story==name)
    return chunk,anchor,data
end
local chunk,anchor,data=selectStory(1300,0,"BiohazardCrash")
missing="1299:100:0"
local before=sceneCalls.vehicles
tick()
assert(data.state=="pending" and sceneCalls.vehicles==before)
missing=nil
-- Simulate saving/reloading only the plain-data checkpoint on an existing chunk.
local restored={}
for key,value in pairs(data) do assert(type(value)~="function" and type(value)~="userdata"); restored[key]=value end
anchor:getModData()[checkpointKey]=restored
chunk.isNewChunk=function() return false end
Events.LoadChunk.fire(chunk)
tick()
assert(restored.state=="done" and sceneCalls.vehicles>before)
before=sceneCalls.vehicles
Events.LoadChunk.fire(chunk); tick()
assert(sceneCalls.vehicles==before, "saved completed story must not spawn twice")
for _, selection in ipairs({{1400,6,"MilitaryBlockade"},{1500,26,"MilitaryBlockpost"},
                           {1600,36,"MilitaryConvoy"}}) do
    local c,a,d=selectStory(selection[1],selection[2],selection[3])
    tick()
    assert(d.state=="done",selection[3]..": "..tostring(d.state).." "..tostring(errors[#errors]))
end
assert(sceneCalls.trailers>0 and sceneCalls.objects>0 and sceneCalls.floors>0
       and sceneCalls.zombies>0 and sceneCalls.corpses>0 and sceneCalls.loot>0)
local blocked,bAnchor,bData=selectStory(1700,0,"BiohazardCrash")
occupied="1700:100:0"
tick()
assert(bData.state=="blocked")
occupied=nil
local disabled,dAnchor,dData=selectStory(1800,0,"BiohazardCrash")
SandboxVars.VMZ.RoadStories=false
before=sceneCalls.vehicles; tick()
assert(dData.state=="pending" and sceneCalls.vehicles==before)
SandboxVars.VMZ.RoadStories=true; tick()
assert(dData.state=="done")
local failed,fAnchor,fData=selectStory(1900,0,"BiohazardCrash")
failVehicle=true; tick()
assert(fData.state=="failed")
failVehicle=false; before=sceneCalls.vehicles
Events.LoadChunk.fire(failed); tick()
assert(sceneCalls.vehicles==before,"failed native scene must not retry partial work")
client=true; before=sceneCalls.vehicles
scene:addVehicle("MockCar",0,0,0,nil,false)
assert(sceneCalls.vehicles==before)
