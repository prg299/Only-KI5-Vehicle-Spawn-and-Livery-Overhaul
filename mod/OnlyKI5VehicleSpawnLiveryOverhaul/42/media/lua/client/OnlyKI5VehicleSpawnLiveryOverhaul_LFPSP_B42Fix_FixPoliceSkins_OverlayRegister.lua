-- Integrated from Lore-Friendly Police Skins B42 Hotfix (LFPSP-B42Fix).
-- Original author: Old Killer (skins), Aurora (hotfix); https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280
-- Third-party contribution; excluded from the project MIT license.
-- Police Skins Pack for KI5 - repair missing CarList overlay registrations (v4).
-- Links pack variants at game start, guarantees the F700/B700 and M998 overlay
-- entries exist, and prints their runtime state for diagnosis.

require "Vehicles/ISUI/ISCarMechanicsOverlay";

local links = {
    { "Base.93chevySuburbanpdWestPoint",  { "Base.93chevySuburban" }, "93chevySuburban_" },
    { "Base.93chevySuburbanpdMuldraugh",  { "Base.93chevySuburban" }, "93chevySuburban_" },
    { "Base.93chevySuburbanpdLouisville", { "Base.93chevySuburban" }, "93chevySuburban_" },
    { "Base.93chevySuburbanpdMeade",      { "Base.93chevySuburban" }, "93chevySuburban_" },
    { "Base.93chevySuburbanpdBulletin",   { "Base.93chevySuburban" }, "93chevySuburban_" },

    { "Base.92fordCVPI2WestPoint",  { "Base.92fordCVPI2", "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPI2Muldraugh",  { "Base.92fordCVPI2", "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPI2Louisville", { "Base.92fordCVPI2", "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPI2Meade",      { "Base.92fordCVPI2", "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPI2Bulletin",   { "Base.92fordCVPI2", "Base.92fordCVPI" }, "92fordCVPI_" },

    { "Base.87fordB700Ksprison",    { "Base.87fordB700prison", "Base.87fordB700school" }, "87fordB700_" },

    { "Base.92fordCVPIMuldraugh",  { "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPIMeade",      { "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPIBulletin",   { "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPILouisville", { "Base.92fordCVPI" }, "92fordCVPI_" },
    { "Base.92fordCVPIWestPoint",  { "Base.92fordCVPI" }, "92fordCVPI_" },

    { "Base.93chevySilveradoCClongSecurity",   { "Base.93chevySilveradoCClong" }, "93chevySilveradoCClong_" },
    { "Base.93chevySilveradoCClongLouisville", { "Base.93chevySilveradoCClong" }, "93chevySilveradoCClong_" },
    { "Base.93chevySilveradoCClongMuldraugh",  { "Base.93chevySilveradoCClong" }, "93chevySilveradoCClong_" },

    { "Base.93fordF350pdWestPoint",  { "Base.93fordF350" }, "93fordF350_" },
    { "Base.93fordF350pdMuldraugh",  { "Base.93fordF350" }, "93fordF350_" },
    { "Base.93fordF350pdLouisville", { "Base.93fordF350" }, "93fordF350_" },
    { "Base.93fordF350pdMeade",      { "Base.93fordF350" }, "93fordF350_" },
    { "Base.93fordF350pdBulletin",   { "Base.93fordF350" }, "93fordF350_" },
};

local mustExist = {
    { "Base.87fordB700school",   "87fordB700_" },
    { "Base.87fordB700military", "87fordB700_" },
    { "Base.87fordB700prison",   "87fordB700_" },
    { "Base.87fordF700swat",     "87fordF700swat_" },
    { "Base.87fordF700bank",     "87fordF700bank_" },
    { "Base.87fordF700box",      "87fordF700box_" },
    { "Base.87fordF700Lswat",    "87fordF700swat_" },

    { "Base.92amgeneralM998",       "92amgeneralM998_" },
    { "Base.92amgeneralM998Meade",  "92amgeneralM998_" },
    { "Base.92amgeneralM998SWAT",   "92amgeneralM998_" },
};

local function ensureLinked(verbose)
    local C = ISCarMechanicsOverlay and ISCarMechanicsOverlay.CarList;
    if not C then
        if verbose then print("FixPoliceSkins OverlayRegister: ISCarMechanicsOverlay.CarList not available"); end
        return;
    end

    for _, l in ipairs(links) do
        if not C[l[1]] then
            local linked = false;
            for _, src in ipairs(l[2]) do
                if C[src] then
                    C[l[1]] = C[src];
                    linked = true;
                    break;
                end
            end
            if not linked then
                C[l[1]] = { imgPrefix = l[3], x = 10, y = 0 };
                if verbose then print("FixPoliceSkins OverlayRegister: direct-registered " .. l[1] .. " (prefix " .. l[3] .. ")"); end
            end
        end
    end

    for _, e in ipairs(mustExist) do
        if not C[e[1]] then
            C[e[1]] = { imgPrefix = e[2], x = 10, y = 0 };
            if verbose then print("FixPoliceSkins OverlayRegister: guaranteed " .. e[1] .. " (prefix " .. e[2] .. ")"); end
        end
    end

    if verbose then
        for _, e in ipairs(mustExist) do
            local ent = C[e[1]];
            print("FixPoliceSkins state: " .. e[1] .. " -> " .. (ent and (ent.imgPrefix or "entry-present") or "NIL"));
        end
        local missing = {};
        for _, l in ipairs(links) do
            if not C[l[1]] then table.insert(missing, l[1]); end
        end
        if #missing == 0 then
            print("FixPoliceSkins OverlayRegister: all " .. #links .. " variants linked OK");
        else
            print("FixPoliceSkins OverlayRegister: STILL MISSING: " .. table.concat(missing, ", "));
        end
    end
end

Events.OnGameStart.Add(function() ensureLinked(true); end);
ensureLinked(false);