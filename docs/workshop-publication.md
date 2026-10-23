# SteamCMD publication

The owner requested a new **unlisted** testing item on 2026-10-23, with a description styled after Real Vehicle Interiors. This does not make the candidate a public release or close its remaining acceptance limits. The predecessor item 3806374180 and Real Vehicle Interiors 3811728541 are protected from this uploader.

`release/workshop/metadata.json` owns visibility/title/tags. The native workshop.txt is synchronized from it and the description. `steamcmd-identity.json` retains Steam's assigned ID across retries and future updates. Never clear that identity to retry a failed upload: a partial attempt may already have created an item.

The standalone SteamCMD/VDF helpers reuse Real Vehicle Interiors' MIT developer tools, credited in their source headers. `steam_ugc.py` adapts its owner-checked query/dependency client. No game/dependency binaries or Steam authentication data are copied into this repository. The player payload is unchanged by these developer tools.

```powershell
$py = 'C:/Users/erika/AppData/Local/Python/pythoncore-3.14-64/python.exe'
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py
node C:/Users/erika/.codex/tools/run-heavy.mjs -- pwsh -NoProfile -File scripts/validate-stage.ps1
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --upload --cached-login
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --verify --add-dependencies
```

The PowerShell validator is invoked with `pwsh -NoProfile -File scripts/validate-stage.ps1`, optionally passing `-JavaHome`. It checks the metadata's requested visibility. SteamCMD contentfolder points to the stage's Contents directory, so the download contains mods/OnlyKI5VehicleSpawnLiveryOverhaul. The stage remains outside the user's scanned Zomboid/Workshop directory.

The uploader checks source/stage/native-tested canonical hashes before submission. The VDF uses visibility 3, physical newlines, no embedded ASCII double quotes/backslashes in prose, and under 4,000 bytes per description/change note. It reparses the VDF using the RVI SteamCMD parser to catch truncation. Private VDF/logs remain ignored under build/steamcmd. The username is obtained from the local Steam desktop setup; SteamCMD uses its existing cached login. No password or Guard code is supplied or stored by these tools. A credential prompt stops the unattended attempt, with any assigned item ID retained.

SteamCMD uploads the content/cover/description; the owner Steam client adds the 87 recorded required Workshop relationships separately. It queries before additions and never removes existing relationships. The optional, highly recommended KI5 Vehicle Performance Patch (Unofficial), 3808100388, is linked in the description and is not added as a requirement. Its code/assets are not bundled, and it was not in the current native acceptance profile.

After upload, verify the full live description, visibility 3 and exact dependency set. Download the assigned item through SteamCMD's separate cache and compare all payload hashes. Publication, downloaded-byte verification, subscription refresh and loaded-game acceptance are separate results. No real save, subscription, server settings or load order is changed by publication.
