-- Native photo setup only. The production mod is unchanged.
local p=assert(getPlayer())
assert(not p:isDead(),'Photo character is dead')
p:getBodyDamage():RestoreToFullHealth()
p:setGodMod(true)
p:setInvisible(true)
p:dressInNamedOutfit('Police')
getGameTime():setTimeOfDay(12)
getZomboidRadio():setDisableBroadcasting(true)
local devices=getZomboidRadio():getDevices()
for i=0,devices:size()-1 do
    pcall(function() devices:get(i):getDeviceData():setIsTurnedOn(false) end)
end
getCore():setAutoZoom(0,false)
ISUIHandler.allUIVisible=false
ISUIHandler.setVisibleAllUI(false)
return {playerAlive=not p:isDead(),x=p:getX(),y=p:getY(),zoom=getCore():getZoom(0)}
