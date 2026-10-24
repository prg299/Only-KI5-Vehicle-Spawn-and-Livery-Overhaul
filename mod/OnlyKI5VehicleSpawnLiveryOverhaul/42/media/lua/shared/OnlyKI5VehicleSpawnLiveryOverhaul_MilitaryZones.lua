-- Authored native zone adapter for the integrated military data. MIT.
-- Retains upstream VMZ sandbox/data contracts without loading its library.
local Support = require "OnlyKI5VehicleSpawnLiveryOverhaul_WorldSupport"
local Zones = {}
local changes, registered, overrideCache = {}, {}, {}

-- The native map loader calls reloadLuaFile before consuming its objects table.
-- Chain the existing function and touch only explicitly selected map files.
local function pack(...) return { n = select("#", ...), ... } end
local previousReload = reloadLuaFile
if previousReload then
    reloadLuaFile = function(path, ...)
        local results = pack(previousReload(path, ...))
        local edits = changes[path]
        if edits and type(objects) == "table" then
            for index = #objects, 1, -1 do
                local object = objects[index]
                if object.type == "ParkingStall" then
                    local key = table.concat({object.x, object.y, object.z}, ",")
                    local edit = edits[key]
                    if edit == "remove" then
                        table.remove(objects, index)
                    elseif type(edit) == "table" then
                        for _, field in ipairs({"name", "x", "y", "z", "width", "height"}) do
                            if edit[field] ~= nil then object[field] = edit[field] end
                        end
                        if edit.properties then
                            object.properties = object.properties or {}
                            for field, value in pairs(edit.properties) do
                                object.properties[field] = value
                            end
                        end
                    end
                end
            end
        end
        return unpack(results, 1, results.n)
    end
end

function Zones.change(folder, edits)
    local file = "media/maps/" .. folder .. "/objects.lua"
    changes[file] = changes[file] or {}
    for key, value in pairs(edits) do changes[file][key] = value end
end

local function replacedCell(x, y)
    local key = table.concat({math.floor(x / 256), math.floor(y / 256),
                              math.floor(x / 300), math.floor(y / 300)}, ":")
    if overrideCache[key] ~= nil then return overrideCache[key] end
    local directories = getLotDirectories()
    for index = 0, directories:size() - 1 do
        local folder = directories:get(index)
        if folder ~= "Muldraugh, KY" then
            local base = "media/maps/" .. folder .. "/"
            -- Both native 256-cell and legacy 300-cell map headers occur in B42 maps.
            for _, size in ipairs({256, 300}) do
                local file = base .. math.floor(x / size) .. "_" .. math.floor(y / size) .. ".lotheader"
                if fileExists(file) then
                    overrideCache[key] = true
                    return true
                end
            end
        end
    end
    overrideCache[key] = false
    return false
end

local function parkingRecords(record)
    -- The two 25-tile secret-base rows otherwise use native three-tile stall
    -- steps. A wide M62/APC pair can overlap after the parking jitter. Keep
    -- four separated single stalls in each original row and fix their facing.
    if record.name=='military_vehicle' and record.y==12447 and record.z==0
        and (record.x==5586 or record.x==5599) and record.width==5 and record.height==25 then
        local result={}
        for offset=0,18,6 do
            local properties={}
            for key,value in pairs(record.properties or {}) do properties[key]=value end
            properties.FaceDirection=true
            result[#result+1]={name=record.name,type=record.type,x=record.x,y=record.y+offset,
                z=record.z,width=5,height=3,properties=properties}
        end
        return result
    end
    return {record}
end

function Zones.register(records, respectMapOverrides)
    local world = getWorld()
    for _, source in ipairs(records) do
      for _, record in ipairs(parkingRecords(source)) do
        if record.type == "ParkingStall" then
            local key = table.concat({record.name, record.x, record.y, record.z,
                                      record.width, record.height}, ":")
            if not registered[key] and not (respectMapOverrides and replacedCell(record.x, record.y)) then
                local zone = world:registerVehiclesZone(record.name, record.type,
                    record.x, record.y, record.z, record.width, record.height, record.properties)
                if zone then registered[key] = true end
            end
        end
      end
    end
end

-- VMZ's input is a military source table. Preserve source/child military pools
-- and explicitly skinned non-military variants of the same underlying script.
function Zones.clearSpawnZones(source, _, respectSkins)
    for name, zone in pairs(VehicleZoneDistribution or {}) do
        if type(zone) == "table" and type(name) == "string" and name ~= "army"
           and name ~= "military" and not string.find(name, "^military_") then
            for script in pairs(source) do
                local entry = zone.vehicles and zone.vehicles[script]
                if entry and (not respectSkins or not entry.skins or entry.index == -1) then
                    zone.vehicles[script] = nil
                end
            end
        end
    end
end

local newVehicles = setmetatable({}, { __mode = "k" })
if Events and Events.OnLoadMapZones then
    Events.OnLoadMapZones.Add(function() registered, overrideCache = {}, {} end)
end
if Events and Events.OnSpawnVehicleStart then
    Events.OnSpawnVehicleStart.Add(function(vehicle)
        if Support.isAuthority() and vehicle and not vehicle:isCreated() then
            newVehicles[vehicle] = true
        end
    end)
end
if Events and Events.OnSpawnVehicleEnd then
    Events.OnSpawnVehicleEnd.Add(function(vehicle)
        if not newVehicles[vehicle] then return end
        newVehicles[vehicle] = nil
        local zone = getVehicleZoneAt(math.floor(vehicle:getX()), math.floor(vehicle:getY()),
                                     math.floor(vehicle:getZ()))
        local name = zone and zone:getName()
        local distribution = name and string.find(name, "^military_") and VehicleZoneDistribution[name]
        local angles = distribution and not distribution.randomAngle and distribution.positionAngles
        if type(angles) == "table" and #angles > 0 then
            local offset = angles[ZombRand(#angles) + 1]
            vehicle:setAngles(vehicle:getAngleX(), vehicle:getAngleY(), vehicle:getAngleZ() + offset)
        end
    end)
end

return Zones
