# Development and regeneration

Keep the source, test profile, uploader stage and subscribed Workshop copies distinct. This project lives at `D:\Stuff\Projects\Only-KI5-Vehicle-Spawn-and-Livery-Overhaul`; the author's installed game and original Workshop inputs are read-only at `C:\SteamLibrary\steamapps\common\ProjectZomboid` and `C:\SteamLibrary\steamapps\workshop\content\108600`. Optional local deployment is `C:\Users\erika\Zomboid\mods\OnlyKI5VehicleSpawnLiveryOverhaul`; this task does not populate it or change enabled mod lists.

The default project-local stage is `build/workshop/OnlyKI5VehicleSpawnLiveryOverhaul`. Keeping it outside the player's `Zomboid/Workshop` prevents an unpublished uploader copy from shadowing a subscribed release, a lesson from Real Vehicle Interiors. Stage preparation fails when a stage already exists rather than overwriting a release receipt.

## Naming

| Surface | Current name |
| --- | --- |
| Display title | Only KI5: Vehicle Spawn & Livery Overhaul |
| Repository and source folder | `Only-KI5-Vehicle-Spawn-and-Livery-Overhaul` |
| Mod ID and Lua filename prefix | `OnlyKI5VehicleSpawnLiveryOverhaul` |
| Generated distribution prefix | `only_ki5_overhaul` |
| Artwork filename prefix | `only-ki5-overhaul` |
| JDK environment setting | `ONLY_KI5_JAVA_HOME` |
| Workspace project record | `only-ki5-vehicle-spawn-livery-overhaul` |

The repository check rejects former branding in active owned filenames and text. Original art prompts/masters remain in `tools-src/art/archive`; obsolete local uploader stages and browser evidence are under `build/history/initial-brand`. Those records preserve the actual names used when the evidence was produced. Dependency identifiers, upstream credits and historical source identities are external contracts/provenance rather than project branding.

## Validation

After reviewing upstream updates, run `scripts/import-content.py`, `scripts/generate-fleet-catalog.ps1` and `scripts/sync-release-metadata.py` in that order. Review per-file source/output hashes, selected version-layer precedence, newly discovered IDs, disabled-only variants and collisions. The importer uses `config/bundled-sources.json` and replaces only unchanged manifested outputs; imported Lua and helper requires are namespaced while upstream asset IDs and sandbox keys remain intact. The generator resolves the selected public profile, never a live server config.

`validate-lua.ps1` uses the installed game's Kahlua compiler for authored and integrated Lua. `test-spawn-policy.ps1` executes six final-policy scenarios across three table orders and shared/copied highway tables, plus an integrated scenario executing the actual VMZ zone-registration/distribution modules before the final policy. Game/YAPZ services are mocked; this is automated integration coverage, not native vehicle-generation proof. The installed game has the owner's PZ_Optimization compiler/table overrides; validation records must disclose that environment. `validate-stage.ps1` invokes the game's read-only uploader validator without Steam initialization, login or upload.

The 0.2.0 architecture/documentation review compares the working tree with merge base `fc01d864872d7d84f506f5ead4dcbb7c8c47b5ae` on origin/main. The change moves addon ownership/loading from separate dependencies into attributed manifested content, with explicit VMZ callback ordering and three required external non-vehicle mods. Authored MIT code and imported contributions have separate licensing boundaries.

Imported source whitespace is retained apart from LF normalization; upstream trailing spaces/mixed indentation are not an authored formatting change. Review authored diffs separately from manifest-listed imports. Per-file output hashes protect those imports across Git checkouts.

Before release, use a disposable new world and test original dependency vehicles and all variant modules, regional police, mechanics/armor, new chunks, highway wrecks, independent light/truck roles, direct-spawn stories, joining clients, reloads and existing-vehicle preservation. Capture native logs, frame/readiness markers, real production inputs and visuals through an isolated project-owned harness. Do not take over the owner's desktop or change the active server/load order. No reusable isolated native full-fleet acceptance driver is established for this addon yet.
