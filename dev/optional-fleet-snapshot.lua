local C=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Catalog'
local F=require 'OnlyKI5VehicleSpawnLiveryOverhaul_Fleet'
local out={available=C.availableFleetCount,groups={},zones={},invalid={},professionChoices=0,variants={},vehicles={}}
for group,list in pairs(C.groups) do
 local count=0
 for _,name in ipairs(list) do if C.weight(group,name)>0 then
  count=count+1;if not F.available(name) then out.invalid[#out.invalid+1]='group:'..group..':'..name end
 end end
 out.groups[group]=count
end
for name,zone in pairs(VehicleZoneDistribution or {}) do if type(zone)=='table' and type(zone.vehicles)=='table' then
 local count=0
 for script,p in pairs(zone.vehicles) do if type(p)=='table' and (tonumber(p.spawnChance) or 0)>0 then
  count=count+1;if not F.available(script) then out.invalid[#out.invalid+1]='zone:'..name..':'..script end
 end end
 out.zones[name]=count
end end
local seen={}
local function visit(value)
 if type(value)~='table' or seen[value] then return end;seen[value]=true
 for k,v in pairs(value) do
  if type(k)=='number' and type(v)=='string' then
   out.professionChoices=out.professionChoices+1;if not F.available(v) then out.invalid[#out.invalid+1]='profession:'..v end
  elseif type(v)=='table' then visit(v) end
 end
end
visit(ProfessionVehicles)
for _,entry in ipairs(require 'OnlyKI5VehicleSpawnLiveryOverhaul_OptionalVehicles') do
 local script=getScriptManager():getVehicle(entry.script)
 out.variants[#out.variants+1]={name=entry.script,base=entry.provider,enabled=F.active(entry.provider),
  skins=script and script:getSkinCount(),parts=script and script:getPartCount(),available=F.available(entry.script)}
end
local it=getCell() and getCell():getVehicles():iterator()
while it and it:hasNext() do local v=it:next()
 out.vehicles[#out.vehicles+1]={id=v:getId(),sqlId=v:getSqlId(),script=v:getScriptName(),available=F.available(v:getScriptName()),skin=v:getSkinIndex(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode(),x=v:getX(),y=v:getY()}
end
return out
