# Humvee livery weights

0.3.2 weights newly created `Base.92amgeneralM998` Humvees on the spawning authority. The eight-skin layout uses 95% ordinary paint, 4% medic and 1% JTF. These are per-vehicle chances; a small checkpoint can still contain several special vehicles by chance.

| Native index | Loaded texture suffix | Weight |
| --- | --- | --- |
| 0 | USMCgreen | 20% |
| 1 | NATOgreen | 20% |
| 2 | DesertTan | 5% |
| 3 | merdc_winter, integrated JTF markings | 1% |
| 4 | merdc_summer, integrated medic markings | 4% |
| 5 | camo | 25% |
| 6 | camoCombo | 15% |
| 7 | black, integrated woodland replacement | 10% |

Indices were audited against the installed KI5 M998 script's eight-skin order and the actual integrated PNGs. The native Build 42.21 registry reported eight skins in the tested profile. The alternative six-skin B42 definition omits both merdc entries and uses ordinary paint weights 20/20/5/30/15/10. Unrecognized skin counts are left alone pending an upstream audit. SWAT, sheriff Humvees and burnt wrecks are excluded.

`OnlyKI5VehicleSpawnLiveryOverhaul_SpawnSkins` runs from the existing final OnSpawnVehicleStart routing callback after aliases resolve, before native creation. It returns immediately on joined clients and already-created vehicles, and stores the selected zero-based index in vehicle mod data. Repeated callbacks cannot reroll even index 0. Existing saved vehicles without that marker are also left alone. No part, loot, armor, physics, lightbar or siren code changes.

The exhaustive production-Lua fixture checks all 100 roll values, client exclusion, six/eight layouts, unknown layouts, special-script exclusions, repeated decisions and created-vehicle preservation. Focused native SP/MP and persistence receipts are recorded separately in the version-specific validation directory; random fixture counts are not claimed as a measured population frequency.
