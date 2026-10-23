# SteamCMD publication

The owner requested a new **unlisted** testing item on 2026-10-23, with a description styled after Real Vehicle Interiors. This does not make the candidate a public release or close its remaining acceptance limits. The predecessor item 3806374180 and Real Vehicle Interiors 3811728541 are protected from this uploader.

`release/workshop/metadata.json` owns visibility/title/tags. The native workshop.txt is synchronized from it and the description. `steamcmd-identity.json` retains Steam's assigned ID across retries and future updates. Never clear that identity to retry a failed upload: a partial attempt may already have created an item.

The standalone SteamCMD/VDF helpers reuse Real Vehicle Interiors' MIT developer tools, credited in their source headers. `steam_ugc.py` adapts its owner-checked query/dependency client. No game/dependency binaries or Steam authentication data are copied into this repository. The player payload is unchanged by these developer tools.

```powershell
$py = 'C:/Users/erika/AppData/Local/Python/pythoncore-3.14-64/python.exe'
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py
node C:/Users/erika/.codex/tools/run-heavy.mjs -- pwsh -NoProfile -File scripts/validate-stage.ps1
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --upload --cached-login
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --download --cached-login
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --verify --add-dependencies
```

The PowerShell validator is invoked with `pwsh -NoProfile -File scripts/validate-stage.ps1`, optionally passing `-JavaHome`. It checks the metadata's requested visibility. SteamCMD contentfolder points to the stage's Contents directory, so the download contains mods/OnlyKI5VehicleSpawnLiveryOverhaul. The stage remains outside the user's scanned Zomboid/Workshop directory.

The uploader checks source/stage/native-tested canonical hashes before submission. The VDF uses visibility 3, physical newlines, no embedded ASCII double quotes/backslashes in prose, and under 4,000 bytes per description/change note. It reparses the VDF using the RVI SteamCMD parser to catch truncation. Private VDF/logs remain ignored under build/steamcmd. The username is obtained from the local Steam desktop setup; SteamCMD uses its existing cached login. No password or Guard code is supplied or stored by these tools. A credential prompt stops the unattended attempt, with any assigned item ID retained.

SteamCMD uploads the content/cover/description; the owner Steam client adds the 87 recorded required Workshop relationships separately. It queries before additions and never removes existing relationships. The optional, highly recommended KI5 Vehicle Performance Patch (Unofficial), 3808100388, is linked in the description and is not added as a requirement. Its code/assets are not bundled, and it was not in the current native acceptance profile.

After upload, verify the full live description, visibility 3 and exact dependency set. Download the assigned item through SteamCMD's separate cache and compare all payload hashes. Publication, downloaded-byte verification, subscription refresh and loaded-game acceptance are separate results. No real save, subscription, server settings or load order is changed by publication.

## 0.3.1 upload receipt

SteamCMD created [item 3825545131](https://steamcommunity.com/sharedfiles/filedetails/?id=3825545131) on 2026-10-23. Its exit code was 0 and the log ended with Committing update...Success. This SteamCMD build omits the older Uploaded item success wording; the parser now accepts both formats. The assigned ID was retained without repeating the upload. See [publication receipt](../release/workshop/publication.json).

An official SteamCMD download matched all **289 files / 46,570,087 bytes**, manifest **3991554511248186453**. Per-file hashes are in [the download receipt](../release/workshop/download-verified.json). The browser's anonymous link view shows the complete RVI-style description through its Mod ID footer, including linked original-author credits, the author-contact conversion statement, AI disclosure, GitHub, Ko-fi and the highly recommended optional performance patch.

After the owner reconnected Steam, a fresh owner query confirmed unlisted visibility 3. All 87 required Workshop relationships were attached and independently queried again; the optional performance patch remains a recommendation. `verification-status.json` and `page-verified.json` record the completed checks.

## Gallery and description update

Seven reviewed native gameplay images were attached in their recorded order through the owner Steam client, without another SteamCMD login. The short Workshop credit list now omits the Aurora hotfix entry at the owner's request; full imported-file credits/provenance remain intact. The linked recommendation for KI5 Vehicle Performance Patch (Unofficial), 3808100388, remains visible in the verified description.

`scripts/workshop_gallery.py --upload --description` changes only additional previews and the requested description. It verifies the item identity, unlisted flag and exact requirements before submission, then checks that title, main cover, visibility and dependencies remain unchanged. It never sets the content payload. The original 289-file download receipt and SteamCMD publication snapshot remain historical records; `page-update-verified.json` records the later description hash. The general verifier now recognizes that verified page update.

`scripts/workshop_gallery.py --verify-images` read back all seven original images from Steam's CDN and matched their exact sizes and SHA-256 hashes, totalling 826,614 bytes. The 1,000,000-byte app staging quota was checked before submission. Gallery source/quality/compression and browser-review limits are documented in [Workshop gallery](workshop-gallery.md).
