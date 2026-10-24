function isClient() return false end
-- Legacy policy scenarios also verify that unchecking the new option restores
-- custom civilian selection. Default-on suppression has its own whole-pool test.
local configured=tonumber(ONLY_KI5_TEST_TRAFFIC_SHAPE)
SandboxVars={OnlyKI5={CustomCivilianChance=100,HumveeSpawnChance=configured,AMGeneralTruckChance=ONLY_KI5_TEST_TRUCK_CHANCE}}
local expectedHumvee=(configured or 95)/100
local expectedTruck=(ONLY_KI5_TEST_TRUCK_CHANCE or 75)/100
function ZombRand(n) return 0 end
function ZombRandFloat(a, b) return a end
local messages = {}
function print(message) messages[#messages + 1] = message end
local function event()
    local e = { callbacks = {} }
    function e.Add(f) e.callbacks[#e.callbacks + 1] = f end
    function e.Remove(f) for i = #e.callbacks, 1, -1 do if e.callbacks[i] == f then table.remove(e.callbacks, i) end end end
    function e.fire(...) for _, f in ipairs(e.callbacks) do f(...) end end
    return e
end
Events = { OnInitGlobalModData = event(), OnLoadMapZones = event(), OnLoadedMapZones = event(), OnSpawnVehicleStart = event() }
function addVehicleDebug(name, direction, skin, square) return name, direction, skin, square end
ProfessionVehicles = {}
-- These scenarios isolate final policy from upstream VMZ's callbacks. The
-- integrated-content scenario separately executes both production modules.
loaded["OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_VehicleZoneDistribution"] = true
loaded["OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_RegisterZones"] = true
local C = require "OnlyKI5VehicleSpawnLiveryOverhaul_Catalog"
local A = require "OnlyKI5VehicleSpawnLiveryOverhaul_SpawnAliases"
local trucks = {}
for _, s in ipairs(C.groups.militaryTruck) do trucks[s] = true end
ScriptManager = { instance = {} }
function ScriptManager.instance:getVehicle(name)
    return { getMass = function() return trucks[name] and 8000 or 2000 end,
        getEngineForce = function() return 4000 end, getEngineLoudness = function() return 50 end,
        getOffroadEfficiency = function() return 1 end }
end
VehicleZoneDistribution = {
    farm = { vehicles = { ["Base.Trailer_Horsebox"] = { index = 8, spawnChance = 50 } } },
    modded_test = { vehicles = { ["Base.VanRadioJJ"] = { index = 7, spawnChance = 20 }, ["Base.TrailerCover"] = { index = 3, spawnChance = 10 } } },
    trafficjamn = { vehicles = { ["Base.87chevySuburbanCUCV"] = { spawnChance = 10 }, ["Base.85chevyCaprice"] = { spawnChance = 100 } } },
    trafficjams = { vehicles = { ["Base.87chevySuburbanCUCV"] = { spawnChance = 10 }, ["Base.78amgeneralM35A2"] = { spawnChance = 20 }, ["Base.85chevyCaprice"] = { spawnChance = 100 } } },
    parkingstall = { vehicles = { ["Base.85chevyCaprice"] = { spawnChance = 100 },
        ["Base.fr_je_wrangler_92"] = { spawnChance = 20 } } },
    military = { vehicles = { ["Base.92amgeneralM998"] = { spawnChance = 10 }, ["Base.78amgeneralM35A2"] = { spawnChance = 10 } } },
    military_vehicle_light = { vehicles = {} }, military_vehicle_heavy = { vehicles = {} },
}
-- Lua table traversal has no ordering contract. Test both relative orders of
-- WayMoreCars' modified_trfjm alias and the ordinary trafficjam* names, as well
-- as the installed Kahlua implementation's native order.
local originalPairs = pairs
function pairs(t)
    if t ~= VehicleZoneDistribution or ONLY_KI5_TEST_ZONE_ORDER == "native" then return originalPairs(t) end
    local keys = {}
    for key in originalPairs(t) do keys[#keys + 1] = key end
    table.sort(keys, function(a, b)
        if ONLY_KI5_TEST_ZONE_ORDER == "descending" then return a > b end
        return a < b
    end)
    local index = 0
    return function()
        index = index + 1
        local key = keys[index]
        if key then return key, t[key] end
    end
end
require "OnlyKI5VehicleSpawnLiveryOverhaul_Runtime"
require "OnlyKI5VehicleSpawnLiveryOverhaul_PoliceSpawnRouting"
-- VMZ clears all military source entries out of ordinary pools.
VehicleZoneDistribution.trafficjamn.vehicles["Base.87chevySuburbanCUCV"] = nil
VehicleZoneDistribution.trafficjams.vehicles["Base.87chevySuburbanCUCV"] = nil
VehicleZoneDistribution.trafficjams.vehicles["Base.78amgeneralM35A2"] = nil
-- Match WayMoreCars SpecialZoneDefinitions: after VMZ clears military inputs,
-- all four traffic directions and the new modified_trfjm pool share one table.
local trafficMixedVehicles = VehicleZoneDistribution.trafficjams.vehicles
VehicleZoneDistribution.trafficjamn.vehicles = trafficMixedVehicles
VehicleZoneDistribution.trafficjame = { vehicles = trafficMixedVehicles }
VehicleZoneDistribution.trafficjamw = { vehicles = trafficMixedVehicles }
VehicleZoneDistribution.modified_trfjm = { vehicles = trafficMixedVehicles }
if ONLY_KI5_TEST_TRAFFIC_SHAPE == "copied" then
    -- Also cover a downstream mod detaching the highway table after VMZ has
    -- cleared it: the new pool still inherits the authored trafficjams budget.
    local copy = {}
    for name, properties in pairs(trafficMixedVehicles) do
        copy[name] = {}
        for key, value in pairs(properties) do copy[name][key] = value end
    end
    VehicleZoneDistribution.modified_trfjm.vehicles = copy
end
Events.OnLoadMapZones.fire()
-- Simulate a later mod reintroducing a vanilla trailer, then finalization.
VehicleZoneDistribution.modded_test.vehicles["Base.Trailer_Livestock"] = { index = 9, spawnChance = 12 }
Events.OnLoadedMapZones.fire()
assert(not VehicleZoneDistribution.parkingstall.vehicles["Base.fr_je_wrangler_92"], "integrated duplicate suppression")
for _, zone in pairs(VehicleZoneDistribution) do
    if zone.vehicles then for source in pairs(A.targets) do assert(not zone.vehicles[source], source) end end
end
assert(VehicleZoneDistribution.farm.vehicles["Base.TrailerKI5livestock"].spawnChance == 50)
assert(VehicleZoneDistribution.farm.vehicles["Base.TrailerKI5livestock"].index == -1)
assert(ProfessionVehicles.Trailer_Horsebox.General[1] == "Base.TrailerKI5livestock")
for source, target in pairs(A.targets) do
    assert(addVehicleDebug(source) == target, source)
    assert(A.resolve(string.sub(source, 6)) == target)
end
local script, direction, skin, square = addVehicleDebug("Base.TrailerAdvert", "south", 8, "original-square")
assert(script == "Base.TrailerKI5cargoMedium" and direction == "south" and skin == -1 and square == "original-square")
local function share(zone, names, preferred)
    local total, part = 0, 0
    for _, name in ipairs(names) do
        local p = zone.vehicles[name]
        if p then total = total + p.spawnChance; if name == preferred then part = part + p.spawnChance end end
    end
    assert(total > 0, "military candidates missing")
    return part / total
end
assert(math.abs(share(VehicleZoneDistribution.trafficjamn, C.groups.militaryCar, "Base.92amgeneralM998") - expectedHumvee) < 0.00001)
for _, zoneName in ipairs({ "modified_trfjm", "trafficjamn", "trafficjams", "trafficjame", "trafficjamw" }) do
    local zone = VehicleZoneDistribution[zoneName]
    assert(math.abs(share(zone, C.groups.militaryCar, "Base.92amgeneralM998") - expectedHumvee) < 0.00001, zoneName)
    local militaryTotal = 0
    for _, group in ipairs({ C.groups.militaryCar, C.groups.militaryTruck }) do
        for _, name in ipairs(group) do militaryTotal = militaryTotal + ((zone.vehicles[name] or {}).spawnChance or 0) end
    end
    assert(militaryTotal > 0 and militaryTotal <= 100 * 0.0025 + 0.000001, "highway military density cap")
    assert(zone.vehicles["Base.85chevyCaprice"].spawnChance == 100, "civilian control changed")
end
assert(not VehicleZoneDistribution.parkingstall.vehicles["Base.92amgeneralM998"], "military leaked into civilian parking")
assert(math.abs(share(VehicleZoneDistribution.military_vehicle_light, C.groups.militaryCar, "Base.92amgeneralM998") - expectedHumvee) < 0.00001)
local function humveeWeight(zone) return (zone.vehicles['Base.92amgeneralM998'] or {}).spawnChance or 0 end
local before = humveeWeight(VehicleZoneDistribution.trafficjamn)
local highwayBefore = humveeWeight(VehicleZoneDistribution.modified_trfjm)
local truckTotal, amTotal, carTotal = 0, 0, 0
for _, name in ipairs(C.groups.militaryTruck) do
    local chance = (VehicleZoneDistribution.modified_trfjm.vehicles[name] or {}).spawnChance or 0
    truckTotal = truckTotal + chance
    if string.find(name, "amgeneral", 1, true) then amTotal = amTotal + chance end
end
for _, name in ipairs(C.groups.militaryCar) do
    carTotal = carTotal + ((VehicleZoneDistribution.modified_trfjm.vehicles[name] or {}).spawnChance or 0)
end
assert(math.abs(amTotal / truckTotal - expectedTruck) < 0.00001, "highway AM General ratio")
assert(math.abs(carTotal / truckTotal - 0.5) < 0.00001, "shared jam lost its south-source car/truck budget")
local highwayTelemetry = false
for _, message in ipairs(messages) do
    if string.find(message, "loaded-zones", 1, true)
        and string.find(message, string.format("highwayHumveeShare=%.1f%%",expectedHumvee*100), 1, true)
        and string.find(message, string.format("highwayAMGeneralShare=%.1f%%",expectedTruck*100), 1, true) then highwayTelemetry = true end
end
local totalTruck,preferredTruck=0,0
for _,name in ipairs(C.groups.militaryTruck) do
 local w=C.weight('militaryTruck',name)
 totalTruck=totalTruck+w
 if string.find(name,'amgeneral',1,true) then preferredTruck=preferredTruck+w end
end
assert(math.abs(preferredTruck/totalTruck-expectedTruck)<.00001,'Catalog truck chance')
local truckList=C.weightedCopy('militaryTruck');local countTruck=0
for _,name in ipairs(truckList) do if string.find(name,'amgeneral',1,true) then countTruck=countTruck+1 end end
assert(#truckList==1000 and math.abs(countTruck/#truckList-expectedTruck)<.00001,'Profession truck chance')
assert(highwayTelemetry, "missing measured highway telemetry")
Events.OnLoadedMapZones.fire()
assert(math.abs(humveeWeight(VehicleZoneDistribution.trafficjamn) - before) < 0.00001, "finalization inflated military density")
assert(math.abs(humveeWeight(VehicleZoneDistribution.modified_trfjm) - highwayBefore) < 0.00001, "finalization inflated highway density")
for _,wrecked in ipairs({false,true}) do
 local group=wrecked and C.wreckedGroups.militaryCar or C.groups.militaryCar
 local total,preferred=0,0
 for _,name in ipairs(group) do
  local w=wrecked and C.wreckedWeight('militaryCar',name) or C.weight('militaryCar',name)
  total=total+w
  if name==(wrecked and 'Base.92amgeneralM998Burnt' or 'Base.92amgeneralM998') then preferred=preferred+w end
 end
 assert(math.abs(preferred/total-expectedHumvee)<.00001,'Live/burnt catalog ignores sandbox chance')
 local list=wrecked and C.wreckedWeightedCopy('militaryCar',1000) or C.weightedCopy('militaryCar')
 local count=0;for _,name in ipairs(list) do if string.find(name,'92amgeneralM998',1,true) then count=count+1 end end
 assert(#list==1000 and math.abs(count/#list-expectedHumvee)<.00001,'Profession slots ignore sandbox chance')
end
local function vehicle(name, created)
    local v = { name = name, changes = 0 }
    function v:isCreated() return created end
    function v:getScript() return { getFullName = function() return self.name end } end
    function v:setScriptName(s) self.name = s; self.changes = self.changes + 1 end
    function v:scriptReloaded() end
    function v:setSkinIndex(n) self.skin = n end
    function v:getSquare() return nil end
    return v
end
local new = vehicle("Base.Trailer_Horsebox", false)
Events.OnSpawnVehicleStart.fire(new)
assert(new.name == "Base.TrailerKI5livestock" and new.skin == 0)
Events.OnSpawnVehicleStart.fire(new)
assert(new.changes == 1, "guard must be idempotent")
local existing = vehicle("Base.Trailer_Horsebox", true)
Events.OnSpawnVehicleStart.fire(existing)
assert(existing.changes == 0, "existing saved vehicles must not change")
local control = vehicle("Base.TrailerKI5cargoSmall", false)
Events.OnSpawnVehicleStart.fire(control)
assert(control.changes == 0, "unrelated KI5 input must not change")
