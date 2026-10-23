# Release readiness — 0.3.0

This is a public source release candidate, not a published or natively accepted Workshop build.

## Automated evidence

- Catalog generation passed on 2026-10-23: 89 external vehicle providers, five integrated vehicle providers, 535 selectable scripts and nine disabled-only optional variants excluded.
- The importer records 268 attributed outputs, filters six stale MCV definitions, merges 23 MCV English names and restores 57 duplicate IDs. Source hashes, version-layer decisions, namespacing and canonical base-ID spelling are retained in the manifest.
- Installed-game Kahlua compiled all 55 runtime Lua files: 11 authored and 44 integrated. The installed PZ_Optimization compiler/table overrides were active.
- Eight production-Lua scenarios passed. Six final-policy regressions cover native/ascending/descending traversal and shared/copied highway tables. A seventh executes the actual integrated VMZ distribution and zone-registration modules before final policy. The eighth executes all four imported military recipes through the new authored world helpers and native service spies, with no YAPZLib loader or mock. Coverage includes aliases, highway weights, duplicate suppression, callback ordering, exact map-file edits/loader chaining, map overrides, angled new-vehicle parking, checkpoint resumption/no-respawn, sandbox disable/re-enable, failure handling, client/old-chunk/day restrictions and occupied/unloaded footprints.
- A read-only reflection check verified 30 installed-build native world API signatures. The native Lua exposer also lists RandomizedWorldBase, IsoDirections and IsoObject. This verifies API presence, not native placement, physics or multiplayer behavior.
- Repository metadata/provenance checks and all six PowerShell parser checks passed. Unchanged-source reimport reproduced the exact provenance manifest. The game's native uploader validator accepted the new 289-file stage, PNG preview, metadata, content and mod ID with public target visibility. All 289 staged file hashes match source and the payload manifest; staged release metadata matches its source. No Steam initialization or upload occurred.
- The required profile now contains 87 Workshop items / 102 external modules. Only damnlib and More Car Features are non-vehicle requirements. YAPZLib is neither required nor bundled; four internal authored modules replace its former role.

## Artwork and packaging preparation

The icon/poster now uses an actual native gameplay capture, matching the owner's requirement, with only ONLY KI5 lettering at the bottom. The unmodified 1920x1080 source is byte-identical to Erika's meel_regional_day_4.png from the 2026-10-01 isolated photo session. The 705px square crop, separate image_gen title master and exact prompt are retained in tools-src/art. Exported PNG sizes are 256×256 (96,767 bytes) and 512×512 (352,510 bytes); unchanged scene pixels above the title are verified by the exporter. Native ImageData and Workshop preview validation require PNG decoding, so these opaque PNGs are a documented game-format exception. The previous illustrated masters remain archived. TinyPNG compression is pending because the website blocked the unattended browser and no configured official API key was present. No compressed-file review or full optimization is claimed.

The new-item package has 289 files / 46,571,140 bytes including authored runtime, integrated content, linked credits/notices/license and shipped provenance. Its stage uses a SHA-256 payload manifest, a blank Workshop ID and public target visibility. It stays under `build/workshop` and has not been uploaded. The preceding stage is preserved under `build/history/0.2.0-before-native-world-runtime`, alongside the earlier 0.1.0 receipt.

## Open acceptance gates

- Integrated variants, liveries, camo, military zone locations/stories, sandbox settings and mechanics/armor need native acceptance. Structural duplicate filtering, functional Lua fixtures and installed API presence establish narrower results. The authored native scene adapter uses native personnel placement and trailer connections; exact parity with the former library's scene placement is not claimed.
- No native fresh-world/chunk generation, new client join, gameplay input, save/reload or multiplayer acceptance for this new identity. No full-fleet isolated harness or owner acceptance is claimed.
- Final artwork has no native mod-selector/Workshop page review yet. Static image review and uploader image validation establish narrower results.
- No performance benchmark, dedicated-server acceptance or human approval of this new release candidate.
- Workshop item has not been created; required items are in `release/workshop/dependencies.json`. Attach and verify required Workshop relationships before making a new item public.

The original unlisted Workshop item, server settings, load order, subscriptions, saves and user mod deployments remain untouched. Public GitHub source publication does not mean the Steam release gates above have passed.
