local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local P=require 'OnlyKI5VehicleSpawnLiveryOverhaul_TrafficPolicy'
local A=require 'OnlyKI5VehicleSpawnLiveryOverhaul_SpawnAliases'
SandboxVars={};assert(P.civilianShare()==.00025)
local fraction=0
function ZombRandFloat(a,b) return a+(b-a)*fraction end
function ZombRand(n) return 0 end
function isClient() return ONLY_KI5_TEST_TRAFFIC_SHAPE=='client' end
local originalCalls=0
local original=function() originalCalls=originalCalls+1 end
local event={callbacks={original}}
function event.Add(fn) event.callbacks[#event.callbacks+1]=fn end
function event.Remove(fn) for i=#event.callbacks,1,-1 do if event.callbacks[i]==fn then table.remove(event.callbacks,i) end end end
local data={}
ModData={getOrCreate=function() return data end}
Events={OnSpawnVehicleStart=event}
local function source()
 return {vehicles={['Base.82firebirdKITT']={spawnChance=100},['Base.82firebirdKARR']={spawnChance=100},
  ['Base.85chevyCapriceSedan']={spawnChance=100}}}
end
local function customShare(pool)
 local total,custom=0,0
 for name,p in pairs(pool) do total=total+p.spawnChance;if P.isCustom(C,name) then custom=custom+p.spawnChance end end
 return custom/total,total
end
for _,percent in ipairs({0,.025,.1,25,100}) do
 SandboxVars.OnlyKI5={CustomCivilianChance=percent}
 local pool=P.balancePool(C,'business',source())
 local share,total=customShare(pool.vehicles)
 local expected=200*(percent/100)/(100+200*(percent/100))
 assert(math.abs(share-expected)<1e-12,'original-weight multiplier became an overall share')
 assert(pool.vehicles['Base.85chevyCapriceSedan'].spawnChance==100,'ordinary source weight changed')
 assert(math.abs(total-(100+200*percent/100))<1e-8,'wrong scaled total')
 local only={vehicles={['Base.82firebirdKITT']={spawnChance=100}}}
 local result=P.balancePool(C,'business',only)
 local actual=customShare(result.vehicles)
 assert(actual<=percent/100+1e-12,'all-custom pool cancels rarity')
end
SandboxVars.OnlyKI5={CustomCivilianChance=.025}
VehicleZoneDistribution={business=source()}
ProfessionVehicles={CheckSwap=original,OnCreateRegion=original,UniqueVehicles={},
 CarNormal={General={'Base.82firebirdKITT','Base.82firebirdKARR','Base.85chevyCapriceSedan'},Alternate={'Base.85chevyCapriceSedan'}},
 Muldraugh={'Base.82firebirdKITT','Base.85chevyCapriceSedan'}}
P.apply(C,A)
local pool=P.professionPool(ProfessionVehicles.CarNormal.General)
assert(pool and math.abs(customShare(pool)-(.0005/1.0005))<1e-12,'profession weight rounded away or became a fixed share')
assert(#ProfessionVehicles.CarNormal.General==3,'fractional chance inflated the list')
local v={created=false,name='Base.CarNormal',skin=6}
function v:isCreated() return self.created end
function v:getSquare() return {getSquareRegion=function() return 'General' end} end
function v:getScript() return {getName=function() return string.sub(self.name,6) end,getFullName=function() return self.name end} end
function v:setScriptName(name) self.name=name end
function v:scriptReloaded() end
function v:setSkinIndex(index) self.skin=index end
if isClient() then
 assert(ProfessionVehicles.CheckSwap==original and #event.callbacks==1,'client must retain the original authority path')
 return
end
assert(ProfessionVehicles.CheckSwap~=original and #event.callbacks==1,'native callback not replaced exactly once')
local function select(name)
 local total,before=0,0;local keys={}
 for k,p in pairs(pool) do total=total+p.spawnChance;keys[#keys+1]=k end
 table.sort(keys)
 for _,k in ipairs(keys) do if k==name then break end;before=before+pool[k].spawnChance end
 fraction=(before+pool[name].spawnChance/2)/total
 v.name='Base.CarNormal';event.callbacks[1](v)
 assert(v.name==name and v.skin==0,'fractional profession selection or source skin reset failed')
end
select('Base.82firebirdKITT');select('Base.82firebirdKARR');select('Base.85chevyCapriceSedan')
v.created=true;v.name='Base.CarNormal';event.callbacks[1](v)
assert(v.name=='Base.CarNormal' and originalCalls==1,'existing vehicle rewritten')
v.created=false
local spawn
function addVehicleDebug(name,direction,skin,square) spawn={name,direction,skin,square} end
local regional=P.professionPool(ProfessionVehicles.Muldraugh)
fraction=0;local expected=P.pickPool(regional)
ProfessionVehicles.OnCreateRegion('Muldraugh','square','N')
assert(spawn[1]==expected and spawn[2]=='N' and spawn[4]=='square','regional profession path bypassed fractional selection')
local before=VehicleZoneDistribution.business.vehicles['Base.82firebirdKITT'].spawnChance
P.apply(C,A);assert(#event.callbacks==1,'duplicate wrapper after finalization')
assert(math.abs(VehicleZoneDistribution.business.vehicles['Base.82firebirdKITT'].spawnChance-before)<1e-12,
 'Finalization multiplied civilian rarity a second time')
assert(math.abs(P.professionPool(ProfessionVehicles.CarNormal.General)['Base.82firebirdKITT'].spawnChance-.00025)<1e-12,
 'Profession original weights were multiplied twice')
