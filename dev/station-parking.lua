-- Insert a native emergency ParkingStall in the disposable world, while the
-- underlying square remains TownZone. This reproduces the actual map schema.
if OnlyKI5StationFixture then return OnlyKI5StationFixture end
local p=getOnlinePlayers():get(0)
local native=RandomizedWorldBase.new()
for dx=-20,20,4 do
 for dy=-20,20,4 do
  local x,y=math.floor(p:getX())+dx,math.floor(p:getY())+dy
  local square=getCell():getGridSquare(x,y,0)
  if square and not square:getBuilding() and not square:isWaterSquare() and square:isFree(false)
     and not square:isVehicleIntersecting() and not getVehicleZoneAt(x,y,0) then
   local zone=getWorld():registerVehiclesZone('policegarage','ParkingStall',x,y,0,4,7,{Direction='N'})
   local actual=getVehicleZoneAt(x+1,y+1,0)
   if actual and actual:getName()=='policegarage' then
    local v=native:addVehicle(square:getZone(),x+1.5,y+1.5,0,0,'police','Base.92fordCVPILouisville',nil,nil)
    if v then
     OnlyKI5StationFixture={id=v:getId(),script=v:getScriptName(),x=v:getX(),y=v:getY(),
       vehicleZone=actual:getName(),metaType=square:getZone() and square:getZone():getType(),
       decision=v:getModData()['OnlyKI5VehicleSpawnLiveryOverhaul.PoliceLightbarSpawnV1'],
       lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode()}
     return OnlyKI5StationFixture
    end
   end
  end
 end
end
return {failure='No free native emergency-stall fixture location'}
