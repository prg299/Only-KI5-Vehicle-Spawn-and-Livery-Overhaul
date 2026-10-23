-- Vanilla maps smashed civilian bodies onto base emergency vehicles with a
-- police skin index. Those mappings bypass regional vehicle selection, so
-- clear only the vanilla police aliases; crash-zone script selection is
-- converted by the server registry and re-liveried at vehicle spawn time.
if SmashedCarDefinitions and type(SmashedCarDefinitions.cars) == "table" then
    for _, sourceName in ipairs({
        "Base.CarLightsPolice",
        "Base.PickUpVanLightsPolice",
        "Base.PickUpTruckLightsPolice",
    }) do
        local definition = SmashedCarDefinitions.cars[sourceName]
        if type(definition) == "table" then
            definition.rear = nil
            definition.front = nil
            definition.right = nil
            definition.left = nil
            definition.skin = nil
        end
    end
end
