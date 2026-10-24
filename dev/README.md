# Isolated native acceptance

These developer tools never ship in the player mod. They require the installed game, selected Workshop downloads, a local Real Vehicle Interiors checkout with its MIT test adapters/desktop keeper, and JDK 25. Set `PZ_GAME_DIR`, `PZ_WORKSHOP_DIR`, `ONLY_KI5_ACCEPTANCE_RVI_DIR` and `ONLY_KI5_JAVA_HOME` to override defaults. The test-only ZombieBuddy module must also be installed. It is not a player dependency.

On the author's workstation, use the shared PZ test coordinator and its `games/project-zomboid/TESTING.md` instructions. It delegates to the resource guard and reserves the native turn across projects. Use the resolved Python executable rather than the WindowsApps alias:

```powershell
$py = 'C:/Users/erika/AppData/Local/Python/pythoncore-3.14-64/python.exe'
$coord = 'D:/Stuff/Projects/Game Mods/games/project-zomboid/tools/run-mod-test.mjs'
node $coord run --kind multiplayer --name ki5-owned-mp -- $py dev/native-session.py --run owned-mp-check --mp --minutes 35
```

Wait for `NATIVE_REVIEW_READY`. In another terminal, run each command sequentially. The parent owns the server, both inactive desktops and their process trees until stop or deadline:

```powershell
node $coord run --kind check --name ki5-connect-a --attach ki5-owned-mp -- $py dev/native-mp-connect.py owned-mp-check a
node $coord run --kind check --name ki5-connect-b --attach ki5-owned-mp -- $py dev/native-mp-connect.py owned-mp-check b
node $coord run --kind check --name ki5-military-check --attach ki5-owned-mp -- $py dev/check-military-multiplayer.py owned-mp-check
node $coord run --kind check --name ki5-stop --attach ki5-owned-mp -- $py dev/native-command.py owned-mp-check stop
```

`--reuse <stopped-run>` deliberately reuses frozen owned dependency copies; remove it to copy current downloads. Candidate source is always copied fresh. `--resume <stopped-run>` copies saved owned profiles, and requires a clean dedicated-server exit for MP. Connect both clients again, then use `check-military-reload.py <run> --baseline <previous-run>` to compare persistent scene/vehicle identities, translated names and actual mechanics UI. Never run overlapping broker commands: request/response files are intentionally serialized.

For SP, omit `--mp`, create a disposable world using `native-command.py <run> lua --file dev/new-world.lua`, wait for completed loading, then dispatch `MEMCNativeLab.clickToStart();GameWindow.doRenderEvent(true)`. Resume with `MainScreen.continueLatestSave("Sandbox","<recorded-save-name>")`. World creation, connection and teleports are fixtures; native keyboard/mouse mechanics and movement are separate input evidence. A no-zombie world avoids treating ineffective non-admin God flags as protection.

Before the SP lightbar fixture, move the disposable player to an ordinary road such as 12558,2042 and wait for streamed squares; dedicated emergency stalls intentionally suppress new lights. `check-silent-lightbars.py <run> --single-player` constructs 20 police fixtures and verifies an active-siren positive control is stopped by the actual spawn callback while its lights remain on. MP moves both peers to that area itself; `--police-baseline <run>` can reuse a previously recorded police restart baseline instead of constructing fresh fixtures. The test-only Audio adapter mutes the FMOD master bus before enabling game sound. `check-singleplayer-reload.py` compares saved SP fixtures without recreating them. All resumed profiles begin at zero sound/music volume. Clips require names matching `clip-[a-z0-9-]+`; face the car using native movement before review so normal player visibility does not hide it.

Raw caches, credentials, command queues and crash logs stay under ignored `build/native`. Do not publish them. `scripts/export-native-evidence.py` exports only the specific dated, whitelisted 2026-10-23 receipts and unmodified frames; it asserts clean exits and source/stage/native payload equality. It is not a new gameplay test. See [native acceptance](../docs/native-acceptance.md) for passes, failed probes and unverified paths.

## Natural gallery and weighted Humvee checks

`dev/gallery-natural.py` observes only natural vehicles at the fourteen locations in `config/workshop-gallery-locations.json`; it does not call staged fixtures. Twelve replacement captures use the disposable Very High vehicle-abundance photo sandbox and `gallery-visibility.lua` / test-only `Photo.java` to enable native no-lighting visibility after normal boot. Foraging blur is disabled; recorded observer look-at points keep the featured vehicles in normal player view. No vehicle is created, repositioned, repaired, repainted or given light changes. The two approved military images retain their original bytes and default photo-world settings. These photographs do not establish spawn frequencies.

Set `ONLY_KI5_NATIVE_ROOT=C:/Users/erika/AppData/Local/GameMods/OnlyKI5/Native` on this workstation to use the owned C-drive cache when the project drive is low on space. Only this root or the project build/native root is allowed. Set the same environment variable for every broker command. Never point it at a real player profile. `scripts/export-workshop-gallery.py --capture-root <owned-run>` creates the titled derivatives; `scripts/export-gallery-evidence.py` exports the stopped, clean photo-session receipt and source hashes.

`check-humvee-skins.py <run> --single-player` verifies natural checkpoint Humvees separately from 20 explicit native construction fixtures. Without that flag it compares the authoritative server with both joined clients. `--baseline <stopped-run>` verifies SQL identity, skin and mod-data persistence after restart. Never use transient runtime vehicle IDs across chunk unload/reload. Exact 95/4/1 weights are checked exhaustively in the production Lua fixture; small native samples do not prove population frequencies.


## Whole-pool and four-setting acceptance (0.3.3)

`check-settings-input.py` opens the owned sandbox fixture, then edits all four numeric controls through native mouse and text queues and commits through Next. `check-spawn-options.py` verifies invalid preset-name rejection preserves both drafts and authority, then saves the original-weight preset. `load-spawn-preset.py` reloads that preset after a process restart through the real popup and Next.

`review-spawn-audit.py` inventories all final map/profession registries and captures natural locations at default vehicle abundance. The read-only snapshots include fractional profession weights and pre-multiplier custom weights. `check-configurable-spawns.py` checks loaded native catalog boundary percentages and actual police construction at 0/100% lights; it does not claim in-place runtime reconfiguration, which requires restarting the world. `check-spawn-pool-multiplayer.py` compares natural server vehicles with two peers at checkpoint, highway, secret base and West Point. Run all of these inside guarded owned lifetimes. The export script requires exact payload hashes and clean exits; preliminary runs are not final acceptance.
