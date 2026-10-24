-- Native vehicle construction fixture, with real production spawn callbacks.
-- These explicit test cars are excluded from natural traffic sample counts.
assert(not isClient())
if OnlyKI5PoliceFixture and #OnlyKI5PoliceFixture>=20 then return {alreadyCreated=true,count=#OnlyKI5PoliceFixture,vehicles=OnlyKI5PoliceFixture} end
OnlyKI5PoliceFixture=OnlyKI5PoliceFixture or {}
local p=isServer() and getOnlinePlayers():get(0) or getPlayer()
local native=RandomizedWorldBase.new()
for dx=-32,32,8 do
    for dy=-36,36,12 do
        local x,y=math.floor(p:getX())+dx+.5,math.floor(p:getY())+dy+.5
        local square=getCell():getGridSquare(math.floor(x),math.floor(y),0)
        if square and not square:getBuilding() and not square:isWaterSquare() and square:isFree(false)
           and not square:isVehicleIntersecting() then
            local v=native:addVehicle(square:getZone(),x,y,0,0,'police','Base.92fordCVPILouisville',nil,nil)
            if v and v:isCreated() and v:getId()>=0 and v:getSkinIndex()>=0 then
                local part=v:getPartById('lightbar')
                OnlyKI5PoliceFixture[#OnlyKI5PoliceFixture+1]={id=v:getId(),script=v:getScriptName(),skin=v:getSkinIndex(),
                    x=v:getX(),y=v:getY(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode(),
                    decision=v:getModData()['OnlyKI5VehicleSpawnLiveryOverhaul.PoliceLightbarSpawnV1'],
                    hasLightbar=v:hasLightbar(),condition=part and part:getCondition()}
            end
        end
        if #OnlyKI5PoliceFixture>=20 then break end
    end
    if #OnlyKI5PoliceFixture>=20 then break end
end
return {vehicles=OnlyKI5PoliceFixture,count=#OnlyKI5PoliceFixture}
