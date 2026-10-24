-- Executes real VMZ registration/distribution modules plus the final authored
-- callbacks and authored native adapters. Game services are mocked; this is not native map proof.
function isClient() return false end
function print(_) end
function ZombRand(n) return 0 end
function ZombRandFloat(a, b) return a end
local function event()
    local e = { callbacks = {} }
    function e.Add(f) e.callbacks[#e.callbacks + 1] = f end
    function e.fire(...) for _, f in ipairs(e.callbacks) do f(...) end end
    return e
end
Events = { OnLoadMapZones = event(), OnLoadedMapZones = event(),
    OnInitGlobalModData = event(), OnSpawnVehicleStart = event(), OnSpawnVehicleEnd = event() }
-- Full vehicle reference fleet, with unrelated map integrations disabled.
function getActivatedMods() return { contains = function(_,id) return string.match(id,'^%d')~=nil or id=='KI5campers' or id=='KI5trailers' end } end
local registrations = {}
function getLotDirectories() return { size = function() return 0 end } end
function getWorld() return { getMetaGrid = function() return nil end, registerVehiclesZone = function(_, name, kind, x, y)
    registrations[#registrations + 1] = {name = name, kind = kind, x = x, y = y}
    return true
end } end
SandboxVars = { VMZ = { SpawnRate = 50, VehiCond = 50, PartDamage = 30,
    KeySpawn = 20, SpecCar = false } }
local C = require "OnlyKI5VehicleSpawnLiveryOverhaul_Catalog"
local trucks = {}
for _, name in ipairs(C.groups.militaryTruck) do trucks[name] = true end
ScriptManager = { instance = {} }
function ScriptManager.instance:getVehicle(name)
    return {
        getMass = function() return trucks[name] and 9000 or 2000 end,
        getEngineForce = function() return 4000 end,
        getEngineLoudness = function() return 50 end,
        getOffroadEfficiency = function() return 1 end,
    }
end
ProfessionVehicles = {}
function addVehicleDebug(name) return name end
VehicleZoneDistribution = {
    military = { vehicles = {
        ["Base.92amgeneralM998"] = { spawnChance = 10 },
        ["Base.78amgeneralM35A2"] = { spawnChance = 10 },
    } },
    parkingstall = { vehicles = {
        ["Base.92amgeneralM998"] = { spawnChance = 10 },
        ["Base.fr_je_wrangler_92"] = { spawnChance = 10 },
        ["Base.85chevyCaprice"] = { spawnChance = 80 },
    } },
}
require "OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_Change"
require "OnlyKI5VehicleSpawnLiveryOverhaul_Runtime"
local callbacks = #Events.OnLoadMapZones.callbacks
require "OnlyKI5VehicleSpawnLiveryOverhaul_VMZNEW_RegisterZones"
assert(#Events.OnLoadMapZones.callbacks == callbacks, "registration module must load once")
Events.OnLoadMapZones.fire()
Events.OnLoadedMapZones.fire()
assert(#registrations > 0, "integrated vanilla records reach native zone registration")
local registeredCount = #registrations
assert(not VehicleZoneDistribution.parkingstall.vehicles["Base.fr_je_wrangler_92"])
local light = VehicleZoneDistribution.military_vehicle_light.vehicles
local total = 0
for _, props in pairs(light) do total = total + props.spawnChance end
assert(total > 0)
assert(math.abs(light["Base.92amgeneralM998"].spawnChance / total - 0.95) < 0.00001,
       "final Only KI5 policy must run after actual VMZ split")
local heavy = VehicleZoneDistribution.military_vehicle_heavy.vehicles
assert(heavy["Base.78amgeneralM35A2"], "truck pool survives integrated VMZ")
Events.OnLoadedMapZones.fire()
assert(#registrations == registeredCount, "finalization must not re-register native zones")
