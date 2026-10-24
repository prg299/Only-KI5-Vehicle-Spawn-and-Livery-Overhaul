-- Runtime availability, shared by map pools, aliases, professions and scenes.
local Fleet = {}
local catalog

function Fleet.active(mod)
    if not getActivatedMods then return true end -- isolated policy fixtures
    return getActivatedMods():contains(mod)
end

function Fleet.available(name)
    local provider=catalog and catalog.scriptProviders[name]
    if provider and not Fleet.active(provider) then return false end
    if getScriptManager then return getScriptManager():getVehicle(name)~=nil end
    return true
end

function Fleet.activate(C)
    if getScriptManager then
        local manager=getScriptManager()
        for _,entry in ipairs(require 'OnlyKI5VehicleSpawnLiveryOverhaul_OptionalVehicles') do
            local script=manager:getVehicle(entry.script)
            if Fleet.active(entry.provider) and script and script:getSkinCount()==0 then
                script:Load(string.sub(entry.script,6),entry.definition)
                script:Loaded()
            end
        end
    end
    catalog=C
    C.knownScripts={}
    for name in pairs(C.scriptProviders or {}) do C.knownScripts[name]=true end
    local function trim(list)
        local kept={}
        for _,name in ipairs(list or {}) do if Fleet.available(name) then kept[#kept+1]=name end end
        for key in pairs(list or {}) do list[key]=nil end
        for i,name in ipairs(kept) do list[i]=name end
    end
    for _,lists in ipairs({C.groups,C.wreckedGroups,C.weightedGroups}) do
        for _,list in pairs(lists or {}) do trim(list) end
    end
    trim(C.regionalPoliceScripts)
    for name in pairs(C.policeScripts or {}) do if not Fleet.available(name) then C.policeScripts[name]=nil end end
    -- Preserve role where possible. With a small fleet, ordinary cars may fill
    -- other ordinary body styles; service/military/trailer roles stay empty
    -- when no suitable pack exists. Never reintroduce a vanilla vehicle.
    local ordinary={}
    for _,group in ipairs({'civilian','compact','wagon','suv','pickup','van'}) do
        for _,name in ipairs(C.groups[group] or {}) do ordinary[#ordinary+1]=name end
    end
    if #ordinary==0 then
        for _,group in ipairs({'luxury','sports','commercial'}) do
            for _,name in ipairs(C.groups[group] or {}) do ordinary[#ordinary+1]=name end
        end
    end
    for _,group in ipairs({'civilian','compact','wagon','suv','pickup','van','sports','luxury','commercial'}) do
        if #(C.groups[group] or {})==0 then C.groups[group]={};for i,name in ipairs(ordinary) do C.groups[group][i]=name end end
    end
    C.availableFleetCount=0
    for name in pairs(C.scriptProviders) do if Fleet.available(name) then C.availableFleetCount=C.availableFleetCount+1 end end
    return C
end

function Fleet.filter(list)
    local result={}
    for _,name in ipairs(list or {}) do if Fleet.available(name) then result[#result+1]=name end end
    return result
end

return Fleet
