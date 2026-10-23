# Contributing

Use a focused branch and explain the player-visible change and its validation. Extend the shared Catalog, SpawnAliases and PoliceRegions contracts rather than introducing competing selection tables. Preserve existing vehicles and keep spawn callbacks idempotent. Include rejected/stale input and unchanged-world controls for any new interactive workflow.

Do not commit game binaries, saves, credentials or private server configs. Attributed upstream content must be selected in `config/bundled-sources.json`, imported through the repeatable importer and recorded in `docs/imported-content.json`; do not edit generated imported outputs in place. Dependency/import additions need source, rights, author and exact Workshop/module identifiers. Respect explicit restrictions and author requests. The MIT license applies only to your own contributions; third-party contributions keep their own ownership and terms.

Run repository and PowerShell checks. For runtime changes, also compile Lua under the target game's Kahlua and run production-callback regressions using the scripts described in the README. Native world/input, multiplayer, visual and performance acceptance are separate gates; report what was actually exercised. See `docs/development.md`.
