-- One selection policy for catalog, map/crash pools and profession stories.
-- Does not edit vehicles, textures, player saves or other mods' source files.
local Policy = {}
local cachedCatalog, categories
local noveltyWords = {'kitt','karr','bttf','ecto','mrbean','valkyriesspear','slidespiffo','apocalypse','hippie','unionjack','ramaircustom'}
local businessZones = {mccoy=true,carpenter=true,postal=true,radio=true,fossoil=true,scarlet=true,
    massgenfac=true,transit=true,network3=true,kyheralds=true,lectromax=true,knoxdisti=true,
    knoxtelecomms=true,trades=true,delivery=true,spiffo=true,airportshuttle=true,airportservice=true}

local function lower(value) return string.lower(tostring(value or '')) end
function Policy.canonical(name)
    if type(name)~='string' then return name end
    while string.sub(name,1,10)=='Base.Base.' do name=string.sub(name,6) end
    if not string.find(name,'.',1,true) then name='Base.'..name end
    return name
end

local function categoryMap(C)
    if cachedCatalog~=C then
        cachedCatalog=C;categories={}
        for name,category in pairs(C.trafficCategories or {}) do categories[name]=category end
        for _,group in ipairs({'police','policeGeneric','prison','prisonPolice','ranger','fire','ambulance'}) do
            for _,name in ipairs(C.groups[group] or {}) do categories[name]='emergency' end
        end
        for _,group in ipairs({'militaryCar','militaryTruck','militaryTrailer'}) do
            for _,name in ipairs(C.groups[group] or {}) do categories[name]='military' end
        end
        for _,names in pairs(C.wreckedGroups or {}) do
            for _,name in ipairs(names) do categories[name]='military' end
        end
    end
    return categories
end

function Policy.suppressionEnabled()
    return Policy.civilianShare()==0
end

function Policy.numberOption(name,default)
    local options=SandboxVars and SandboxVars.OnlyKI5
    local value=options and tonumber(options[name])
    if not value or value~=value then return default end
    return math.max(0,math.min(100,value))
end

function Policy.percentOption(name,default) return math.floor(Policy.numberOption(name,default)) end
function Policy.civilianShare() return Policy.numberOption('CustomCivilianChance',.025)/100 end

function Policy.humveeShare()
    return Policy.percentOption('HumveeSpawnChance',95)/100
end

function Policy.amGeneralTruckShare()
    return Policy.percentOption('AMGeneralTruckChance',75)/100
end

function Policy.isAMGeneralTruck(name)
    return string.match(name or '', '^Base%.78amgeneralM35A2')~=nil
        or string.match(name or '', '^Base%.78amgeneralM49A2C')~=nil
        or string.match(name or '', '^Base%.78amgeneralM50A3')~=nil
        or string.match(name or '', '^Base%.78amgeneralM62')~=nil
        or string.match(name or '', '^Base%.83amgeneralM923')~=nil
end

function Policy.militaryTruckWeight(C,name,wrecked)
    local key=wrecked and 'militaryTruckWreck' or 'militaryTruck'
    local weights=(C.weights or {})[key] or {}
    local am,other=0,0
    for _,candidate in ipairs((wrecked and C.wreckedGroups or C.groups).militaryTruck or {}) do
        local weight=weights[candidate] or 1
        if Policy.isAMGeneralTruck(candidate) then am=am+weight else other=other+weight end
    end
    -- Some B42 fleets have no AM General wreck definitions. Keep the valid
    -- available family instead of inventing scripts or emptying the pool.
    if am==0 or other==0 then return nil end
    local share=Policy.amGeneralTruckShare()
    local ownWeight=weights[name] or 1
    return Policy.isAMGeneralTruck(name) and ownWeight/am*share*1000 or ownWeight/other*(1-share)*1000
end

function Policy.militaryCarWeight(C,name,wrecked)
    local candidates=(wrecked and C.wreckedGroups or C.groups).militaryCar or {}
    local preferred=wrecked and 'Base.92amgeneralM998Burnt' or 'Base.92amgeneralM998'
    local present,others=false,0
    for _,candidate in ipairs(candidates) do
        if candidate==preferred then present=true else others=others+1 end
    end
    if not present then return nil end
    local share=Policy.humveeShare()
    if name==preferred then return others>0 and share*1000 or 1000 end
    return others>0 and (1-share)*1000/others or 0
end

function Policy.isCustom(C,name)
    name=Policy.canonical(name)
    local category=categoryMap(C)[name]
    if category=='emergency' or category=='military' or (C.trafficProtectedScripts or {})[name] then return false end
    if (C.customCivilianScripts or {})[name] then return true end
    local key=lower(name)
    if string.sub(key,-3)=='dnd' then return true end
    for _,word in ipairs(noveltyWords) do if string.find(key,word,1,true) then return true end end
    return false
end

function Policy.suppressed(C,name) return Policy.suppressionEnabled() and Policy.isCustom(C,name) end

function Policy.weightOverride(C,group,name,zoneName)
    local alias=(C.aliasFallbacks or {})[group]
    if alias then
        local chosen=Policy.suppressed(C,alias.original) and alias.fallback or alias.original
        return name==chosen and 1 or 0
    end
    if Policy.suppressed(C,name) then return 0 end
    if group=='militaryCar' then return Policy.militaryCarWeight(C,name,false) end
    if group=='militaryTruck' then return Policy.militaryTruckWeight(C,name,false) end
    if group=='commercial' or group=='commercialVan' then
        if name=='Base.87fordB700school' then return lower(zoneName)=='transit' and 1 or 0 end
        if string.find(lower(name),'wrecker',1,true) then return .005 end
    end
    return nil
end

function Policy.replacement(C,name)
    return Policy.suppressed(C,name) and ((C.customCivilianFallbacks or {})[name] or 'Base.86fordE150') or name
end

function Policy.category(C,name)
    name=Policy.canonical(name)
    local category=categoryMap(C)[name]
    if category and category~='wreck' then return category end
    local key=lower(name)
    if string.find(key,'police',1,true) or string.find(key,'ambulance',1,true) then return 'emergency' end
    if string.find(key,'limo',1,true) or string.find(key,'elgin',1,true) or Policy.isCustom(C,name) then return 'specialty' end
    if category=='wreck' or string.find(key,'burnt',1,true) then return 'wreck' end
    return 'unknown'
end

function Policy.role(name)
    local key=lower(name)
    if key=='army' or string.find(key,'military',1,true) then return 'military' end
    if string.find(key,'police',1,true) or string.find(key,'prison',1,true) then return 'police' end
    if string.find(key,'fire',1,true) then return 'fire' end
    if key=='ambulance' then return 'ambulance' end
    if key=='ranger' then return 'ranger' end
    if key=='modified_trfjm' then return 'highway' end
    if string.find(key,'trafficjam',1,true) then return 'traffic' end
    if key=='sport' or key=='racecar' then return 'sports' end
    if key=='advertising' then return 'trailer' end
    if key=='special_gasstation' then return 'civilian' end
    if string.sub(key,1,8)=='special_' then return 'specialty' end
    if businessZones[key] or string.sub(key,1,8)=='business' then return 'business' end
    if key=='normalburnt' or key=='specialburnt' then return 'wreck' end
    if key=='farm' then return 'farm' end
    return 'civilian'
end

local customWeightSources=setmetatable({}, {__mode='k'})
function Policy.originalCustomWeight(properties)
    local saved=customWeightSources[properties]
    return saved and saved.original
end
local function copy(value)
    local result={};for key,child in pairs(value) do result[key]=child end
    customWeightSources[result]=customWeightSources[value]
    return result
end
local function available(name)
    if getScriptManager then return getScriptManager():getVehicle(name)~=nil end
    return true -- production-Lua fixtures provide their own explicit catalog
end
local function plainCandidates(C,role)
    local names=role=='military' and (C.groups.militaryCar or {})
        or role=='police' and (C.groups.policeGeneric or {})
        or (role=='fire' or role=='ambulance' or role=='ranger') and (C.groups[role] or {})
        or role=='trailer' and {'Base.TrailerKI5cargoSmall','Base.TrailerKI5cargoMedium'}
        or role=='business' and {'Base.86fordE150','Base.85chevyStepVan','Base.76chevyK20'}
        or role=='farm' and {'Base.76chevyK20','Base.93fordF350'}
        or C.groups.normal or {}
    local result={}
    for _,name in ipairs(names) do
        if not Policy.suppressed(C,name) and available(name) then result[#result+1]=name end
    end
    return result
end

local broadCaps={sports=.025,business=.04,specialty=.0025,emergency=.015,military=.01,unknown=.0025,wreck=.0025}
local highwayCaps={sports=.01,business=.0125,specialty=.001,emergency=.0025,military=.0025,unknown=.0005,wreck=.0005}

local function categoryTotals(C,vehicles)
    local totals={};local total=0
    for name,p in pairs(vehicles) do
        local weight=type(p)=='table' and tonumber(p.spawnChance) or 0
        if weight and weight>0 then
            local category=Policy.category(C,name)
            totals[category]=(totals[category] or 0)+weight;total=total+weight
        end
    end
    return totals,total
end

-- Scale original weights once. In an all-custom work pool, give the removed
-- weight to plain counterparts so normalization cannot cancel the modifier.
function Policy.limitCustom(C,vehicles)
    local custom,plain=0,0
    for name,p in pairs(vehicles) do
        if Policy.isCustom(C,name) then custom=custom+p.spawnChance else plain=plain+p.spawnChance end
    end
    if custom>0 then
        local factor=Policy.civilianShare();local additions={}
        for name,p in pairs(vehicles) do if Policy.isCustom(C,name) then
            local saved=customWeightSources[p]
            local original=saved and math.abs(p.spawnChance-saved.applied)<1e-10 and saved.original or p.spawnChance
            local fallback=(C.customCivilianFallbacks or {})[name] or 'Base.85chevyCapriceSedan'
            p.spawnChance=original*factor
            customWeightSources[p]={original=original,applied=p.spawnChance}
            if plain<=0 then additions[fallback]=(additions[fallback] or 0)+original*(1-factor) end
        end end
        for name,weight in pairs(additions) do
            if not vehicles[name] then vehicles[name]={index=-1,spawnChance=0} end
            vehicles[name].spawnChance=vehicles[name].spawnChance+weight
        end
        for name,p in pairs(vehicles) do if p.spawnChance<=0 then vehicles[name]=nil end end
    end
    return custom>0
end

local professionPools={}
function Policy.professionPool(list) return professionPools[list] end

function Policy.pickPool(vehicles)
    local names,total={},0
    for name,p in pairs(vehicles) do if p.spawnChance>0 then names[#names+1]=name;total=total+p.spawnChance end end
    if total<=0 then return nil end
    table.sort(names)
    local roll=ZombRandFloat(0,total)
    for _,name in ipairs(names) do
        roll=roll-vehicles[name].spawnChance
        if roll<0 then return name end
    end
    return names[#names]
end

function Policy.pickGroup(C,group,zone)
    local weights={}
    for _,name in ipairs(C.groups[group] or {}) do
        local weight=C.weight(group,name,zone)
        if weight>0 then weights[name]={index=-1,spawnChance=weight} end
    end
    Policy.limitCustom(C,weights)
    return Policy.pickPool(weights)
end

local wrappedProfession
local function installProfessionSelector()
    if (isClient and isClient()) or not Events or not Events.OnSpawnVehicleStart
        or not ProfessionVehicles or type(ProfessionVehicles.CheckSwap)~='function' then return end
    if wrappedProfession then return end
    local original=ProfessionVehicles.CheckSwap
    local originalRegion=ProfessionVehicles.OnCreateRegion
    local function pick(list)
        if not list or #list==0 then return nil end
        return professionPools[list] and Policy.pickPool(professionPools[list]) or list[ZombRand(#list)+1]
    end
    local function unique(selected,alternate)
        if not selected then return nil end
        for _,name in ipairs(ProfessionVehicles.UniqueVehicles or {}) do
            if selected==name then
                local data=ModData.getOrCreate('UniqueVehiclesSpawned')
                if data[selected] then return pick(alternate) end
                data[selected]=true;break
            end
        end
        return selected
    end
    wrappedProfession=function(vehicle)
        if not vehicle or vehicle:isCreated() then return original(vehicle) end
        local square=vehicle:getSquare();local script=vehicle:getScript()
        local role=script and ProfessionVehicles[script:getName()]
        local list=square and role and (role[square:getSquareRegion() or 'General'] or role.General)
        if not professionPools[list] then return original(vehicle) end
        local selected=unique(pick(list),role.Alternate)
        if selected and selected~=script:getFullName() then
            vehicle:setScriptName(selected);vehicle:scriptReloaded(true);vehicle:setSkinIndex(0)
        end
    end
    Events.OnSpawnVehicleStart.Remove(original)
    Events.OnSpawnVehicleStart.Add(wrappedProfession)
    ProfessionVehicles.CheckSwap=wrappedProfession
    if type(originalRegion)=='function' then
        ProfessionVehicles.OnCreateRegion=function(region,square,direction)
            local list=ProfessionVehicles[region]
            if region=='General' or not professionPools[list] then return originalRegion(region,square,direction) end
            local selected=unique(pick(list))
            if selected then return addVehicleDebug(selected,direction,nil,square) end
        end
    end
end

function Policy.balancePool(C,zoneName,zone)
    local role=Policy.role(zoneName)
    local cloned=copy(zone);local vehicles={};cloned.vehicles=vehicles
    local removed,removedWeight,originalWeight=0,0,0
    for source,p in pairs(zone.vehicles) do
        local name=Policy.canonical(source)
        local weight=type(p)=='table' and tonumber(p.spawnChance) or 0
        originalWeight=originalWeight+(weight or 0)
        if Policy.suppressed(C,name) then removed=removed+1;removedWeight=removedWeight+(weight or 0)
        elseif type(p)=='table' and weight and weight>0 then
            if vehicles[name] then vehicles[name].spawnChance=vehicles[name].spawnChance+weight
            else vehicles[name]=copy(p) end
        end
    end
    -- A sweeper is municipal equipment, not a fire engine. Keep dedicated
    -- emergency/military roles free of these optional civilian specialties.
    if role=='police' or role=='fire' or role=='ambulance' or role=='ranger' or role=='military' then
        for name in pairs(vehicles) do
            local key=lower(name)
            if string.find(key,'elgin',1,true) or string.find(key,'limo',1,true) then vehicles[name]=nil end
        end
    end
    if role=='trailer' then
        for name in pairs(vehicles) do if string.sub(name,1,12)~='Base.Trailer' then vehicles[name]=nil end end
    end
    if role=='business' then
        for name in pairs(vehicles) do
            local category=Policy.category(C,name)
            if category=='military' or category=='wreck'
                or (category=='emergency' and lower(zoneName)~='airportservice')
                or (name=='Base.87fordB700school' and lower(zoneName)~='transit') then vehicles[name]=nil end
        end
    end
    local totals,total=categoryTotals(C,vehicles)
    if total<=0 and originalWeight>0 then
        local candidates=plainCandidates(C,role)
        local budget=total<=0 and math.max(removedWeight,100) or removedWeight
        for _,name in ipairs(candidates) do
            if not vehicles[name] then vehicles[name]={index=-1,spawnChance=0} end
            vehicles[name].spawnChance=vehicles[name].spawnChance+budget/#candidates
        end
        totals,total=categoryTotals(C,vehicles)
    end
    local caps=role=='highway' and highwayCaps or (role=='civilian' or role=='traffic') and broadCaps or nil
    if caps and (totals.everyday or 0)>0 then
        local everyday=totals.everyday
        for category,ratio in pairs(caps) do
            local current=totals[category] or 0
            local factor=current>0 and math.min(1,everyday*ratio/current) or 1
            if factor<1 then for name,p in pairs(vehicles) do
                if Policy.category(C,name)==category then p.spawnChance=p.spawnChance*factor end
            end end
        end
    end
    -- Apply the optional limo/sweeper limits in business and dealership pools
    -- too; their upstream entries otherwise bypass the generated KI5 catalog.
    local reference=0
    for name,p in pairs(vehicles) do
        local key=lower(name)
        if not string.find(key,'limo',1,true) and not string.find(key,'elgin',1,true)
            and not (role=='business' and string.find(key,'wrecker',1,true)) then reference=reference+p.spawnChance end
    end
    if reference>0 then for name,p in pairs(vehicles) do
        local key=lower(name)
        if string.find(key,'limo',1,true) or string.find(key,'elgin',1,true) then
            p.spawnChance=math.min(p.spawnChance,reference*(role=='highway' and .0002 or .0005))
        elseif role=='business' and string.find(key,'wrecker',1,true) then
            p.spawnChance=math.min(p.spawnChance,reference*.002)
        end
    end end
    Policy.limitCustom(C,vehicles)
    totals,total=categoryTotals(C,vehicles)
    return cloned,{role=role,removedCustom=removed,totalWeight=total,categories=totals}
end

local function filterProfession(C,value,seen,aliases)
    if type(value)~='table' or seen[value] then return end
    seen[value]=true
    local source={};local numeric=false
    for key,child in pairs(value) do
        if type(key)=='number' and type(child)=='string' then source[#source+1]=Policy.canonical(child);numeric=true
        elseif type(child)=='table' then filterProfession(C,child,seen,aliases) end
    end
    if numeric then
        local kept,weights={},{}
        for _,name in ipairs(source) do
            local replacement=(aliases and aliases.resolve(name,true)) or Policy.replacement(C,name)
            if replacement and available(replacement) then
                kept[#kept+1]=replacement
                if not weights[replacement] then weights[replacement]={index=-1,spawnChance=0} end
                weights[replacement].spawnChance=weights[replacement].spawnChance+1
            end
        end
        for key in pairs(value) do if type(key)=='number' then value[key]=nil end end
        for i,name in ipairs(kept) do value[i]=name end
        if Policy.limitCustom(C,weights) then professionPools[value]=weights end
    end
end

function Policy.normalizeRegistryKeys()
    for _,zone in pairs(VehicleZoneDistribution or {}) do
        if type(zone)=='table' and type(zone.vehicles)=='table' then
            local edits={}
            for source,p in pairs(zone.vehicles) do
                local name=Policy.canonical(source)
                if name~=source then edits[#edits+1]={source=source,name=name,properties=p} end
            end
            for _,edit in ipairs(edits) do
                local current=zone.vehicles[edit.name]
                if type(current)=='table' and type(edit.properties)=='table' then
                    current.spawnChance=(tonumber(current.spawnChance) or 0)+(tonumber(edit.properties.spawnChance) or 0)
                else zone.vehicles[edit.name]=edit.properties end
                zone.vehicles[edit.source]=nil
            end
        end
    end
end

function Policy.apply(C,aliases)
    local result={suppressionEnabled=Policy.suppressionEnabled(),customCivilianPercent=Policy.civilianShare()*100,zones={}}
    for name,zone in pairs(VehicleZoneDistribution or {}) do
        if type(zone)=='table' and type(zone.vehicles)=='table' then
            local balanced,record=Policy.balancePool(C,name,zone)
            VehicleZoneDistribution[name]=balanced;result.zones[name]=record
        end
    end
    professionPools={}
    filterProfession(C,ProfessionVehicles,{},aliases)
    installProfessionSelector()
    OnlyKI5TrafficPolicyAudit=result
    return result
end

return Policy
