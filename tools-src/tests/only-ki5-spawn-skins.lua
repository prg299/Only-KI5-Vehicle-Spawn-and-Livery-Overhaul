local callbacks = {}
Events = {OnSpawnVehicleStart={Add=function(fn) callbacks[#callbacks+1]=fn end}}
isClient = function() return ONLY_KI5_TEST_TRAFFIC_SHAPE == 'client' end
local S = require 'OnlyKI5VehicleSpawnLiveryOverhaul_SpawnSkins'
local roll, calls = 0, 0
local function empty(t) for _ in pairs(t) do return false end;return true end
ZombRand = function(n) assert(n==100);calls=calls+1;return roll end
local function vehicle(count, created, name)
    local v={skin=-1,data={}}
    function v:isCreated() return created end
    function v:getScriptName() return name or 'Base.92amgeneralM998' end
    function v:getModData() return self.data end
    function v:getScript() return {getFullName=function() return self:getScriptName() end,getSkinCount=function() return count end} end
    function v:setSkinIndex(n) assert(n>=0 and n<count);self.skin=n end
    return v
end
local old=vehicle(8,true);S.routeNewVehicle(old)
local control=vehicle(8,false,'Base.92amgeneralM998SWAT');S.routeNewVehicle(control)
local burnt=vehicle(8,false,'Base.92amgeneralM998Burnt');S.routeNewVehicle(burnt)
local unknown=vehicle(9,false);S.routeNewVehicle(unknown)
assert(calls==0 and old.skin==-1 and empty(old.data))
assert(control.skin==-1 and burnt.skin==-1 and unknown.skin==-1)
local counts={}
for n=0,99 do
    roll=n
    local v=vehicle(8,false)
    S.routeNewVehicle(v)
    if isClient() then
        assert(v.skin==-1 and empty(v.data) and calls==0)
    else
        counts[v.skin]=(counts[v.skin] or 0)+1
        local previous,c=calls,v.skin
        roll=(n+50)%100;S.routeNewVehicle(v)
        assert(calls==previous and v.skin==c,'New-vehicle callback rerolled a decided livery')
        v.isCreated=function() return true end;S.routeNewVehicle(v)
        assert(calls==previous and v.skin==c,'Saved-vehicle callback changed a livery')
    end
end
if not isClient() then
    assert(counts[3]==1 and counts[4]==4,'Special liveries are not rare')
    assert(counts[0]+counts[1]+counts[2]+counts[5]+counts[6]+counts[7]==95)
    local six={}
    for n=0,99 do roll=n;local v=vehicle(6,false);S.routeNewVehicle(v);six[v.skin]=(six[v.skin] or 0)+1 end
    for i=0,5 do assert(six[i] and six[i]>0,'Six-skin profile lost an ordinary livery') end
end
