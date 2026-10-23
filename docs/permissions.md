# Public-release permission audit

Checked 2026-10-23: **96 related Workshop items**, including the original police pack, its B42 hotfix, More Car Variants, Consistent Camo, No Vanilla Vehicles, Vehicle Military Zones, More Car Features, YAPZLib, KI5 vehicles, damnlib and the author's historical integrations. Machine-readable results and description hashes: `permissions-audit.json`.

Method: Valve's public published-file-details API, public Workshop descriptions/badges and local text headers. This is a point-in-time source audit, not a complete audit of comment histories, linked Discord rules or unpublished private permissions. The owner requested public integration of the addons with linked attribution and conversion to external dependencies on author request. This directive is recorded separately from author permission; it is not represented as an individual public grant from each creator.

The [TIS permissions guide](https://theindiestone.com/forums/topic/2530-mod-permissions/) describes attribution as its default where no other terms are specified. The [published modding policy](https://projectzomboid.com/blog/modding-policy/) requires necessary permissions for third-party material. Silent addon descriptions are recorded as unspecified rather than as an explicit prohibition. Integration uses the owner's requested attribution/default-permissions approach, retains upstream ownership and grants no third-party MIT sublicense.

| Source | Finding | Public disposition |
| --- | --- | --- |
| KI5 vehicle packs | Repacking prohibited; modification/extension requires permission | External originals only. Their identifiers are referenced by authored selection code; no definitions, models, skins, audio or animation files copied. |
| that DAMN Library, KI5 and bikinihorst | Same repacking restriction and permission requirement | External transitive runtime requirement of the vehicles. This addon does not modify or extend damnlib's code/API. |
| More Car Variants, Пупсич, 3455267136 | No reuse terms found in reviewed description/local text. API returned 9; public page readable. | Four modules integrated with attribution; six stale definitions filtered; source hashes retained. |
| Consistent Camo, Branco, 3309256818 | No reuse terms found in reviewed description/local text | Both texture modules integrated with attribution. |
| Police skins original, Old Killer, 3395145553 | No reuse terms found in reviewed description | Original author credited for skins supplied through the hotfix source. |
| Police skins B42 hotfix, Aurora, 3797166280 | Credits the original and promises removal on author return or infringement; no onward grant stated | Selected content integrated; Aurora and Old Killer credited; original ownership retained. |
| No Vanilla Vehicles, Kraz, 2535461640 | No reuse terms found in reviewed description/local text | Authored selection implementation plus attributed extracted duplicate-ID data. |
| Vehicle Military Zones, Пупсич, 3436499337 | Documents making compatibility addons; no separate republishing terms found | Selected Build 42 content integrated with attribution. |
| More Car Features / WayMoreCars, GamestaMechanic, 3520758551 | MODS-03 badge links the TIS ask-permission category | Required external dependency; no files copied. |
| YAPZLib, Пупсич, 3624971238 | Description expressly allows using the library for mods | Historical upstream reference only. Replaced by authored native world helpers; neither required nor bundled, no library files copied. |
| Erika's private Suite and regional integration | User authorized creating this new public derivative; the old third-party permission record covered an unlisted release | Only authored Lua algorithms/tools and observed identifier facts carried forward under a new mod identity. Old package/assets never uploaded to GitHub. |

The license is MIT only for authored contributions. Integrated and external content ownership, terms and trademarks remain with their creators. Per-file source/output hashes, selected version layers and exclusions are in `imported-content.json`. Recheck terms and hashes before a Workshop release and after upstream updates.

Original authors may contact Erika/prg299 through Steam or [GitHub issues](https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/issues) to request removal of their integrated copy and conversion to an external dependency. This commitment appears in the Workshop description, README and shipped credits/notices.
