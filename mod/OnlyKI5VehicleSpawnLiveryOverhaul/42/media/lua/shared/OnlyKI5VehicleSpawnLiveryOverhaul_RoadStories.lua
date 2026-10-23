-- Authored scheduler for the four integrated military scenes. MIT.
-- Checkpoints contain plain data on a native square, never functions/userdata.
local Scene = require "OnlyKI5VehicleSpawnLiveryOverhaul_RoadScene"
local Support = require "OnlyKI5VehicleSpawnLiveryOverhaul_WorldSupport"
local Stories = setmetatable({}, { __index = Scene })
local definitions, order, pending = {}, {}, {}
local CHECKPOINT = "OnlyKI5VehicleSpawnLiveryOverhaul_RoadStory"
local ticks = 0
local queueCursor = 0

function Stories:derive(key)
    if not definitions[key] then order[#order + 1] = key end
    local definition = setmetatable({ storyKey = key, chance = 0 }, { __index = Scene })
    definitions[key] = definition
    return definition
end

function Stories.getVehicleStoriesList()
    local result = {}
    for index, key in ipairs(order) do result[index] = key end
    return result
end

local function settings()
    return SandboxVars and SandboxVars.VMZ or {}
end

local function storyFrequency()
    local value = SandboxVars and SandboxVars.VehicleStoryChance or 3
    if getSandboxOptions then
        local option = getSandboxOptions():getOptionByName("VehicleStoryChance")
        if option then value = option:getValue() end
    end
    return ({0, 1/80, 1/40, 1/24, 1/14, 1/4, 1})[value] or 0
end

local function elapsedDays()
    return getGameTime():getWorldAgeHours() / 24
end

local function chooseDefinition(width, length)
    local candidates, total = {}, 0
    local day = elapsedDays()
    for _, key in ipairs(order) do
        local definition = definitions[key]
        local chance = math.max(0, definition.chance or 0)
        if chance > 0 and day >= (definition.minDays or 0)
           and ((definition.maxDays or -1) < 0 or day <= definition.maxDays)
           and width >= definition.minZoneWidth and length >= definition.minZoneHeight then
            total = total + chance
            candidates[#candidates + 1] = { definition = definition, weight = chance }
        end
    end
    if total == 0 then return end
    local roll = ZombRandFloat(0, total)
    for _, candidate in ipairs(candidates) do
        roll = roll - candidate.weight
        if roll < 0 then return candidate.definition end
    end
    return candidates[#candidates].definition
end

local function anchorKey(square)
    return square:getX() .. ":" .. square:getY() .. ":" .. square:getZ()
end

local function enqueue(square, data)
    pending[anchorKey(square)] = {
        x = square:getX(), y = square:getY(), z = square:getZ(), data = data, waits = 0,
    }
end

-- No new story is ever selected for an already saved chunk. A saved pending
-- checkpoint may resume when its surrounding chunks become available again.
function Stories.onLoadChunk(chunk)
    if not Support.isAuthority() or not chunk then return end
    local anchor = chunk:getGridSquare(0, 0, 0)
    if not anchor then return end
    local modData = anchor:getModData()
    local checkpoint = modData[CHECKPOINT]
    if checkpoint ~= nil then
        if type(checkpoint) == "table" and checkpoint.version == 1 and checkpoint.state == "pending"
           and definitions[checkpoint.story] and type(checkpoint.x) == "number"
           and type(checkpoint.y) == "number" and type(checkpoint.z) == "number"
           and type(checkpoint.width) == "number" and IsoDirections[checkpoint.direction] then
            enqueue(anchor, checkpoint)
        end
        return
    end
    if not chunk:isNewChunk() or not settings().RoadStories then return end
    local frequency = storyFrequency()
    if frequency == 0 then return end
    modData[CHECKPOINT] = { version = 1, state = "checked" }
    if ZombRandFloat(0, 1) >= frequency then return end

    -- getSquaresForLevel returns a Java array, not a Lua table. Use the
    -- exported native chunk size and square accessor across supported builds.
    local size = getChunkSizeInSquares()
    local seen = {}
    for index = 0, size * size - 1 do
        local square = chunk:getGridSquare(index % size, math.floor(index / size), 0)
        local zone = square and square:getZone()
        if zone and not seen[zone] and zone:getType() == "Nav"
           and zone:getLastActionTimestamp() == 0 and not zone:haveCons() then
            seen[zone] = true
            local horizontal = zone:getWidth() >= zone:getHeight()
            local width = horizontal and zone:getHeight() or zone:getWidth()
            local length = horizontal and zone:getWidth() or zone:getHeight()
            local definition = chooseDefinition(width, length)
            if definition then
                local x, y = square:getX() + 0.5, square:getY() + 0.5
                if zone:isRectangle() then
                    if horizontal then y = zone:getY() + zone:getHeight() / 2
                    else x = zone:getX() + zone:getWidth() / 2 end
                end
                local direction
                if horizontal then direction = ZombRand(2) == 0 and "E" or "W"
                else direction = ZombRand(2) == 0 and "N" or "S" end
                checkpoint = { version = 1, state = "pending", story = definition.storyKey,
                    x = x, y = y, z = square:getZ(), width = width, direction = direction }
                modData[CHECKPOINT] = checkpoint
                zone:setLastActionTimestamp(1)
                enqueue(anchor, checkpoint)
                return
            end
        end
    end
end

local function sceneFor(data, definition)
    return setmetatable({
        spawnPoint = { x = data.x, y = data.y, z = data.z },
        direction = IsoDirections[data.direction], zoneWidth = data.width,
    }, { __index = definition })
end

local function readiness(scene, definition)
    for x = -definition.minZoneWidth, definition.minZoneWidth do
        for y = -definition.minZoneHeight, definition.minZoneHeight do
            local square = scene:getSquare(x, y, scene.spawnPoint.z)
            if not square or not square:getChunk() then return "waiting" end
            if square:isWaterSquare() or square:isVehicleIntersecting() or square:getBuilding() then
                return "blocked"
            end
        end
    end
    return "ready"
end

-- Bounded work per tick interval. Unloaded or long-deferred entries leave the
-- in-memory queue; their serializable checkpoint can resume on a later load.
function Stories.processPending()
    if not Support.isAuthority() then return end
    local keys = {}
    for key in pairs(pending) do keys[#keys + 1] = key end
    table.sort(keys)
    local processed = 0
    for index = 1, math.min(4, #keys) do
        local key = keys[(queueCursor + index - 1) % #keys + 1]
        processed = processed + 1
        local item = pending[key]
        local anchor = getCell():getGridSquare(item.x, item.y, item.z)
        local data = anchor and anchor:getModData()[CHECKPOINT]
        local definition = data and definitions[data.story]
        if not anchor or data ~= item.data or not definition or data.state ~= "pending" then
            pending[key] = nil
        elseif not settings().RoadStories then
            -- Retain the checkpoint while the setting is disabled.
        else
            local scene = sceneFor(data, definition)
            local status = readiness(scene, definition)
            if status == "blocked" then
                data.state, pending[key] = "blocked", nil
            elseif status == "ready" then
                -- Commit before invoking the scene: partial native failures
                -- must never duplicate objects/vehicles after save and reload.
                data.state, pending[key] = "spawning", nil
                scene.zone = scene:getSquare(0, 0, data.z):getZone()
                local ok, errorText = pcall(function() definition.spawn(scene) end)
                data.state = ok and "done" or "failed"
                if not ok then print("[OnlyKI5VehicleSpawnLiveryOverhaul] story failed: " .. tostring(errorText)) end
            else
                item.waits = item.waits + 1
                if item.waits >= 180 then pending[key] = nil end
            end
        end
    end
    queueCursor = #keys > 0 and (queueCursor + processed) % #keys or 0
end

if Events and Support.isAuthority() then
    Events.LoadChunk.Add(Stories.onLoadChunk)
    Events.OnTick.Add(function()
        ticks = ticks + 1
        if ticks % 30 == 0 then Stories.processPending() end
    end)
end

return Stories
