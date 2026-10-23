# Architecture

`config/fleet-profile.ini` declares the supported full fleet independently of any private server. `scripts/generate-fleet-catalog.ps1` selects the compatible versioned/read-only Workshop definitions, identifies declared vehicle IDs, excludes disabled-only optional variants, merges observed distribution facts and generates `KI5KnoxCountyFleet_Catalog.lua` plus `ki5-provider-inventory.json`. It never imports upstream files into the package.

The Catalog owns vehicle groups, exclusions, rarity and weighted candidate lists. SpawnAliases owns exact replacements (including news vans and trailers); PoliceRegions owns jurisdiction/livery roles. Runtime applies the shared policy late in `OnLoadMapZones` and `OnLoadedMapZones`, after WayMoreCars/VMZ mutation. It wraps audited `addVehicleDebug` inputs and has a final pre-creation guard. SmashedPolice removes bypass aliases. PoliceSpawnRouting corrects coordinate-bearing newly created police vehicles through the same regional authority. PoliceLightbars is a separate inherited multiplayer/server spawn-end policy.

All authored runtime filenames, require paths, globals, generated distribution names and modData keys use `KI5KnoxCountyFleet` / `knox_fleet`. Original `Base.*` vehicle IDs and dependency module names are external contracts and must not be renamed. The mod ID is new: do not run the private predecessor alongside it and do not treat it as an automatic save migration.

The package is Lua, descriptors, generated branding and license/credit text. Builds and native checks need locally installed game code, which stays outside Git. The generated Catalog is committed so the public source can be inspected without a proprietary installation.
