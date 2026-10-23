-- Read-only probe after an owned saved scene's footprint has streamed in.
local x,y=OnlyKI5SceneX,OnlyKI5SceneY
local square=assert(getCell():getGridSquare(math.floor(x),math.floor(y),0),'Scene not loaded')
local anchor=square:getChunk():getGridSquare(0,0,0)
local result={checkpoint=anchor:getModData().OnlyKI5VehicleSpawnLiveryOverhaul_RoadStory,vehicles={},objects=0}
local iterator=getCell():getVehicles():iterator()
while iterator:hasNext() do
 local v=iterator:next()
 if math.abs(v:getX()-x)<35 and math.abs(v:getY()-y)<45 then
  result.vehicles[#result.vehicles+1]={sqlId=v:getSqlId(),script=v:getScriptName(),skin=v:getSkinIndex(),x=v:getX(),y=v:getY()}
 end
end
for dx=-20,20 do for dy=-30,30 do
 local s=getCell():getGridSquare(math.floor(x)+dx,math.floor(y)+dy,0)
 if s then result.objects=result.objects+s:getObjects():size() end
end end
return result
