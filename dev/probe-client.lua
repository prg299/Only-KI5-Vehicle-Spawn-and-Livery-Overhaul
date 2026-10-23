-- Acceptance profile only, never included in the public mod.
UIManager.setShowLuaDebuggerOnError(false)
Events.OnGameStart.Add(function() print('[ONLY_KI5_ACCEPTANCE] WORLD_READY') end)
Events.OnMainMenuEnter.Add(function() print('[ONLY_KI5_ACCEPTANCE] MENU_READY') end)
Events.OnServerCommand.Add(function(module, command, args)
    if module == 'OnlyKI5Acceptance' and command == 'result' then OnlyKI5AcceptanceResult = args end
end)
