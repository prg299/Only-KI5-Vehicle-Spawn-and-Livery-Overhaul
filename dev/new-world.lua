-- World-creation fixture only; normal native chunk/vehicle generation stays active.
local current=ActiveMods.getById('currentGame')
current:copyFrom(ActiveMods.getById('default'))
assert(not ActiveMods.requiresResetLua(current),'Acceptance mods need a Lua reset')
-- Optional acceptance branch carries settings submitted through the native
-- sandbox screen into a fresh world; default runs still reset every option.
if not OnlyKI5AcceptanceKeepSandboxDraft then MainScreen.instance:setDefaultSandboxVars() end
SandboxVars.Zombies=6
SandboxVars.VehicleEasyUse=true
getWorld():setGameMode('Sandbox')
getWorld():setMap('Muldraugh, KY')
local name='only-ki5-acceptance-'..getTimestamp()
getWorld():setWorld(name)
selectedDebugScenario={name='Only KI5 native acceptance',startLoc={x=12530,y=4270,z=0}}
createWorld(name)
GameWindow.doRenderEvent(false)
forceChangeState(LoadingQueueState.new())
return {starting=name}
