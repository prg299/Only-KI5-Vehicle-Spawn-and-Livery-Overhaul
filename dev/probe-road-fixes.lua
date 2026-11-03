-- Explicit construction and checkpoint fixtures, separate from natural samples.
assert(not isClient())
local Scene=require 'OnlyKI5VehicleSpawnLiveryOverhaul_RoadScene'
local Stories=require 'OnlyKI5VehicleSpawnLiveryOverhaul_RoadStories'
local Catalog=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local player=isServer() and getOnlinePlayers():get(0) or getPlayer()
assert(player and not player:isDead())
local savedMultiplier=SandboxVars.VMZ.RoadStoriesMultiplier
local rates={}
for _,m in ipairs({0,.1,1}) do
    SandboxVars.VMZ.RoadStoriesMultiplier=m
    rates[tostring(m)]=Stories.getStatus().probability
end
SandboxVars.VMZ.RoadStoriesMultiplier=savedMultiplier
assert(rates['0']==0 and rates['1']>0 and math.abs(rates['0.1']/rates['1']-.1)<.000001)
local anchor=player:getSquare():getChunk():getGridSquare(0,0,0)
local key='OnlyKI5VehicleSpawnLiveryOverhaul_RoadStory'
local previous=anchor:getModData()[key]
local function checkpoint(version)
    return {version=version,state='pending',story='MilitaryConvoy',x=player:getX(),y=player:getY(),
        z=0,width=20,direction='N'}
end
local count=getCell():getVehicles():size()
local close=checkpoint(2);anchor:getModData()[key]=close
Stories.onLoadChunk(anchor:getChunk());Stories.processPending()
assert(close.state=='skipped-player' and count==getCell():getVehicles():size(),'Native player proximity guard failed')
local legacy=checkpoint(1);anchor:getModData()[key]=legacy
Stories.onLoadChunk(anchor:getChunk());Stories.processPending()
assert(legacy.state=='retired' and count==getCell():getVehicles():size(),'Legacy backlog was not retired')
anchor:getModData()[key]=previous
local rejected={}
for _,name in ipairs({'Base.TrailerM127stake','Base.TrailerM128van','Base.TrailerM129van','Base.TrailerM747lowbed','Base.TrailerM967tanker'}) do
    assert(not Scene.isTrailerCompatible('Base.78amgeneralM35A2',name),name..' accepted on M35')
    assert(not Scene.isTrailerCompatible('Base.82oshkoshM911',name),name..' accepted by rear-hitch-only helper')
    rejected[#rejected+1]=name
end
assert(Scene.isTrailerCompatible('Base.78amgeneralM35A2','Base.TrailerM101A3cargo'))
local function free(x,y,px,py)
    for dx=-px,px do for dy=-py,py do
        local s=getCell():getGridSquare(x+dx,y+dy,0)
        if not s or s:getBuilding() or s:isWaterSquare() or s:isVehicleIntersecting() then return false end
    end end
    return true
end
local function spot(px,py)
    for dx=-36,36,12 do for dy=-36,36,12 do
        local x,y=math.floor(player:getX())+dx,math.floor(player:getY())+dy
        if free(x,y,px,py) then return x,y end
    end end
end
local x,y=spot(5,12);assert(x,'No free loaded truck/trailer footprint')
local sq=getCell():getGridSquare(x,y,0)
local scene=setmetatable({spawnPoint={x=x+.5,y=y+.5,z=0},zone=sq:getZone(),direction=IsoDirections.N},{__index=Scene})
local truck=assert(scene:addVehicle('Base.78amgeneralM35A2',0,0,0,nil,false))
assert(truck:isCreated() and truck:getPartCount()>0)
local beforeSemi=getCell():getVehicles():size()
assert(not scene:addTrailer('Base.TrailerM127stake',truck,7))
assert(getCell():getVehicles():size()==beforeSemi,'Rejected semi was created anyway')
local trailer=assert(scene:addTrailer('Base.TrailerM101A3cargo',truck,3),'Compatible drawbar trailer was not constructed')
assert(trailer:isCreated() and trailer:getPartCount()>0)
assert(truck:getVehicleTowing()==trailer and trailer:getVehicleTowedBy()==truck,'Native towing relationship missing')
local native=RandomizedWorldBase.new()
local sources={}
for _,source in ipairs({'Base.PickUpVanMccoy','Base.PickUpTruckMccoy','Base.VanMccoy','Base.CarNormal','Base.SmallCar'}) do
    local ax,ay=spot(4,5);assert(ax,'No free alias fixture footprint')
    local square=getCell():getGridSquare(ax,ay,0)
    local v=assert(native:addVehicle(square:getZone(),ax+.5,ay+.5,0,0,'parkingstall',source,nil,nil))
    assert(v:isCreated() and v:getScriptName()~=source and Catalog.scriptProviders[v:getScriptName()],source..' leaked vanilla')
    sources[#sources+1]={source=source,script=v:getScriptName(),id=v:getId(),skin=v:getSkinIndex()}
end
local function state(v)
    return {id=v:getId(),script=v:getScriptName(),x=v:getX(),y=v:getY(),z=v:getZ(),parts=v:getPartCount(),speed=v:getCurrentSpeedKmHour()}
end
OnlyKI5RoadPhysicsIds={truck:getId(),trailer:getId()}
return {rates=rates,status=Stories.getStatus(),nearPlayer=close.state,legacy=legacy.state,rejectedSemis=rejected,
    aliases=sources,physics={state(truck),state(trailer)},explicitConstruction=true}
