-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
-- Police Skins Pack for KI5 - variant armor registration fix
--
-- The KI5 base mods register their collision/armor handlers per vehicle script
-- via DAMN.Armor:add(). The police variants added by this pack are new script
-- names that are not in those lists, so their bullbars / armor parts did not
-- absorb impacts and collision damage went to the hood / engine instead.
--
-- This file registers the base mods' handlers for every variant script that
-- this pack adds. DAMN.Armor:add() is an overriding registration, so calling
-- it twice with the same handler is harmless.

require "DAMN_Armor_Shared";

local mappings = {
    -- base handler table name -> variant script names added by this pack
    { "SUB93", {
        "Base.93chevySuburbanpdWestPoint",
        "Base.93chevySuburbanpdMuldraugh",
        "Base.93chevySuburbanpdLouisville",
        "Base.93chevySuburbanpdMeade",
        "Base.93chevySuburbanpdBulletin",
        "Base.93chevySilveradoCClongSecurity",
        "Base.93chevySilveradoCClongLouisville",
        "Base.93chevySilveradoCClongMuldraugh",
    } },
    { "CVPI92", {
        "Base.92fordCVPIWestPoint",
        "Base.92fordCVPIMeade",
        "Base.92fordCVPILouisville",
        "Base.92fordCVPIMuldraugh",
        "Base.92fordCVPIBulletin",
        "Base.92fordCVPI2WestPoint",
        "Base.92fordCVPI2Meade",
        "Base.92fordCVPI2Louisville",
        "Base.92fordCVPI2Muldraugh",
        "Base.92fordCVPI2Bulletin",
    } },
    { "F3502", {
        "Base.93fordF350pdWestPoint",
        "Base.93fordF350pdBulletin",
        "Base.93fordF350pdMeade",
        "Base.93fordF350pdMuldraugh",
        "Base.93fordF350pdLouisville",
    } },
    { "M998", {
        "Base.92amgeneralM998SWAT",
        "Base.92amgeneralM998Meade",
    } },
    { "BR89", {
        "Base.89fordBroncoWestPoint",
        "Base.89fordBroncoMeade",
        "Base.89fordBroncoMuldraugh",
        "Base.89fordBroncoBulletin",
    } },
    { "LTD91", {
        "Base.91fordLTDpdWestPoint",
        "Base.91fordLTDpdBulletin",
        "Base.91fordLTDpdMeade",
        "Base.91fordLTDpdMuldraugh",
        "Base.91fordLTDpdLouisville",
        "Base.91fordLTDpdLCPD",
    } },
    { "B700", {
        "Base.87fordB700Ksprison",
    } },
    { "F700", {
        "Base.87fordF700Lswat",
    } },
};

local function registerVariantArmor()
    if not (DAMN and DAMN.Armor and DAMN.Armor.add) then
        return -1, 0;
    end

    local registered = 0;
    local missingHandlers = 0;

    for _, mapping in ipairs(mappings) do
        local handlerTable = _G[mapping[1]];
        local handler = handlerTable and handlerTable["activeArmor"];
        if handler then
            for _, scriptName in ipairs(mapping[2]) do
                DAMN.Armor:add(scriptName, handler);
                registered = registered + 1;
            end
        else
            missingHandlers = missingHandlers + 1;
        end
    end

    return registered, missingHandlers;
end

-- best effort at load time (bases usually loaded first)
registerVariantArmor();

-- and again once every mod's lua has been loaded
Events.OnGameBoot.Add(function()
    local registered, missingHandlers = registerVariantArmor();
    if registered < 0 then
        print("FixPoliceSkins Armor: DAMN.Armor unavailable, variant armor NOT registered");
    elseif missingHandlers > 0 then
        print("FixPoliceSkins Armor: registered " .. registered .. " variant script(s), " .. missingHandlers .. " base handler(s) missing");
    else
        print("FixPoliceSkins Armor: registered " .. registered .. " variant script(s) OK");
    end
end);
