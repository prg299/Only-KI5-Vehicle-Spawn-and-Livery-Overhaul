-- Disposable photo world. Never applied to the real player profile or shipped.
local current=ActiveMods.getById('currentGame')
current:copyFrom(ActiveMods.getById('default'))
assert(not ActiveMods.requiresResetLua(current),'Photo profile needs a Lua reset')
MainScreen.instance:setDefaultSandboxVars()
SandboxVars.Zombies=6
SandboxVars.VehicleEasyUse=true
SandboxVars.ZombieConfig.PopulationMultiplier=0
SandboxVars.ZombieConfig.PopulationStartMultiplier=0
SandboxVars.ZombieConfig.PopulationPeakMultiplier=0
getWorld():setGameMode('Sandbox')
getWorld():setMap('Muldraugh, KY')
local name='only-ki5-gallery-'..getTimestamp()
getWorld():setWorld(name)
selectedDebugScenario={name='Only KI5 gallery',startLoc={x=12558,y=4238,z=0}}
createWorld(name)
GameWindow.doRenderEvent(false)
forceChangeState(LoadingQueueState.new())
return {starting=name,disposablePhotoWorld=true}
