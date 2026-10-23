-- Authored scene operations over Project Zomboid's native world-story API. MIT.
local Support = require "OnlyKI5VehicleSpawnLiveryOverhaul_WorldSupport"
local Scene = {}
Scene.__index = Scene

local function contains(values, name)
    for _, value in ipairs(values or {}) do if value == name then return true end end
    return false
end

-- Sorting makes seeded selection independent of Lua hash-table traversal.
function Scene.getVehicleFromZone(zoneName, exclude, weighted, accept)
    local zone = VehicleZoneDistribution and VehicleZoneDistribution[zoneName]
    local entries, total = {}, 0
    for name, entry in pairs(zone and zone.vehicles or {}) do
        local weight = weighted and tonumber(entry.spawnChance) or 1
        if weight and weight > 0 and not contains(exclude, name)
           and ScriptManager.instance:getVehicle(name) and (not accept or accept(name)) then
            entries[#entries + 1] = { name = name, weight = weight }
        end
    end
    table.sort(entries, function(a, b) return a.name < b.name end)
    for _, entry in ipairs(entries) do total = total + entry.weight end
    if total <= 0 then return nil end
    local roll = ZombRandFloat(0, total)
    for _, entry in ipairs(entries) do
        roll = roll - entry.weight
        if roll < 0 then return entry.name end
    end
    return entries[#entries].name
end

function Scene.getAllowedTrailerFromZone(towing, zoneName, exclude, weighted)
    local tractor = towing and ScriptManager.instance:getVehicle(towing)
    if not tractor then return nil end
    return Scene.getVehicleFromZone(zoneName, exclude, weighted, function(name)
        local trailer = ScriptManager.instance:getVehicle(name)
        return not trailer:getPartById("DAMNSemiTrailerHook")
            or tractor:getPartById("DAMNSemiTrailerSaddle") ~= nil
    end)
end

function Scene:calcOffset(x, y)
    local direction = tostring(self.direction)
    local matrix = {
        N = {1, 0, 0, -1}, E = {0, -1, -1, 0},
        S = {-1, 0, 0, 1}, W = {0, 1, 1, 0},
    }
    local m = assert(matrix[direction], "Unsupported story direction")
    return x * m[1] + y * m[2], x * m[3] + y * m[4]
end

function Scene:roundSqCoord(value)
    return math.floor(value)
end

function Scene:getSquare(x, y, z)
    local dx, dy = self:calcOffset(x, y)
    local wx, wy = math.floor(self.spawnPoint.x + dx), math.floor(self.spawnPoint.y + dy)
    local cell = getCell()
    local square = cell:getGridSquare(wx, wy, z)
    if not square and z > self.spawnPoint.z and Support.isAuthority()
       and cell:getGridSquare(wx, wy, self.spawnPoint.z) then
        square = cell:getOrCreateGridSquare(wx, wy, z)
    end
    return square
end

function Scene:native()
    if not self.nativeWorld then self.nativeWorld = RandomizedWorldBase.new() end
    return self.nativeWorld
end

local function skinIndex(skins)
    if type(skins) == "table" then
        return #skins > 0 and skins[ZombRand(#skins) + 1] or nil
    end
    if type(skins) == "number" and skins >= 0 then return skins end
    return nil
end

function Scene:addVehicle(name, x, y, angle, skins, flipped)
    if not Support.isAuthority() or not name or not ScriptManager.instance:getVehicle(name) then return end
    local square = self:getSquare(x, y, self.spawnPoint.z)
    if not square or square:isVehicleIntersecting() then return end
    local dx, dy = self:calcOffset(x, y)
    local heading = self.direction:ToVector():getDirection() + math.rad(angle or 0)
    local wx, wy, wz = self.spawnPoint.x + dx, self.spawnPoint.y + dy, self.spawnPoint.z
    if flipped then
        return self:native():addVehicleFlipped(self.zone, wx, wy, wz, heading,
                                              "military", name, skinIndex(skins), nil)
    end
    return self:native():addVehicle(self.zone, wx, wy, wz, heading,
                                   "military", name, skinIndex(skins), nil)
end

function Scene:addTrailer(name, vehicle, _, skins)
    if not Support.isAuthority() or not name or not vehicle then return end
    local square = vehicle:getSquare()
    if not square then return end
    -- Native placement computes the connection from the actual towing attachments.
    -- Passing the explicit trailer script preserves the integrated fleet policy.
    return self:native():addTrailer(vehicle, self.zone, square:getChunk(),
                                   "military_trailer", nil, name)
end

function Scene:addZombiesOnVehicle(vehicle, count, outfit, femaleChance)
    if Support.isAuthority() and vehicle and count > 0 then
        return self:native():addZombiesOnVehicle(count, outfit, femaleChance, vehicle)
    end
end

function Scene:addDeadBody(x, y, z, outfit, blood, direction, femaleChance, crawlerChance, align)
    if not Support.isAuthority() then return end
    local square = self:getSquare(x, y, z)
    if square and not square:isVehicleIntersecting() then
        return RandomizedWorldBase.createRandomDeadBody(square, direction, align == true,
            blood or 0, crawlerChance or 0, outfit, femaleChance)
    end
end

function Scene:addWorldInventoryItem(x, y, z, name, dx, dy, height)
    if not Support.isAuthority() then return end
    local square = self:getSquare(x, y, z)
    if square then return square:AddWorldInventoryItem(name, dx, dy, height) end
end

function Scene:addBloodSplat(x, y, z, count)
    if not Support.isAuthority() then return end
    local square = self:getSquare(x, y, z)
    if square then addBloodSplat(square, count) end
end

function Scene:addTileObject(x, y, z, object, _, dirt, square)
    if not Support.isAuthority() or not object then return end
    square = square or self:getSquare(x, y, z)
    if not square then return end
    local result = self:native():addTileObject(square, object, dirt == true)
    if isServer and isServer() then object:transmitCompleteItemToClients() end
    return result
end

function Scene:addTileObjectBySpriteName(x, y, z, sprite, clear, dirt)
    if not Support.isAuthority() then return end
    local square = self:getSquare(x, y, z)
    if not square then return end
    return self:addTileObject(x, y, z, IsoObject.getNew(square, sprite, nil, false),
                              clear, dirt, square)
end

function Scene:addFloor(x, y, z, sprite)
    if not Support.isAuthority() then return end
    local square = self:getSquare(x, y, z)
    if not square then return end
    local floor = square:addFloor(sprite)
    if floor and isServer and isServer() then floor:transmitCompleteItemToClients() end
    return floor
end

return Scene
