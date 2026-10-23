# Contributing

Use a focused branch and explain the player-visible change and its validation. Extend the shared Catalog, SpawnAliases and PoliceRegions contracts rather than introducing competing selection tables. Preserve existing vehicles and keep spawn callbacks idempotent. Include rejected/stale input and unchanged-world controls for any new interactive workflow.

Do not commit game/Workshop assets, binaries, copied upstream code, saves, credentials or private server configs. Dependency additions need a source/permission record and exact public Workshop/module identifiers. The MIT license applies only to your own contributions; submit only content you can license.

Run repository and PowerShell checks. For runtime changes, also compile Lua under the target game's Kahlua and run production-callback regressions using the scripts described in the README. Native world/input, multiplayer, visual and performance acceptance are separate gates; report what was actually exercised. See `docs/development.md`.
