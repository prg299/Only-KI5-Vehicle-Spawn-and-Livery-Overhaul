-- Production scheduler with a fixed random tape and mocked native world state.
-- Separate worlds use identical inputs/ticks; ordinary time never explains a rate change.
local function event() return {Add=function() end} end
Events={LoadChunk=event(),OnTick=event()}
local clients=false
function isClient() return clients end
function isServer() return true end
function getGameTime() return {getWorldAgeHours=function() return 240 end} end
function getChunkSizeInSquares() return 8 end
IsoDirections={N={},S={},E={},W={}}
for name,direction in pairs(IsoDirections) do setmetatable(direction,{__tostring=function() return name end}) end
local roll,world,ledger,player=0,{}, {},nil
function ZombRand() return 0 end
function ZombRandFloat(a,b) return b==1 and roll or 0 end
ModData={getOrCreate=function(name) ledger[name]=ledger[name] or {};return ledger[name] end}
function getOnlinePlayers() return {size=function() return player and 1 or 0 end,get=function() return player end} end
local function square(x,y)
    local key=x..":"..y
    world[key]=world[key] or {data={}}
    local s=world[key]
    s.getX=function() return x end;s.getY=function() return y end;s.getZ=function() return 0 end
    s.getModData=function() return s.data end;s.getChunk=function() return {} end
    s.isVehicleIntersecting=function() return false end;s.isWaterSquare=function() return false end
    s.getBuilding=function() return nil end;s.getZone=function() return s.zone end
    return s
end
function getCell() return {getGridSquare=function(_,x,y) return square(x,y) end} end
local function chunk(x,isNew)
    local anchor=square(x,100)
    local stamp=0
    anchor.zone={getType=function() return 'Nav' end,getWidth=function() return 20 end,
        getHeight=function() return 1000 end,getX=function() return x-10 end,getY=function() return 0 end,
        getLastActionTimestamp=function() return stamp end,setLastActionTimestamp=function(_,v) stamp=v end,
        haveCons=function() return false end,isRectangle=function() return true end}
    return {getGridSquare=function(_,cx,cy) if cx==0 and cy==0 then return anchor end end,
        isNewChunk=function() return isNew~=false end},anchor
end
local Stories
local spawned=0
local key='OnlyKI5VehicleSpawnLiveryOverhaul_RoadStory'
local function reset(multiplier,frequency)
    world={};ledger={};player=nil;spawned=0
    SandboxVars={VehicleStoryChance=frequency or 3,VMZ={RoadStories=true,RoadStoriesMultiplier=multiplier}}
    loaded['OnlyKI5VehicleSpawnLiveryOverhaul_RoadStories']=nil
    Stories=require 'OnlyKI5VehicleSpawnLiveryOverhaul_RoadStories'
    local definition=Stories:derive('AdmissionFixture')
    definition.chance=10;definition.minZoneWidth=1;definition.minZoneHeight=1
    definition.spawn=function() spawned=spawned+1 end
end
local function sample(multiplier,frequency)
    reset(multiplier,frequency)
    local count=0
    for i=1,20000 do
        roll=(i-.5)/20000
        local c,a=chunk(i*600)
        Stories.onLoadChunk(c)
        if a.data[key] and a.data[key].state=='pending' then count=count+1 end
    end
    return count
end
assert(sample(1)==50,'Default military stories should be a rare subset, not every 40 road chunks')
assert(sample(1)==50,'Unchanged-input control changed')
assert(sample(.1)==5,'0.1 multiplier must give one tenth of the same seeded candidates')
assert(sample(0)==0 and sample(1,1)==0,'Disabled settings admitted a story')
reset(1,7);roll=0
local c,a=chunk(1000);Stories.onLoadChunk(c)
assert(a.data[key].state=='pending')
local near,b=chunk(1100);Stories.onLoadChunk(near)
assert(b.data[key].state=='checked','Adjacent chunks produced clustered roadblocks')
Stories.processPending();assert(a.data[key].state=='done' and spawned==1)
Stories.onLoadChunk(c);Stories.processPending();assert(spawned==1,'Completed checkpoint respawned')
local farther,d=chunk(1700);Stories.onLoadChunk(farther)
assert(d.data[key].state=='pending')
player={isDead=function() return false end,getX=function() return d.data[key].x+20 end,
    getY=function() return d.data[key].y end}
Stories.processPending()
assert(d.data[key].state=='skipped-player' and spawned==1,'Deferred scene appeared around an approaching player')
player=nil;Stories.onLoadChunk(farther);Stories.processPending();assert(spawned==1)
reset(1,7)
local old,legacy=chunk(3000,false)
legacy.data[key]={version=1,state='pending',story='AdmissionFixture',x=3000,y=100,z=0,width=20,direction='N'}
Stories.onLoadChunk(old);Stories.processPending()
assert(legacy.data[key].state=='retired' and spawned==0,'Legacy dense backlog remained armed')
legacy.data[key].state='done';Stories.onLoadChunk(old)
local fresh,blocked=chunk(3100);Stories.onLoadChunk(fresh)
assert(blocked.data[key].state=='checked','Loaded historical scene did not preserve spacing')
reset(1,7)
local disabled,pending=chunk(4000);Stories.onLoadChunk(disabled)
SandboxVars.VMZ.RoadStoriesMultiplier=0;Stories.processPending()
assert(pending.data[key].state=='disabled' and spawned==0,'Zero multiplier still spawned pending scenes')
clients=true;reset(1,7)
local client,cAnchor=chunk(5000);Stories.onLoadChunk(client)
assert(not cAnchor.data[key],'Joined client scheduled authoritative objects')
