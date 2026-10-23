-- Acceptance profile only; observes production callbacks without replacing them.
OnlyKI5Acceptance = {spawns={}, chunks=0}
Events.OnSpawnVehicleEnd.Add(function(vehicle)
    local zone = getVehicleZoneAt(math.floor(vehicle:getX()),math.floor(vehicle:getY()),math.floor(vehicle:getZ()))
    OnlyKI5Acceptance.spawns[#OnlyKI5Acceptance.spawns+1] = {
        id=vehicle:getId(),script=vehicle:getScriptName(),skin=vehicle:getSkinIndex(),
        x=vehicle:getX(),y=vehicle:getY(),z=vehicle:getZ(),
        zone=zone and zone:getName(),lights=vehicle:getLightbarLightsMode(),siren=vehicle:getLightbarSirenMode(),
    }
end)
Events.LoadChunk.Add(function() OnlyKI5Acceptance.chunks=OnlyKI5Acceptance.chunks+1 end)
Events.OnClientCommand.Add(function(module,command,player,args)
    if module~='OnlyKI5Acceptance' or command~='eval' or not player or player:getAccessLevel()~='admin' then return end
    local fn,errorText=loadstring(args.code)
    local ok,value=false,errorText
    if fn then ok,value=pcall(fn) end
    sendServerCommand(player,'OnlyKI5Acceptance','result',{id=args.id,ok=ok,value=value})
end)
