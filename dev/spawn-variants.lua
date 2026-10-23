-- Explicit imported-variant fixtures; never counted as natural road density.
assert(not isClient())
if OnlyKI5VariantFixture and #OnlyKI5VariantFixture==4 then return OnlyKI5VariantFixture end
assert(not OnlyKI5VariantFixture or #OnlyKI5VariantFixture==0,'Partial fixture needs explicit cleanup')
OnlyKI5VariantFixture={}
local p=isServer() and getOnlinePlayers():get(0) or getPlayer()
local native=RandomizedWorldBase.new()
for i,name in ipairs({'Base.67commandoRanger','Base.86chevyM1010ambulance','Base.76chevyK10fossoil','Base.93fordF350fossoil'}) do
 local v
 for dx=-24,24,8 do
  for dy=-24,24,12 do
   local x,y=math.floor(p:getX())+dx+.5,math.floor(p:getY())+dy+.5
   local s=getCell():getGridSquare(math.floor(x),math.floor(y),0)
   local reserved=false
   for _,prior in ipairs(OnlyKI5VariantFixture) do
    if math.abs(prior.x-x)<7 and math.abs(prior.y-y)<10 then reserved=true end
   end
   if not reserved and s and s:getZone() and s:getZone():getType()=='Nav'
      and not s:getBuilding() and not s:isVehicleIntersecting() and s:isFree(false) then
    v=native:addVehicle(s:getZone(),x,y,0,0,'junkyard',name,nil,nil)
    if v then break end
   end
  end
  if v then break end
 end
 assert(v,'No valid free native variant footprint')
 v:repair()
 local overlay=ISCarMechanicsOverlay and ISCarMechanicsOverlay.CarList[name]
 local armor=DAMN and DAMN.Armor and DAMN.Armor.byVehicleScript[name]~=nil
 OnlyKI5VariantFixture[#OnlyKI5VariantFixture+1]={id=v:getId(),script=v:getScriptName(),skin=v:getSkinIndex(),x=v:getX(),y=v:getY(),parts=v:getPartCount(),armor=armor,overlay=overlay}
end
return OnlyKI5VariantFixture
