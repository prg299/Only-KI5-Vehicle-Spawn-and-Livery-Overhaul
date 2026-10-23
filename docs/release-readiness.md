# Release readiness — 0.1.0

This is a public source release candidate, not a published or natively accepted Workshop build.

## Automated evidence

- Catalog generation passed on 2026-10-23: 94 external vehicle providers, 534 selectable records, 10 disabled-only optional variants excluded, zero bundled providers.
- Installed-game Kahlua compiled all seven runtime Lua files. The installed PZ_Optimization compiler/table overrides were active.
- Six production-Lua regression scenarios passed: native/ascending/descending zone traversal crossed with shared/copied highway tables. They cover late aliases, role-relative highway weights, idempotence and saved/unrelated vehicle preservation using mocked game services.
- Repository metadata, identity, rights-boundary and dependency checks passed; five PowerShell scripts parsed. The game's read-only native uploader validator accepted the stage metadata, PNG preview, content and new mod ID with public target visibility. No Steam initialization or upload occurred.

## Artwork and packaging preparation

Repository metadata/identity/dependency checks passed and five PowerShell scripts parsed. PNG exports preserve meaningful corner alpha at 256×256 (133,948 bytes) and 512×512 (517,520 bytes). The full-resolution 1254×1254 ImageGen master (2,974,468 bytes) and exact prompt remain in `tools-src/art/`. These derivatives are not claimed fully optimized: TinyPNG's website rejected the headless browser with an explicit user-agent block; no configured Tinify API key was present. Compression remains pending. No workaround for the site's browser restriction was used.

The new-item stage has 16 runtime-package files and a SHA-256 payload manifest, a blank Workshop ID and public target visibility. It stays under `build/workshop` and has not been uploaded.

## Open acceptance gates

- More Car Variants availability for new subscribers: public HTML/indexed page visible but Valve API result 9. No fresh account/subscription/download test performed.
- The six upstream MCV/KI5 duplicate definitions need native mechanics/armor and actual new-vehicle checks. Public dependency packaging cannot silently omit the upstream files as the private bundle did.
- No native fresh-world/chunk generation, new client join, gameplay input, save/reload or multiplayer acceptance for this new identity. No full-fleet isolated harness or owner acceptance is claimed.
- Final artwork has no native mod-selector/Workshop page review yet. Static image review and uploader image validation establish narrower results.
- No performance benchmark, dedicated-server acceptance or human approval of this new release candidate.
- Workshop item has not been created; required items are in `release/workshop/dependencies.json`. Attach and verify required Workshop relationships before making a new item public.

The original unlisted Workshop item, server settings, load order, subscriptions, saves and user mod deployments remain untouched. Public GitHub source publication does not mean the Steam release gates above have passed.
