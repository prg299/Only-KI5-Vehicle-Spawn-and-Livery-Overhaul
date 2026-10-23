# Workshop gallery

Published to unlisted item [3825545131](https://steamcommunity.com/sharedfiles/filedetails/?id=3825545131), 2026-10-23. The existing ONLY KI5 cover remains unchanged. These seven additional images are actual native Project Zomboid 42.21.0 framebuffer captures from an owned inactive desktop; no generated scenes, retouching, recoloring or background replacement are used.

| Order | Subject | JPEG dimensions | Bytes | Capture context |
| --- | --- | --- | --- | --- |
| 1 | Louisville police liveries | 928 x 522 | 55,767 | Staged lineup; production routing selected actual Louisville police scripts |
| 2 | Silent flashing lightbars | 928 x 522 | 33,993 | Same lineup at night; lights mode 2, sirens mode 0 on all four |
| 3 | Louisville military checkpoint fleet | 1280 x 720 | 196,147 | Natural generation in the disposable photo world |
| 4 | Military roadside blockpost | 1280 x 720 | 168,261 | Explicit selected-story construction fixture |
| 5 | Military convoy and camo | 1280 x 720 | 157,589 | Explicit selected-story construction fixture |
| 6 | Highway traffic and trailer | 880 x 495 | 64,376 | Natural vehicles/trailer on the Louisville highway |
| 7 | Commando and ambulance variants | 1280 x 720 | 150,481 | Explicit imported-variant fixtures |

All delivery files are opaque JPEGs, total **826,614 bytes**. Sources are unchanged 1280 x 720 PNGs in `tools-src/gallery`; exported files and per-image SHA-256/crop boxes are in `release/workshop/gallery/manifest.json`. The two police images and traffic image use a rectangular 16:9 crop; other frames keep the complete native canvas. No resizing or upscaling occurs. Native screenshot aspect/density is retained rather than applying ImageGen asset sizing rules to game footage. JPEG quality is 82 with ordinary 4:2:0 chroma subsampling; source masters preserve full native detail.

The photo profile hides the HUD, dresses the disposable character, sets daylight/ambient values for legibility and disables radio devices/broadcasts. Selected-story hostiles are frozen only in this photo world. Staged lineups and fixtures do not establish natural spawn frequency or new gameplay acceptance. Actual runtime acceptance remains in [native acceptance](native-acceptance.md).

The scene includes The Indie Stone's game, KI5/original fleet models and the integrated creators' liveries, variants, camo and road-story recipes. Ownership and detailed source attribution remain in [credits](../CREDITS.md) and [imported provenance](imported-content.json). Erika/prg299 prepared the integration and captured the game. These rendered third-party game/mod contents are not relicensed as authored MIT artwork.

## Capture and export

`dev/gallery-world.lua` creates a disposable world. `dev/gallery-photo.lua` prepares the photo view. `dev/gallery-capture.py` uses the shared serialized native broker, with unique screenshot names to avoid reading an older frame when refining a view. Only owned test caches under ignored `build/native/gallery-20261023-a` are used. No real save, Workshop input, server profile, subscription or load order is changed.

The owned native process closed with exit 0, without switching the user's desktop; the resource guard recorded an 8.04 GiB peak child tree. Its final source payload is unchanged from 0.3.1. `scripts/export-workshop-gallery.py` retains native masters and produces the manifest/JPEGs. All seven final JPEGs were opened and visually reviewed before submission.

TinyPNG compression was attempted through its official website in a guarded, temporary headless browser. After rejecting optional cookies, the website rejected all seven valid JPEGs as INVALID and displayed Something went wrong. No configured official API key was available. **TinyPNG compression remains pending**; the current files are reviewed JPEG exports. No successful TinyPNG optimization is claimed.

## Delivery verification

The owner Steam API committed seven additional image previews in the listed order. A fresh query confirms every expected filename and preview type, unchanged main cover/title, unlisted visibility 3 and the exact 87 requirements. Only the description and additional previews were submitted; no content-upload or visibility setter was called. `page-update-verified.json` stores the receipt, and the original content/download receipts remain intact.

An independent readback of all seven original Steam CDN images matches their local sizes and SHA-256 hashes byte for byte; see `release/workshop/gallery-download-verified.json`. The guarded fresh-browser carousel review was blocked by Steam HTTP 429, so interactive thumbnail/enlargement review on the live page remains unverified. This does not change the successful upload, fresh native order query or exact CDN byte results.
