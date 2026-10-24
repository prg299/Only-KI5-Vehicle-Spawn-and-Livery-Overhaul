function isClient() return false end
function ZombRand(n) return 0 end
function ZombRandFloat(a,b) return a end
local callback
Events={OnSpawnVehicleStart={Add=function(fn) callback=fn end}}
require 'OnlyKI5VehicleSpawnLiveryOverhaul_PoliceSpawnRouting'
local R=require 'OnlyKI5VehicleSpawnLiveryOverhaul_PoliceRegions'
local function vehicle(name,region,index,created)
 local v={name=name,index=index,created=created}
 function v:isCreated() return self.created end
 function v:getScript() return {getFullName=function() return self.name end,
  getName=function() return string.sub(self.name,6) end,getSkinCount=function() return 1 end} end
 function v:getSquare() return {getSquareRegion=function() return region end} end
 function v:getSkinIndex() return self.index end
 function v:setSkinIndex(n) self.index=n end
 function v:setScriptName(n) self.name=n end
 function v:scriptReloaded() end
 return v
end
local assigned=vehicle('Base.93chevySuburbanPoliceCLPD','Louisville',6,false)
callback(assigned)
assert(assigned.name=='Base.93chevySuburbanPoliceCLPD' and assigned.index==0,
 'Accepted regional livery retained an out-of-range profession skin')
local wrong=vehicle('Base.93chevySuburbanPoliceCLPD','WestPoint',6,false)
callback(wrong);assert(R.isAssignedLivery(wrong.name,'westPoint') and wrong.index==0)
local valid=vehicle('Base.93chevySuburbanPoliceCLPD','Louisville',0,false)
callback(valid);assert(valid.name=='Base.93chevySuburbanPoliceCLPD' and valid.index==0)
local saved=vehicle('Base.93chevySuburbanPoliceCLPD','Louisville',6,true)
callback(saved);assert(saved.index==6,'Saved police vehicle rewritten')
local civilian=vehicle('Base.85chevyCapriceSedan','Louisville',6,false)
callback(civilian);assert(civilian.name=='Base.85chevyCapriceSedan' and civilian.index==6)
