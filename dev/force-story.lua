-- Explicit selected-story fixture. It exercises real deferred construction;
-- it does not prove the ordinary selection probability or day gates.
local name=assert(OnlyKI5ForceStory)
local definition=assert(_G[name])
local p=isServer() and getOnlinePlayers():get(0) or getPlayer()
local Scene=require 'OnlyKI5VehicleSpawnLiveryOverhaul_RoadScene'
local Stories=require 'OnlyKI5VehicleSpawnLiveryOverhaul_RoadStories'
local selected
local failures={}
for dx=-64,64,4 do
    for dy=-48,48,8 do
        local scene=setmetatable({spawnPoint={x=math.floor(p:getX())+dx+.5,y=math.floor(p:getY())+dy+.5,z=0},
            direction=IsoDirections.N,zoneWidth=14},{__index=Scene})
        local square=scene:getSquare(0,0,0)
        local zone=square and square:getZone()
        local free=zone and zone:getType()=='Nav'
        if free then
            for x=-definition.minZoneWidth,definition.minZoneWidth do
                for y=-definition.minZoneHeight,definition.minZoneHeight do
                    local s=scene:getSquare(x,y,0)
                    local reason
                    if not s or not s:getChunk() then reason='unloaded'
                    elseif s:isWaterSquare() then reason='water'
                    elseif s:isVehicleIntersecting() then reason='vehicle'
                    elseif s:getBuilding() then reason='building'
                    elseif not s:isFree(false) then reason='occupied' end
                    if reason then failures[reason]=(failures[reason] or 0)+1;free=false;break end
                end
                if not free then break end
            end
        end
        if free then selected=scene;break end
    end
    if selected then break end
end
if not selected then return {selected=false,reason='No free loaded road footprint',failures=failures} end
local center=selected:getSquare(0,0,0)
local chunk=center:getChunk()
local anchor=chunk:getGridSquare(0,0,0)
local data={version=1,state='pending',story=name,x=selected.spawnPoint.x,y=selected.spawnPoint.y,z=0,width=14,direction='N',acceptanceFixture=true}
anchor:getModData().OnlyKI5VehicleSpawnLiveryOverhaul_RoadStory=data
Stories.onLoadChunk(chunk)
OnlyKI5ForcedStoryResult={data=data,x=data.x,y=data.y,beforeVehicles=getCell():getVehicles():size()}
return {selected=true,name=name,x=data.x,y=data.y,beforeVehicles=OnlyKI5ForcedStoryResult.beforeVehicles}
