# SteamCMD publication history

## Source candidate 0.3.4 — not uploaded

The optional-fleet candidate has a native-accepted 293-file stage and four clean native receipts. The mixed-fleet server/two-client test passes, including 63 natural observations on both peers, matching conditional variant schemas and 20 silent-lightbar fixtures with an active-siren positive control. The exact source payload matches all four runs; all owned native processes are closed. `workshop_upload.py` requires complete evidence and matching canonical hashes. Workshop item 3825999183 still serves 0.3.3 pending the authorized upload; no 0.3.4 page or content change has been sent yet. Current acceptance and visual limits are in [optional fleets](optional-fleets.md).

## Public 0.3.3 spawn-settings update — 2026-10-24

Source commit `6213905879b142f37b1046cdc562333ed25f6f93` is pushed and [its repository/PowerShell CI passes](https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/actions/runs/40099680768). [Native acceptance](spawn-update-20261024.md) records complete registries, actual sandbox input, original-weight preset reload, representative natural visual review and two-peer state/audio checks, including the rejected final MP lightbar frames and their visual acceptance gap.

SteamCMD exits 0 and confirms the existing public item 3825999183 update. Its official download, manifest **6908068842812541952**, matches every source/stage hash: **291 files / 46,642,973 bytes**. The raw native payload also matches those source bytes, with a separate LF-normalized Git manifest. Publication, download and public-web receipts are under `release/workshop/`.

The owner description-only update preserves the same fourteen-image gallery/order, cover, title, public visibility and exact damnlib/More Car Features requirements. A fresh owner query immediately before the content upload rechecks those values. The content VDF uses only app/item identity, content path and change note. Anonymous official GetPublishedFileDetails after downloading verifies the exact title/description hash, unchanged cover, visibility 0 and matching content manifest. `verification-status.json` distinguishes that current public check from the pre-upload owner gallery/requirements check. The web-reader page fetch failed; this update does not claim a new carousel interaction or change any gallery image.

The current public replacement is **ONLY KI5: Vehicle Spawn & Skins**, item **3825999183**. See [current public release status](public-release-20261024.md) for upload/download, gallery, requirements and old-item deletion. The unlisted history below concerns retired item 3825545131; its final receipts are archived under `release/workshop/archive/20261024-replaced-3825545131`.

The owner requested a new **unlisted** testing item on 2026-10-23, with a description styled after Real Vehicle Interiors. This does not make the candidate a public release or close its remaining acceptance limits. The predecessor item 3806374180 and Real Vehicle Interiors 3811728541 are protected from this uploader.

`release/workshop/metadata.json` owns visibility/title/tags. The native workshop.txt is synchronized from it and the description. `steamcmd-identity.json` retains Steam's assigned ID across retries and future updates. Never clear that identity to retry a failed upload: a partial attempt may already have created an item.

The standalone SteamCMD/VDF helpers reuse Real Vehicle Interiors' MIT developer tools, credited in their source headers. `steam_ugc.py` adapts its owner-checked query/dependency client. No game/dependency binaries or Steam authentication data are copied into this repository. The player payload is unchanged by these developer tools.

```powershell
$py = 'C:/Users/erika/AppData/Local/Python/pythoncore-3.14-64/python.exe'
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py
node C:/Users/erika/.codex/tools/run-heavy.mjs -- pwsh -NoProfile -File scripts/validate-stage.ps1
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --upload --cached-login --preserve-page
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --download --cached-login
node C:/Users/erika/.codex/tools/run-heavy.mjs -- $py scripts/workshop_upload.py --verify
```

The PowerShell validator is invoked with `pwsh -NoProfile -File scripts/validate-stage.ps1`, optionally passing `-JavaHome`. It checks the metadata's requested visibility. SteamCMD contentfolder points to the stage's Contents directory, so the download contains mods/OnlyKI5VehicleSpawnLiveryOverhaul. The stage remains outside the user's scanned Zomboid/Workshop directory.

The uploader checks source/stage/native-tested canonical hashes before submission. The VDF uses visibility 3, physical newlines, no embedded ASCII double quotes/backslashes in prose, and under 4,000 bytes per description/change note. It reparses the VDF using the RVI SteamCMD parser to catch truncation. Private VDF/logs remain ignored under build/steamcmd. The username is obtained from the local Steam desktop setup; SteamCMD uses its existing cached login. No password or Guard code is supplied or stored by these tools. A credential prompt stops the unattended attempt, with any assigned item ID retained.

The initial SteamCMD upload supplied content/cover/description; the owner Steam client attached the original relationships separately. Current content updates use `--preserve-page`. The explicit `--remove-vehicle-dependencies` operation removed only the reviewed 85 vehicle relationships and refuses unknown IDs. Current Workshop relationships are damnlib and More Car Features. The optional, highly recommended KI5 Vehicle Performance Patch (Unofficial), 3808100388, is linked in the description and is not added as a requirement. Its code/assets are not bundled, and it was not in the native acceptance profile.

After upload, verify the full live description, visibility 3 and exact dependency set. Download the assigned item through SteamCMD's separate cache and compare all payload hashes. Publication, downloaded-byte verification, subscription refresh and loaded-game acceptance are separate results. No real save, subscription, server settings or load order is changed by publication.

## 0.3.1 upload receipt

SteamCMD created [item 3825545131](https://steamcommunity.com/sharedfiles/filedetails/?id=3825545131) on 2026-10-23. Its exit code was 0 and the log ended with Committing update...Success. This SteamCMD build omits the older Uploaded item success wording; the parser accepts both formats. The assigned ID was retained without repeating the upload. Historical receipts are preserved in [the 0.3.1 archive](../release/workshop/archive/0.3.1/publication.json).

An official SteamCMD download matched all **289 files / 46,570,087 bytes**, manifest **3991554511248186453**. Per-file hashes are in [the archived download receipt](../release/workshop/archive/0.3.1/download-verified.json). The earlier anonymous page view showed the complete RVI-style description through its Mod ID footer, including linked original-author credits, the author-contact conversion statement, AI disclosure, GitHub, Ko-fi and the highly recommended optional performance patch.

After the owner reconnected Steam, a fresh owner query confirmed unlisted visibility 3. All 87 required Workshop relationships were attached and independently queried again; the optional performance patch remains a recommendation. `verification-status.json` and `page-verified.json` record the completed checks.

## Gallery, description and requirements update

The live page now requires only damnlib (3171167894) and More Car Features (3520758551). All 85 individual vehicle relationships were removed using the owner Steam API and verified by a fresh query. Vehicles remain external: the description links the KI5 collection 2490220997, while the full runtime profile still requires the installed/enabled 102 modules. `config/fleet-dependencies.json` preserves the 87-item input inventory.

Fourteen naturally generated location photographs now replace the interim five-image set: seven regional police/security scenes (one sheriff location), two approved military images unchanged, Louisville highway and four civilian/profession scenes. Every image has a location title. Three quota-safe batches commit the reviewed order; a query verifies each prefix before continuing. All fourteen original Steam CDN files match local sizes and SHA-256 hashes. [Workshop gallery](workshop-gallery.md) records provenance, native visual review, photo settings and compression/browser limits.

The RVI-style description has the requested like/Ko-fi support section, GitHub source link and optional highly recommended performance patch 3808100388. The requested Aurora short-list entry and self/TIS/ImageGen credit line are omitted; detailed source attribution remains in the repository. The sentence about lacking testing time and expecting beta bugs was removed from the saved and live description. `page-update-verified.json` records the current description hash separately from the historical content receipt.

`scripts/workshop_gallery.py --upload --description --description-only` updates just the description. `--upload --replace-gallery` replaces only the explicitly reviewed baseline gallery, then independently checks title, cover, visibility and requirements. `--verify-images` reads back original CDN bytes.

For a subsequent runtime upload, `scripts/workshop_upload.py --upload --cached-login --preserve-page` sends only app/item identity, content path and change note through SteamCMD. It omits title, description, cover, gallery, visibility, tags and requirements; a fresh owner query is required first. The source/stage must match the version-specific native-tested canonical payload. SteamCMD may disconnect the owner's desktop session; content/download receipts and later owner page verification remain separate.

## 0.3.2 content update

SteamCMD committed the content-only update with exit 0. It used `--preserve-page`, supplying only app/item identity, content path and the change note. The source/art/code commit is `d76d765c9313a1be04108b58093ecd464b74eddf`; [its GitHub checks passed](https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/actions/runs/40039167052).

The official SteamCMD download of manifest **4804580298420381499** matches all **290 files / 46,571,538 bytes** and every staged/source SHA-256 hash. [Publication](../release/workshop/publication.json) and [download](../release/workshop/download-verified.json) retain the receipts. The native-tested canonical payload still matches the source; the class-selection pools remain 95% Humvee / 5% other military cars.

Immediately before the content upload, the owner query verified the fourteen-image gallery, unlisted visibility, unchanged description/cover and exact two requirements. SteamCMD then disconnected the desktop account. The post-content owner query is pending reconnection; `verification-status.json` distinguishes that pending page check from the successful content upload/download. Anonymous official GetPublishedFileDetails returned item result 9 without metadata, so it cannot establish this unlisted item's post-upload state. The fresh-browser carousel attempt remains rate-limited (HTTP 429).
