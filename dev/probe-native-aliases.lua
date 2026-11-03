-- Separate replacement fixtures, created only after trailer physics sampling.
local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local p=isServer() and getOnlinePlayers():get(0) or getPlayer()
local native=RandomizedWorldBase.new()
local reserved,result={},{}
local function open(x,y)
    for _,point in ipairs(reserved) do if math.abs(point.x-x)<13 and math.abs(point.y-y)<13 then return false end end
    for dx=-5,5 do for dy=-6,6 do
        local sq=getCell():getGridSquare(x+dx,y+dy,0)
        if not sq or sq:getBuilding() or sq:isWaterSquare() or sq:isVehicleIntersecting() or not sq:isFree(false) then return false end
    end end
    return true
end
for _,source in ipairs({'Base.PickUpVanMccoy','Base.PickUpTruckMccoy','Base.VanMccoy','Base.CarNormal','Base.SmallCar'}) do
    local found
    for dx=-42,42,14 do for dy=-42,42,14 do
        local x,y=math.floor(p:getX())+dx,math.floor(p:getY())+dy
        if not found and open(x,y) then found={x=x,y=y} end
    end end
    assert(found,'No free separated alias fixture footprint')
    reserved[#reserved+1]=found
    local sq=getCell():getGridSquare(found.x,found.y,0)
    local v=assert(native:addVehicle(sq:getZone(),found.x+.5,found.y+.5,0,0,'parkingstall',source,nil,nil))
    assert(v:isCreated() and v:getScriptName()~=source and C.scriptProviders[v:getScriptName()],source..' leaked vanilla')
    result[#result+1]={source=source,script=v:getScriptName(),id=v:getId(),x=v:getX(),y=v:getY(),skin=v:getSkinIndex()}
end
return result
