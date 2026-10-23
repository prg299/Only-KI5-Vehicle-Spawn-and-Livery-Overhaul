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

`validate-lua.ps1` uses the installed game's Kahlua compiler for authored and integrated Lua. `test-spawn-policy.ps1` executes eleven scenarios: six final-policy scenarios across three table orders and shared/copied highway tables, an integrated scenario executing the actual VMZ zone-registration/distribution modules before the final policy, a native-world fixture executing all four imported recipes through the authored helpers and production callbacks, and emergency-parking/silent-lightbar regressions for server, single-player and joined-client authority. The fixtures mock native game services; no YAPZLib loader or mock is provided. They cover checkpoint reservation/resumption, old-chunk/client/day restrictions, occupied/unloaded footprints, failure/no-respawn, sandbox re-enablement, native operation dispatch, station aliases, lightbar idempotence and saved/unrelated vehicle preservation. This is functional Lua coverage, not native vehicle-generation proof. `check-native-world-api.ps1` verifies 32 exact installed-build API signatures without creating a world. The installed game has the owner's PZ_Optimization compiler/table overrides; validation records must disclose that environment. `validate-stage.ps1` invokes the game's read-only uploader validator without Steam initialization, login or upload.

The 0.3.1 documentation review compares the working tree with merge base `628b0e2e6e8bf5b72b917e90fc2a93548df79d28` on origin/main. Runtime script discovery selects the active B42 layer plus common/media, excluding legacy B41 root-media definitions from versioned mods. This matches the native ScriptManager registry and leaves 531 selectable IDs. Missing AM General burnt definitions cannot establish a burnt-truck family weighting; the generator uses available native wrecks instead. Emergency-station classification reads native ParkingStall names before broad map metadata. Only damnlib and More Car Features remain required external non-vehicle mods. Authored MIT code and imported contributions have separate licensing boundaries.

Imported source whitespace is retained apart from LF normalization; upstream trailing spaces/mixed indentation are not an authored formatting change. Review authored diffs separately from manifest-listed imports. Per-file output hashes protect those imports across Git checkouts.

`dev/native-session.py` owns the complete guarded native lifetime, copies the explicit fleet profile and candidate source into disposable caches, and uses inactive Windows desktops. It hashes candidate files and test adapter inputs. Set `ONLY_KI5_ACCEPTANCE_RVI_DIR` to a local Real Vehicle Interiors checkout containing its MIT developer endpoint/input/framebuffer sources and desktop keeper; its bundled JDK 25 compiles the test adapter. ZombieBuddy is a test-only dependency. `native-command.py` serializes actions inside the already guarded lifetime; `native-server.py` uses its admin-only server bridge. `native-mp-connect.py` supplies fixture credentials and clicks the real character-creation buttons. `--resume` copies only a stopped owned profile and requires a clean multiplayer server exit. Credentials, crash logs and raw artifacts stay ignored under build/native. Native snapshots must iterate the Build 42 vehicle Set rather than indexing it as a list. See [native acceptance](native-acceptance.md) for evidence and remaining limits.
