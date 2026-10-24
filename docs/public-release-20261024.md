# Public replacement - 2026-10-24

The owner explicitly requested deletion of item 3825545131 and a fresh **public** release named **ONLY KI5: Vehicle Spawn & Skins**. New item [3825999183](https://steamcommunity.com/sharedfiles/filedetails/?id=3825999183) is uploaded through SteamCMD. Its official download matches all 290 files / 46,571,542 bytes (manifest 424093739917839501). The anonymous official Steam API independently verifies public visibility 0, the exact title, full description hash and crash-scene wording. The fourteen-image gallery and exact two requirements are owner-verified live. Every gallery CDN original matches the reviewed local bytes. The old item 3825545131 was then deleted; Valve returned EResult 1, and a separate fresh query reports it missing (item result 9). The replacement was queried again and remains public and unchanged. Private predecessor 3806374180 and Real Vehicle Interiors 3811728541 are protected.

The description now explicitly states: **Crashed cars too. Replaces vanilla vehicle selections in crash scenes with KI5 vehicles.** This describes replacement of crash-scene selections, without promising that existing saved wrecks or every burnt prop is rewritten. Credits, original-author links/conversion policy, KI5 collection, optional performance patch, GitHub and the requested support section are retained.

The fourteen native gallery images and main ONLY KI5 cover are unchanged. Only damnlib and More Car Features are attached as Workshop requirements. Vehicle installation remains through the linked KI5 collection; the runtime fleet module inventory is unchanged.

The player payload keeps the internal mod ID and version 0.3.2. Exactly two canonical files change: root and Build 42 mod.info display names. The uploader compares their exact archived pre-rename contents and every other canonical file against the native-tested 0.3.2 candidate. No gameplay code, models, skins, pools, lightbar handling, dependencies or load order changes. The native uploader accepts the new public metadata and the existing preview/content. This metadata check does not claim a new game-session test; the documented SP/MP/restart evidence and remaining limits are reused explicitly.

All pre-replacement page/content receipts and metadata are preserved in `release/workshop/archive/20261024-replaced-3825545131`. The old stage and private VDF are retained under ignored build history. `replacement.json` pins both identities. An unknown creation outcome refuses blind retries; the normal uploader protects the retired identity. `delete-replaced-workshop-item.py` can delete only 3825545131 after a fresh owner query verifies the new public title/description, exact two requirements, fourteen-image order, official payload download and exact gallery CDN receipt. It records Valve's deletion callback and independently checks absence, then verifies the replacement remains unchanged.

Historical unlisted publication details remain in [publication history](workshop-publication.md). [Native acceptance](native-acceptance.md) and [gallery provenance](workshop-gallery.md) retain the verification boundaries. TinyPNG compression remains pending from the documented service failures; no images have been regenerated or recompressed for this replacement.


## Final checks

- SteamCMD publication and official download: 290 files / 46,571,542 bytes; manifest 424093739917839501; all payload hashes match source/stage.
- Anonymous official Steam metadata: exact requested title, public visibility 0, correct manifest and complete description hash, including the crash-scene line.
- Owner Steam API: public visibility, full description, unchanged ONLY KI5 cover, exact two requirements and fourteen ordered image filenames. Dependency responses are normalized as a set because Steam returned them in different orders during the first gallery batch; the five-image prefix was queried before resuming the remaining nine images.
- Independent Steam CDN download: all fourteen image sizes and SHA-256 hashes match the previously reviewed files, including unchanged military images.
- Old item: deletion callback 3417 returns success for exactly 3825545131; fresh query verifies absence. The original private mod and RVI are untouched.
- Source/art preparation commit 009d0ae0607ab88fa9dc485cc60b7518b4980247 passed [GitHub CI](https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/actions/runs/40082587660). Follow-up receipts and the dependency-order correction are tracked with this release.

Receipts: `publication.json`, `download-verified.json`, `public-web-verified.json`, `page-verified.json`, `page-update-verified.json`, `gallery-download-verified.json`, `replacement.json` and `replacement-deletion.json` under `release/workshop`.


The final anonymous browser returned HTTP 200 and displayed the requested title, main cover and gallery correctly. Actual thumbnail clicks selected all fourteen images with loaded Steam CDN previews; clicking the last image opened its 1024 x 512 enlargement (14 of 14). Both the page and enlargement were visually inspected. Sanitized interaction records and exact screenshots are in `docs/validation/public-20261024-metadata/browser-review.json`, `workshop-gallery-page.png` and `workshop-gallery-enlarged.png`. This closes the previous live-carousel verification gap for the new public item.
