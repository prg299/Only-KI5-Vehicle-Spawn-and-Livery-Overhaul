-- Select a livery once, before native creation, on the spawning authority.
local SpawnSkins = {}
local KEY = 'OnlyKI5VehicleSpawnLiveryOverhaul.HumveeSkinV1'
-- KI5's loaded eight-skin order, with Consistent Camo's texture replacements:
-- USMC green, NATO green, desert, JTF (merdc_winter), medic (merdc_summer),
-- woodland, mixed woodland, woodland (black). Weights total 100.
local weightsByCount = {
    [8] = {20, 20, 5, 1, 4, 25, 15, 10},
    -- The six-skin B42 definition has no merdc/JTF/medic entries.
    [6] = {20, 20, 5, 30, 15, 10},
}

function SpawnSkins.routeNewVehicle(vehicle)
    if isClient and isClient() then return end
    if not vehicle or vehicle:isCreated() then return end
    local script = vehicle:getScript()
    if not script or script:getFullName() ~= 'Base.92amgeneralM998' then return end
    local data = vehicle:getModData()
    if data[KEY] ~= nil then return end
    local weights = weightsByCount[script:getSkinCount()]
    -- An upstream skin-layout change needs a new audit; do not guess indices.
    if not weights then return end
    local roll = ZombRand(100)
    for i, weight in ipairs(weights) do
        if roll < weight then
            vehicle:setSkinIndex(i - 1)
            data[KEY] = i - 1
            return
        end
        roll = roll - weight
    end
end

return SpawnSkins
