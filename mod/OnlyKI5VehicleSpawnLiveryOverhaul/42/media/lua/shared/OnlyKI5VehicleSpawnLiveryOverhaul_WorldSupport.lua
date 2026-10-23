-- Authored Only KI5 world helpers. MIT; no third-party library code bundled.
local Support = {}

function Support.isAuthority()
    return not (isClient and isClient())
end

function Support.tableIsEmpty(value)
    for _ in pairs(value or {}) do return false end
    return true
end

function Support.invertAngle(degrees)
    return (degrees + 180) % 360
end

-- Only new story containers call this. Existing inventories are never cleared.
function Support.refillContainer(object, room, kind, procedure, junk)
    if not Support.isAuthority() or not object then return end
    local container = object:getItemContainer()
    if not container then
        container = ItemContainer.new(kind, object:getSquare(), object)
        object:setContainer(container)
    end
    if not container or not container:isEmpty() then return container end
    local distribution = ItemPickerJava.getItemContainer(room, kind, procedure, junk == true)
    if distribution then
        ItemPickerJava.rollItem(distribution, container, true, nil, nil)
    end
    container:setExplored(true)
    if isServer and isServer() then object:transmitCompleteItemToClients() end
    return container
end

return Support
