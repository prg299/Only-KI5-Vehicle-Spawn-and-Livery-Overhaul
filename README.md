# ONLY KI5: Vehicle Spawn & Skins

Put KI5 on Kentucky's roads. **ONLY KI5: Vehicle Spawn & Skins** brings KI5-only traffic, regional police liveries, profession vehicles, roadside stories and military fleet tuning together for **Project Zomboid Build 42.21**.

![ONLY KI5: Vehicle Spawn & Skins](release/workshop/only-ki5-overhaul-preview.png)

The [public Workshop item](https://steamcommunity.com/sharedfiles/filedetails/?id=3825999183) has fourteen reviewed location-labelled natural gameplay images: seven regional police/security scenes (one sheriff location), the two approved military scenes, Louisville highway and four civilian/profession scenes. [Capture sources](docs/workshop-gallery.md) and [public replacement records](docs/public-release-20261024.md) are separate from gameplay acceptance.

**0.3.3 — civilian spawn options and pool balance audit.** Community integration by Erika (prg299), based on the author's private Vehicle Suite 1.1.4. Includes attributed More Car Variants, Consistent Camo, police skins/hotfix, Vehicle Military Zones and No Vanilla duplicate-selection data. Original KI5 vehicles, damnlib and More Car Features remain external. Authored native world helpers replace YAPZLib; no separate support library is needed. See [spawn settings and pool audit](docs/spawn-policy.md) and [native acceptance](docs/native-acceptance.md). The internal mod ID remains stable. The previous unlisted item 3825545131 was deleted after the new public item was verified; the private predecessor 3806374180 is protected.

## What it does

- Replaces normal, crash, profession/story and audited direct vanilla vehicle selections through one late server-side KI5 catalog.
- Adds **Custom civilian and novelty weight (%)**, default **0.025% of original spawn weights**, even when skin packs are enabled. Set 0 to disable these variants, or 100 for original weights. Police, military and emergency liveries stay enabled.
- Favors ordinary cars on Louisville highway and keeps optional limousines, Elgin sweepers and other specialty vehicles rare in broad traffic. Dedicated service and military pools keep their roles.
- Routes police liveries by region, including Louisville city/county, Muldraugh, Meade, West Point, airport and prison roles.
- Keeps the private Suite's defaults: 95% Humvee within military cars, 75% AM General within military trucks, a preferred M35A2 transport share and 95% white EMS F350 within ambulance choices. These are candidate-pool shares, not a promise that 95% of all spawned vehicles are military.
- Requires More Car Features / WayMoreCars and preserves its highway aliases. Integrated Vehicle Military Zones supplies military locations, split pools, sandbox settings and four road-story recipes. Internal authored helpers use native game APIs for zones, angled parking and scene construction/scheduling.
- Adds **Police lights chance (%)**, default **50**, **Humvee spawn chance (%)**, default **95**, and **AM General military trucks (%)**, default **75**, to the ONLY KI5 sandbox page. All accept 0–100. The Humvee setting controls military light-car selection, including wrecks; truck proportions and skin rarity remain separate. Restart after changing selection settings; existing vehicles are unchanged.
- In single-player and multiplayer, eligible newly spawned police vehicles can have silent flashing lights outside dedicated emergency stations. The spawn policy clears siren modes before every station, saved-decision and existing-light check.
- Weights new Humvee liveries: 95% ordinary military paint, 4% medic and 1% JTF with the eight-skin profile. Existing vehicles keep their skins.
- Leaves existing saved vehicles/chunks unchanged. Changes affect newly generated vehicles.

## Install

The Workshop page requires only **damnlib** and **More Car Features / WayMoreCars**. Install the vehicles separately from the [KI5 collection](https://steamcommunity.com/workshop/filedetails/?id=2490220997), then enable this mod after them. The unchanged full-fleet runtime descriptor still needs its vehicle modules installed/enabled; the complete 87-item / 102-module input inventory is in [dependencies](docs/dependencies.md) and `config/fleet-dependencies.json`. Vehicle packs are no longer individual Workshop relationships. YAPZLib is neither required nor bundled; keep it enabled if another mod needs it. Disable the integrated originals: all four MCV modules, both Consistent Camo modules, original LFPSP and its B42 hotfix, VMZNEW, No Vanilla selection modules, and the private Suite/World Vehicles/Regional Police integrations. They would duplicate this package's registrations or assets.

For a manual test install, copy `mod/OnlyKI5VehicleSpawnLiveryOverhaul` to your own `Zomboid/mods` directory. Use a disposable world first. No automatic deployment, subscription or server/playset changes are performed by these tools. Replacing the old mod in an established server needs its own backed-up migration/acceptance pass.

**Highly recommended:** [KI5 Vehicle Performance Patch (Unofficial)](https://steamcommunity.com/sharedfiles/filedetails/?id=3808100388) by lucygoosey. It is optional and remains external; follow its server/client setup instructions. It was not part of this candidate's native acceptance profile.

## Development

Requires PowerShell 7, Python 3.10+, JDK 25 for the native uploader adapter, and local read-only Project Zomboid/Workshop downloads. Set `PZ_GAME_DIR` and `PZ_WORKSHOP_DIR` when they differ from the documented Windows defaults, and `ONLY_KI5_JAVA_HOME` to your JDK 25 root when it is not your default compiler. `config/fleet-profile.ini` is the explicit public input; your server configuration is never read.

On this workstation, use the shared PZ coordinator at `D:/Stuff/Projects/Game Mods/games/project-zomboid/tools/run-mod-test.mjs`; its instructions are in the adjacent `TESTING.md`. It serializes native sessions across projects and delegates to the owner-required resource guard. Bounded controls attach to their registered native lifetime; do not start a second game session while another project owns the native turn.

```powershell
$coord = 'D:/Stuff/Projects/Game Mods/games/project-zomboid/tools/run-mod-test.mjs'
node $coord run --kind build --name ki5-import -- python scripts/import-content.py
node $coord run --kind build --name ki5-catalog -- pwsh -NoProfile -File scripts/generate-fleet-catalog.ps1
node $coord run --kind build --name ki5-metadata -- python scripts/sync-release-metadata.py
node $coord run --kind check --name ki5-repository -- python scripts/check-repository.py
node $coord run --kind check --name ki5-lua -- pwsh -NoProfile -File scripts/validate-lua.ps1
node $coord run --kind check --name ki5-policy -- pwsh -NoProfile -File scripts/test-spawn-policy.ps1
node $coord run --kind check --name ki5-api -- pwsh -NoProfile -File scripts/check-native-world-api.ps1
node $coord run --kind build --name ki5-stage -- python scripts/stage-workshop.py
node $coord run --kind check --name ki5-stage-check -- pwsh -NoProfile -File scripts/validate-stage.ps1
```

After reviewing upstream changes, run `scripts/import-content.py` before regenerating the catalog. It reads only the sources in `config/bundled-sources.json`, preserves file provenance, merges localization, filters six reviewed stale MCV definitions, remaps military helper imports to authored native implementations, and replaces only its unchanged manifested outputs. It never reads a private server configuration. Imported art retains upstream bytes and is not regenerated.

CI runs the portable repository and PowerShell parser checks without proprietary game files. It cannot run the installed-game Lua/compiler or native gameplay checks. Other contributors can invoke those scripts with their own resource-management setup; the guard path above is specific to the author's workstation.

`mod/` contains the deliverable. `scripts/` owns generation/check/stage tools; `tools-src/` holds authored harnesses and artwork masters; `dev/` owns isolated native acceptance drivers; `config/` pins selected modules; `docs/` records architecture, source/rights evidence and acceptance gaps; `release/workshop/` contains fresh-item metadata. Build/test output remains ignored under `build/`.

## License and status

[MIT](LICENSE) for authored contributions only. Integrated third-party code, data and assets listed in `docs/imported-content.json` retain their original ownership and are excluded from MIT. Read [credits](CREDITS.md), [third-party notices](THIRD_PARTY_NOTICES.md), [compatibility](docs/compatibility.md) and [release readiness](docs/release-readiness.md). This addon is not affiliated with or endorsed by KI5 or The Indie Stone.

**Original authors:** if you prefer your integrated content to be distributed separately, contact Erika/prg299 through Steam or a [GitHub issue](https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/issues). The integrated copy will be removed and your original mod made an external dependency, with credits and load-order instructions retained.
