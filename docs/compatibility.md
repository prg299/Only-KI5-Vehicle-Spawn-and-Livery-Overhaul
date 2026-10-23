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

The guarded 57-ID duplicate-suppression set is restored from No Vanilla Vehicles. This remains a KI5-only supported profile; it is not a general Filibuster compatibility promise. New vehicles appear only in fresh chunks; existing vehicles and saves are not rewritten. Disable all integrated originals (including LFPSP, its hotfix and VMZNEW) and the predecessor integrations. More Car Features / WayMoreCars, damnlib and YAPZLib are required external mods. No active server settings, playsets or subscriptions are changed by this repository.

The integrated VMZ registration and pool callbacks are explicitly required before the final policy callbacks. Seven mocked production-Lua scenarios cover final policy and actual integrated VMZ registration/pool execution. Native map placement, military stories, sandbox UI, police skins, armor, saves/reloads, dedicated servers and joined multiplayer still need acceptance in an isolated world.
