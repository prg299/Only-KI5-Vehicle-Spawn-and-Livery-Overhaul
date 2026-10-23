# Public-release permission audit

Checked 2026-10-23: **93 related Workshop items**, including the original police pack, its B42 hotfix, More Car Variants, Consistent Camo, No Vanilla Vehicles, KI5 vehicles, damnlib and the author's two historical integrations. Machine-readable results and description hashes: `permissions-audit.json`.

Method: Valve's public published-file-details API, public Workshop descriptions where available, and license/readme/credit filenames in downloaded copies. Automated matching found explicit restrictions in 86 item records. This is a point-in-time source audit, not a complete audit of comment histories, linked Discord rules or unpublished private permissions. No missing prohibition was treated as a redistribution license.

| Source | Finding | Public disposition |
| --- | --- | --- |
| KI5 vehicle packs | Repacking prohibited; modification/extension requires permission | External originals only. Their identifiers are referenced by authored selection code; no definitions, models, skins, audio or animation files copied. |
| that DAMN Library, KI5 and bikinihorst | Same repacking restriction and permission requirement | External transitive runtime requirement of the vehicles. This addon does not modify or extend damnlib's code/API. |
| More Car Variants, Пупсич, 3455267136 | No explicit redistribution license established. API returned 9, public page title and indexed description readable. | External dependency; new-account download availability remains unverified. |
| Consistent Camo, Branco, 3309256818 | No explicit redistribution license established in reviewed description/files | External dependency, both KI5Camo and PapaChadCamo; no textures copied. |
| Police skins original, Old Killer, 3395145553 | No explicit redistribution license established | Credit original skin author; original pack is not enabled alongside hotfix. |
| Police skins B42 hotfix, Aurora, 3797166280 | Hotfix description credits 3395145553 and promises removal on author return or infringement | External dependency; credit Aurora and Old Killer; no artwork/code copied. Dependency may be withdrawn upstream. |
| No Vanilla Vehicles, Kraz, 2535461640 | No explicit redistribution license established | Inspiration credit only. No upstream files or extracted duplicate-suppression list included; authored late selection replaces its role. |
| Erika's private Suite and regional integration | User authorized creating this new public derivative; the old third-party permission record covered an unlisted release | Only authored Lua algorithms/tools and observed identifier facts carried forward under a new mod identity. Old package/assets never uploaded to GitHub. |

The license is MIT only for authored contributions. Dependency licenses, ownership and trademarks remain with their respective creators. Recheck terms and dependency hashes before a Workshop release and after upstream updates.
