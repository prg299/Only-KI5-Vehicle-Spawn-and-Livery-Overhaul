# Dependencies and load order

This 0.1.0 full-fleet profile requires **89 original Workshop items**. It preserves the private Suite's selected vehicle set; it is intentionally not advertised as a small standalone vehicle pack. The exact module list is public in `config/fleet-profile.ini` and duplicated in `mod.info` for the game. Workshop subscription and mod activation are separate steps.

Load damnlib, the original KI5 vehicles and selected expansion modules, More Car Variants' four modules, Consistent Camo's two modules, and Police Skins B42 Hotfix before `OnlyKI5VehicleSpawnLiveryOverhaul`. If WayMoreCars or VMZNEW is installed, load it before this addon too. They are optional; no server configuration is changed by this project.

Do not enable the private Suite, World Vehicles, Regional Police Skins or No Vanilla selection modules alongside this addon. Disable original `LFPSP` when using the required `LFPSP-B42Fix` as its author directs. Specific Loot and the J10 modules remain excluded from the profile.

More Car Variants has six overlapping script IDs with current KI5 packs. All definitions remain upstream. See `docs/compatibility.md` before acceptance. Its Steam API/page availability discrepancy is a release gate.

## Reducing add-on dependencies

The owner asked whether original implementations could replace these add-ons. This is feasible as separate implementation work: the region routing, spawn policy and military pool normalization are already authored here. A new camo policy can select suitable built-in skins, while an exact visual replacement needs original texture work. More Car Variants can be replaced by authored profession/variant registrations using supported external vehicle contracts, with original assets where needed. Replacing the police-skin dependency needs original liveries plus authored registration/mechanics code. These changes are not implemented in 0.1.0, so the three content add-ons remain required until their replacements are complete and validated. No copied/recolored upstream skin files are proposed for the public source.

The intended result would leave damnlib as the only non-vehicle dependency. This is a proposed target, not the current dependency list.

Recommended implementation order:

| Priority | Replacement | Scope and acceptance |
| --- | --- | --- |
| 1 | Authored camo policy | Prefer suitable existing skins where that meets the intended look. Generate original textures only for missing visual coverage. Check fresh vehicle spawns, burnt variants and preservation of existing vehicles before removing the camo dependency. |
| 2 | Authored profession/variant support | Compare current native variants with the four MCV modules and implement only missing roles. Validate mechanics, loot, armor and profession stories; resolve the six recorded collisions before removing MCV. |
| 3 | Original police livery set | Create distinct jurisdiction liveries for the current regional routing, with explicit city/county, sheriff, state, airport, prison and SWAT roles. Verify UV fit, both sides, damage/blood states and regional spawning in the game before removing the police-skin dependency. |

Treat original artwork, reusable registration code and native acceptance as separate deliverables. These suggestions do not authorize relabeling or copying an upstream texture as an original contribution, and the existing requirements are retained until functional replacements pass their checks.

| Original Workshop item | Workshop ID | Enabled module IDs |
| --- | --- | --- |
| ['04 Volkswagen Touran](https://steamcommunity.com/sharedfiles/filedetails/?id=3478633453) | `3478633453` | `04vwTouran` |
| ['59 Cadillac Miller-Meteor + ECTO-1](https://steamcommunity.com/sharedfiles/filedetails/?id=2772575623) | `2772575623` | `59meteor` |
| ['63 Volkswagen 1300 Beetle](https://steamcommunity.com/sharedfiles/filedetails/?id=3005903549) | `3005903549` | `63beetle` |
| ['63 Volkswagen Type 2 Van](https://steamcommunity.com/sharedfiles/filedetails/?id=3041122351) | `3041122351` | `63Type2Van` |
| ['65 Pontiac Banshee](https://steamcommunity.com/sharedfiles/filedetails/?id=3566868353) | `3566868353` | `65banshee` |
| ['66 Pontiac LeMans / GTO](https://steamcommunity.com/sharedfiles/filedetails/?id=3447272250) | `3447272250` | `66pontiacLeMans` |
| ['67 Cadillac Gage Commando](https://steamcommunity.com/sharedfiles/filedetails/?id=2478247379) | `2478247379` | `67commando` |
| ['67 Shelby GT500 + Eleanor](https://steamcommunity.com/sharedfiles/filedetails/?id=3026723485) | `3026723485` | `67gt500` |
| ['68 Pontiac Firebird](https://steamcommunity.com/sharedfiles/filedetails/?id=3258343790) | `3258343790` | `68firebird` |
| ['69 Chevrolet Camaro](https://steamcommunity.com/sharedfiles/filedetails/?id=2991201484) | `2991201484` | `69camaro` |
| ['69 Dodge Charger](https://steamcommunity.com/sharedfiles/filedetails/?id=3631989559) | `3631989559` | `69charger` |
| ['69 Ford Mustang](https://steamcommunity.com/sharedfiles/filedetails/?id=3756938756) | `3756938756` | `69fordMustang`, `69fordMustangExtra` |
| ['69 Mini Mk2](https://steamcommunity.com/sharedfiles/filedetails/?id=2937786633) | `2937786633` | `69mini`, `69mini_ItalianJob` |
| ['70 Chevrolet Chevelle / El Camino](https://steamcommunity.com/sharedfiles/filedetails/?id=3766571591) | `3766571591` | `70chevelle` |
| ['70 Dodge Challenger](https://steamcommunity.com/sharedfiles/filedetails/?id=2873290424) | `2873290424` | `70dodge` |
| ['70 Ford Escort](https://steamcommunity.com/sharedfiles/filedetails/?id=3670063857) | `3670063857` | `70fordEscort` |
| ['70 Plymouth Barracuda](https://steamcommunity.com/sharedfiles/filedetails/?id=2913633066) | `2913633066` | `70barracuda` |
| ['70 Plymouth Road Runner](https://steamcommunity.com/sharedfiles/filedetails/?id=3642935062) | `3642935062` | `70roadRunner` |
| ['73 Ford Falcon](https://steamcommunity.com/sharedfiles/filedetails/?id=3490370700) | `3490370700` | `73fordFalcon` |
| ['73 NISSAN Skyline GT-R](https://steamcommunity.com/sharedfiles/filedetails/?id=3743371090) | `3743371090` | `73nissanGTR` |
| ['75 Pontiac Grand Prix](https://steamcommunity.com/sharedfiles/filedetails/?id=3213391371) | `3213391371` | `75grandPrix` |
| ['76 Chevrolet K Series](https://steamcommunity.com/sharedfiles/filedetails/?id=3161951724) | `3161951724` | `76chevyKseries`, `76chevyKseriesExpanded` |
| ['76 Chrysler New Yorker](https://steamcommunity.com/sharedfiles/filedetails/?id=3730833846) | `3730833846` | `76chryslerNewYorker` |
| ['77 Pontiac Firebird](https://steamcommunity.com/sharedfiles/filedetails/?id=3346905070) | `3346905070` | `77firebird` |
| ['78 AM General M35 Series Trucks](https://steamcommunity.com/sharedfiles/filedetails/?id=2799152995) | `2799152995` | `78amgeneralM35A2`, `78amgeneralM35A2extra`, `78amgeneralM49A2C`, `78amgeneralM50A3`, `78amgeneralM62` |
| ['78 Lamborghini Countach](https://steamcommunity.com/sharedfiles/filedetails/?id=3726526329) | `3726526329` | `78lamboCountach` |
| ['79 Chevrolet Camaro](https://steamcommunity.com/sharedfiles/filedetails/?id=3703948448) | `3703948448` | `79camaro` |
| ['80 MAN KAT1](https://steamcommunity.com/sharedfiles/filedetails/?id=3248388837) | `3248388837` | `80manKat1` |
| ['81 DeLorean DMC-12](https://steamcommunity.com/sharedfiles/filedetails/?id=3253385114) | `3253385114` | `81deloreanDMC12` |
| ['82 Oshkosh M911 + Military Semi-Trailers](https://steamcommunity.com/sharedfiles/filedetails/?id=2618213077) | `2618213077` | `82oshkoshM911` |
| ['82 Pontiac Firebird](https://steamcommunity.com/sharedfiles/filedetails/?id=3320947974) | `3320947974` | `82firebird`, `82firebirdKITT` |
| ['82 Porsche 911](https://steamcommunity.com/sharedfiles/filedetails/?id=3379334330) | `3379334330` | `82porsche911` |
| ['83 AM General M923](https://steamcommunity.com/sharedfiles/filedetails/?id=2811383142) | `2811383142` | `83amgeneralM923`, `83amgeneralM923extra` |
| ['83 GMC G-Series Vans](https://steamcommunity.com/sharedfiles/filedetails/?id=3799732653) | `3799732653` | `83gmcGseriesVans` |
| ['84 Buick Electra](https://steamcommunity.com/sharedfiles/filedetails/?id=3596903773) | `3596903773` | `84buickElectra` |
| ['84 Cadillac DeVille](https://steamcommunity.com/sharedfiles/filedetails/?id=3592777775) | `3592777775` | `84cadillacDeVille` |
| ['84 Cadillac Gage LAV-300](https://steamcommunity.com/sharedfiles/filedetails/?id=3171184800) | `3171184800` | `84gageV300` |
| ['84 Chevrolet Corvette](https://steamcommunity.com/sharedfiles/filedetails/?id=3684254299) | `3684254299` | `84corvette` |
| ['84 Jeep XJ Cherokee](https://steamcommunity.com/sharedfiles/filedetails/?id=3409287192) | `3409287192` | `84jeepXJ` |
| ['84 Mercedes Benz W460](https://steamcommunity.com/sharedfiles/filedetails/?id=2805630347) | `2805630347` | `84merc` |
| ['84 Oldsmobile 98 Regency](https://steamcommunity.com/sharedfiles/filedetails/?id=3601417745) | `3601417745` | `84oldsmobile98` |
| ['85 Buick LeSabre](https://steamcommunity.com/sharedfiles/filedetails/?id=3418252689) | `3418252689` | `85buickLeSabre` |
| ['85 Chevrolet Caprice / Impala](https://steamcommunity.com/sharedfiles/filedetails/?id=3413704851) | `3413704851` | `85chevyCaprice` |
| ['85 Chevrolet Step-Van](https://steamcommunity.com/sharedfiles/filedetails/?id=3614034284) | `3614034284` | `85chevyStepVan`, `85chevyStepVanexpanded` |
| ['85 Oldsmobile Delta 88](https://steamcommunity.com/sharedfiles/filedetails/?id=3418253716) | `3418253716` | `85oldsmobileDelta88` |
| ['85 Pontiac Parisienne](https://steamcommunity.com/sharedfiles/filedetails/?id=3413706334) | `3413706334` | `85pontiacParisienne` |
| ['86 Chevrolet CUCVs + M101A2 Trailer](https://steamcommunity.com/sharedfiles/filedetails/?id=3428008364) | `3428008364` | `86chevyCUCV` |
| ['86 Ford Econoline E-150 + Pop Culture vans](https://steamcommunity.com/sharedfiles/filedetails/?id=2870394916) | `2870394916` | `86fordE150`, `86fordE150dnd`, `86fordE150expanded`, `86fordE150pd` |
| ['86 Oshkosh P19A + Military Trailers](https://steamcommunity.com/sharedfiles/filedetails/?id=2566953935) | `2566953935` | `86oshkoshP19A` |
| ['87 Buick Regal](https://steamcommunity.com/sharedfiles/filedetails/?id=3226885926) | `3226885926` | `87buickRegal` |
| ['87 Chevrolet Suburban](https://steamcommunity.com/sharedfiles/filedetails/?id=3196180339) | `3196180339` | `87chevySuburban` |
| ['87 Ford B700/F700 Trucks](https://steamcommunity.com/sharedfiles/filedetails/?id=3110911330) | `3110911330` | `87fordB700` |
| ['87 Toyota Corolla AE92](https://steamcommunity.com/sharedfiles/filedetails/?id=3779315249) | `3779315249` | `87toyotaCorolla` |
| ['87 Toyota MR2](https://steamcommunity.com/sharedfiles/filedetails/?id=3052360250) | `3052360250` | `87toyotaMR2` |
| ['88 Chevrolet S10](https://steamcommunity.com/sharedfiles/filedetails/?id=2886832936) | `2886832936` | `88chevyS10` |
| ['88 Toyota Hilux](https://steamcommunity.com/sharedfiles/filedetails/?id=3435796523) | `3435796523` | `88toyotaHilux` |
| ['89 Dodge Caravan](https://steamcommunity.com/sharedfiles/filedetails/?id=3034636011) | `3034636011` | `89dodgeCaravan` |
| ['89 Ford Bronco](https://steamcommunity.com/sharedfiles/filedetails/?id=2886833398) | `2886833398` | `89fordBronco` |
| ['89 Isuzu Trooper](https://steamcommunity.com/sharedfiles/filedetails/?id=2932549988) | `2932549988` | `89trooper` |
| ['89 LAND ROVER Defender](https://steamcommunity.com/sharedfiles/filedetails/?id=3570973322) | `3570973322` | `89defender` |
| ['89 Volvo 200 Series](https://steamcommunity.com/sharedfiles/filedetails/?id=3292659291) | `3292659291` | `89volvo200` |
| ['90 BMW 3 Series (E30)](https://steamcommunity.com/sharedfiles/filedetails/?id=3110913021) | `3110913021` | `90bmwE30` |
| ['90 Ford F350 Ambulance](https://steamcommunity.com/sharedfiles/filedetails/?id=2952802178) | `2952802178` | `90fordF350ambulance` |
| ['90 Pierce Arrow Pumper and Ladder Trucks](https://steamcommunity.com/sharedfiles/filedetails/?id=2942793445) | `2942793445` | `90pierceArrow` |
| ['91 Ford LTD Crown Victoria / Country Squire](https://steamcommunity.com/sharedfiles/filedetails/?id=3366300557) | `3366300557` | `91fordLTD` |
| ['91 Ford Ranger](https://steamcommunity.com/sharedfiles/filedetails/?id=3539691958) | `3539691958` | `91fordRanger` |
| ['91 Geo Metro](https://steamcommunity.com/sharedfiles/filedetails/?id=3008795514) | `3008795514` | `91geoMetro` |
| ['91 Lexus LS400](https://steamcommunity.com/sharedfiles/filedetails/?id=3770890864) | `3770890864` | `91lexusLS400` |
| ['91 Nissan 240SX](https://steamcommunity.com/sharedfiles/filedetails/?id=3504401781) | `3504401781` | `91nissan240sx` |
| ['91 RANGE ROVER Classic](https://steamcommunity.com/sharedfiles/filedetails/?id=2409333430) | `2409333430` | `91range` |
| ['92 AM General M998 + M101A3 Cargo trailer](https://steamcommunity.com/sharedfiles/filedetails/?id=2642541073) | `2642541073` | `92amgeneralM998`, `92amgeneralM998extra` |
| ['92 Ford Crown Victoria](https://steamcommunity.com/sharedfiles/filedetails/?id=2962175696) | `2962175696` | `92fordCVPI` |
| ['92 Jeep YJ Wrangler](https://steamcommunity.com/sharedfiles/filedetails/?id=3287727378) | `3287727378` | `92jeepYJ` |
| ['92 NISSAN Skyline GT-R (R32)](https://steamcommunity.com/sharedfiles/filedetails/?id=2846036306) | `2846036306` | `92nissanGTR` |
| ['93 Chevrolet Suburban / Silverado](https://steamcommunity.com/sharedfiles/filedetails/?id=3152529790) | `3152529790` | `93chevySuburban`, `93chevySuburbanExpanded` |
| ['93 Ford F-Series](https://steamcommunity.com/sharedfiles/filedetails/?id=3073430075) | `3073430075` | `93fordF350` |
| ['93 Ford Mustang](https://steamcommunity.com/sharedfiles/filedetails/?id=3001592312) | `3001592312` | `93mustangSSP` |
| ['93 Ford Taurus](https://steamcommunity.com/sharedfiles/filedetails/?id=3088951320) | `3088951320` | `93fordTaurus` |
| ['95 Subaru Impreza WRX STI](https://steamcommunity.com/sharedfiles/filedetails/?id=3647735736) | `3647735736` | `95impreza` |
| ['96 Mitsubishi Lancer EVO IV](https://steamcommunity.com/sharedfiles/filedetails/?id=3647736504) | `3647736504` | `96lancerEVO` |
| ['96 Saturn S Series](https://steamcommunity.com/sharedfiles/filedetails/?id=3679880253) | `3679880253` | `96saturnSseries` |
| ['98 Nissan Stagea 260RS Autech](https://steamcommunity.com/sharedfiles/filedetails/?id=3315443103) | `3315443103` | `98stagea` |
| ['99 Ford Crown Victoria Police Interceptor](https://steamcommunity.com/sharedfiles/filedetails/?id=2971246021) | `2971246021` | `99fordCVPI` |
| [[Abandoned] More Car Variants (KI5)](https://steamcommunity.com/sharedfiles/filedetails/?id=3455267136) | `3455267136` | `MCV67commando`, `MCV76chevyKseries`, `MCV86chevyCUCV`, `MCV93fordFseries` |
| [[B42.20Fix] Lore-Friendly Police Skins For KI5 Vehicles - Beta 0.5](https://steamcommunity.com/sharedfiles/filedetails/?id=3797166280) | `3797166280` | `LFPSP-B42Fix` |
| [Campers!](https://steamcommunity.com/sharedfiles/filedetails/?id=3670064951) | `3670064951` | `KI5campers` |
| [Consistent Camo for Military Vehicles](https://steamcommunity.com/sharedfiles/filedetails/?id=3309256818) | `3309256818` | `KI5Camo`, `PapaChadCamo` |
| [that DAMN Library](https://steamcommunity.com/sharedfiles/filedetails/?id=3171167894) | `3171167894` | `damnlib` |
| [Trailers!](https://steamcommunity.com/sharedfiles/filedetails/?id=3330403100) | `3330403100` | `KI5trailers` |
