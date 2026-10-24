# Compatibility and merge decisions

Target: installed Project Zomboid 42.21.0, revision `4a0e9546ec`, Steam build `25485521`, observed 2026-10-23. Upstream updates can invalidate a previously passing catalog or native test.

The importer omits six old More Car Variants vehicle files so newer external KI5 definitions win, preserving the private Suite's source-priority rule. It verifies the current base definitions exist before filtering, rejects mixed unique/overlapping files and rejects new collisions. Imported Lua references use canonical base spelling, including `Base.76chevyK20brickingIt`. These structural checks do not replace native mechanics/armor/new-vehicle acceptance.

| Overlapping source vehicle ID | Retained KI5 provider | Omitted integrated MCV provider |
| --- | --- | --- |
| `Base.76chevyK20brickingit` | `76chevyKseriesExpanded` | `MCV76chevyKseries` |
| `Base.76chevyK20helton` | `76chevyKseriesExpanded` | `MCV76chevyKseries` |
| `Base.76chevyK20utility` | `76chevyKseries` | `MCV76chevyKseries` |
| `Base.76chevyK30CCutility` | `76chevyKseries` | `MCV76chevyKseries` |
| `Base.86chevyM1010` | `86chevyCUCV` | `MCV86chevyCUCV` |
| `Base.67commando` | `67commando` | `MCV67commando` |

Only the selected addon vehicle definitions are distributed. No base KI5 definition or framework is copied. The six overlaps are explicit in `config/merge-rules.json` and the import manifest. Police shared/versioned files have 84 identical overlaps and one reviewed Build 42 mechanics-overlay replacement; the selected versioned file wins, matching the upstream layering. MCV English names are merged into one table. Imported ownership and source hashes remain recorded; third-party material is excluded from MIT.

The guarded 57-ID duplicate-suppression set is restored from No Vanilla Vehicles. This remains a KI5-only supported profile; it is not a general Filibuster compatibility promise. New vehicles appear only in fresh chunks; existing vehicles and saves are not rewritten. Disable all integrated originals (including LFPSP, its hotfix and VMZNEW) and the predecessor integrations. More Car Features / WayMoreCars and damnlib are the only non-vehicle external requirements. YAPZLib is replaced by authored native world helpers, with no library code copied. It is not incompatible: other enabled mods may still need it independently. No active server settings, playsets or subscriptions are changed by this repository.

The integrated VMZ registration and pool callbacks are explicitly required before the final policy callbacks. Twenty-three mocked production-Lua scenarios cover final policy, actual integrated VMZ registration/pools, all four military recipes using the authored world helpers, emergency-parking/lightbar decisions under server, single-player and client authority, and weighted Humvee liveries with client exclusion. The native API checker verifies installed method signatures only. Native gameplay and dedicated-server observations are recorded in [native acceptance](native-acceptance.md). Construction and registration checks do not establish every armor installation, trailer-driving behavior, sandbox UI combination or third-party map combination.

The selected B42 version plus common/media determines catalog eligibility. Legacy B41 root-media definitions are excluded from versioned modules: TrailerM1082tarp, TrailerM1095tarp, 78amgeneralM35A2Burnt and 83amgeneralM923Burnt are absent in this installed B42 runtime. The catalog uses 531 real IDs. Active military trucks retain 75% AM General weighting; burnt trucks use available native wreck definitions rather than missing AM General IDs. Highway military weight remains capped at 0.25% of ordinary weight, including when WayMoreCars aliases directional jams to one table. Native highway truck weighting is inapplicable when the upstream highway pool contains no truck role.


## 0.3.4 optional vehicle packs

The candidate requires only damnlib and WayMoreCars. Vehicle packs are optional and retain ordering edges when enabled. Native script existence alone is insufficient: the shared availability boundary also checks the owning module, excluding inert bundled variants and disabled providers. Ordinary missing body styles can use available ordinary KI5 cars; missing specialist roles stay empty. With no KI5 packs all managed new-vehicle pools are empty. Existing saved vehicles are unchanged. Keep installed vehicle packs enabled for saves that already contain their models; this feature does not migrate removed models. The [optional-fleet audit](optional-fleets.md) separates passed zero/single/full initialization checks from the pending mixed-fleet multiplayer gate.

## 0.3.3 sandbox and final pool policy

The ONLY KI5 page adds custom civilian/novelty original-weight percentage (0.025), police lights chance (50), Humvee military-car share (95) and AM General military-truck share (75). Police/military/emergency liveries are exempt from the civilian modifier. Existing vehicles are unchanged; selection changes require a world restart. Fractional profession selection delegates unmanaged paths to vanilla and retains unique/alternate behavior. Other mods replacing the same native profession callbacks later can bypass the recorded authority; those combinations require separate testing.

Optional Town Car/limo and Elgin packs were added only to the audit profile, without adding player dependencies or bundling their files. The source/classification policy fixes pool roles, normalizes malformed IDs, detaches the Louisville highway alias and keeps reserved empty pools empty. The complete registry and native receipts are recorded in the dated spawn audit when finalized.
