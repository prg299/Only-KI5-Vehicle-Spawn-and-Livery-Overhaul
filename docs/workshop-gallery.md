# Workshop gallery

The fourteen reviewed photographs are published on the new public [Workshop item 3825999183](https://steamcommunity.com/sharedfiles/filedetails/?id=3825999183), **ONLY KI5: Vehicle Spawn & Skins**. [Public replacement status](public-release-20261024.md) records current attachment and verification. The original item 3825545131 and its receipts are archived under `release/workshop/archive/20261024-replaced-3825545131`. Seven police/security locations cover the non-sheriff regional police liveries and one sheriff location. Four civilian/profession scenes were added. The two owner-approved military images are byte-for-byte unchanged. The ONLY KI5 main cover is unchanged.

| Order | Location | Native subject |
| --- | --- | --- |
| 1 | Louisville police department | City police Impala, LTD, Suburbans and F350 |
| 2 | West Point police department | West Point police Suburbans |
| 3 | Muldraugh police department | Muldraugh police Impala |
| 4 | Jefferson County, Dixie highway | County police Impala in naturally generated highway traffic |
| 5 | Riverside | Meade sheriff Crown Victoria and Silverado; the only sheriff location |
| 6 | Fallas Lake | Kentucky State Police patrol at the police station |
| 7 | Louisville airport | Airport Security F350 beside airport service and catering vehicles |
| 8 | Louisville military checkpoint | Approved natural Humvee, trucks and pickup beside checkpoint fencing |
| 9 | Secret military base near Rosewood | Approved natural Humvee and military pickup beside base buildings |
| 10 | Louisville highway | KI5 traffic beside Di Marco |
| 11 | Rosewood fire department | Naturally generated Pierce Arrow ladder truck at the garage |
| 12 | Riverside town centre | Fossoil pickup and civilian car beside town-centre businesses |
| 13 | Muldraugh, McCoy Logging | McCoy work vans and a trailer at the logging site |
| 14 | West Point main street | Civilian cars and pickups along the main street |

All scene pixels are actual 1280 x 720 native Project Zomboid 42.21.0 framebuffer footage. The twelve replacement scenes were captured with the 0.3.2 payload in a disposable no-zombie photo world, using Very High vehicle abundance (`CarSpawnRate=5`), noon, hidden HUD and the native debug no-lighting option to remove dark fog of war. Foraging blur was disabled and the observer faced featured vehicles. No vehicles were manually created, moved, repaired, repainted or given light changes. No scene-construction fixture was called. These photo settings never ship or alter player defaults; photographs establish appearance/location, not natural population frequencies.

The two military images retain the approved 0.3.1 footage, default photo-world settings and original JPEG bytes. `release/workshop/archive/20261024-five-natural` retains that five-image set and receipts. `release/workshop/archive/20261023-initial-gallery` preserves the earlier seven-image staged set. Neither archive is an active gallery.

`scripts/export-workshop-gallery.py` retains native PNG masters and composes separate transparent ImageGen lettering in the established ONLY KI5 style. It asserts that pixels above the lettering equal the cropped/downsampled native scene. Opaque exports are 1024 x 512 POT JPEGs, cropped from 1280 x 640 without stretching. The twelve new images use quality 90 and 4:4:4 chroma; the approved military exports retain quality 86. The fourteen exports total **1,984,790 bytes**. Per-image sizes, dimensions, crop, source/title/output hashes and provenance are in `release/workshop/gallery/manifest.json`.

Full-resolution lettering masters and exact prompts remain in `tools-src/gallery/location-titles`; new native frames, composed masters and per-photo provenance remain in `tools-src/gallery/natural-locations/expanded-20261024`. Unused scouting-title masters remain source provenance, not delivery images. The title lettering is the only generated contribution. Rendered third-party game/mod content is not relicensed as authored MIT artwork; detailed attribution remains in [credits](../CREDITS.md) and [imported provenance](imported-content.json).

All fourteen final JPEGs were visually reviewed at approximately Steam's 640 x 320 display size, including corrected sheriff visibility, Jefferson County focus, airport-security framing and the Rosewood fire engine. TinyPNG's official website was attempted for all twelve replacements in a guarded temporary browser. It rejected every valid JPEG with INVALID / Something went wrong; no official API key is configured. **TinyPNG compression remains pending**. The two approved military JPEGs were excluded from recompression to preserve their bytes.

The owned inactive-desktop photo lifetime ended cleanly with exit 0, no desktop switch and 8.18 GiB peak guarded memory. [Sanitized native photo evidence](validation/gallery-20261024/evidence.json) records exact source-capture hashes, observer positions, photo settings and the clean exit. `dev/gallery-natural.py`, `dev/gallery-visibility.lua` and `config/workshop-gallery-locations.json` reproduce the captures. No real save, downloaded Workshop item, subscription or load order was modified.

For the previous unlisted item, the owner Steam API replaced the five-image set in three quota-safe batches (5, then 7, then 2 images). Fresh queries verify all fourteen filenames/order, unlisted visibility 3, unchanged title/cover/description and exactly two requirements: damnlib and More Car Features. Independent downloads of all fourteen Steam CDN originals match local sizes and SHA-256 hashes exactly; see `release/workshop/gallery-download-verified.json` and `page-update-verified.json`.

Earlier guarded browser attempts on the unlisted item returned HTTP 429. The final public-item browser review returned HTTP 200: actual thumbnail clicks loaded all fourteen images, and the last image opened its 1024 x 512 enlargement. The displayed page and enlargement were visually inspected. Exact screenshots and the interaction receipt are in `docs/validation/public-20261024-metadata`; the current live-carousel check passes separately from native-frame review and CDN-byte verification.


For the new public item 3825999183, fresh owner queries verify all fourteen filenames/order, public visibility 0, unchanged cover/description and the exact two requirements. All fourteen CDN originals again match the reviewed local bytes. The first five-image commit was followed by a fresh prefix query after a dependency-order-only check failure; sorted dependency IDs then allowed the remaining seven and two images to commit. The old item 3825545131 was deleted only after those checks and the official payload download passed. See [public release receipts](public-release-20261024.md).
