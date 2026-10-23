# Release readiness — 0.3.1

The source candidate has passed focused native single-player and two-client dedicated-server acceptance. An unlisted testing item has been uploaded through SteamCMD; public release remains pending. Detailed results and explicit limits are in [native acceptance](native-acceptance.md).

## Verified

- Selected B42/common catalog: 89 external and five integrated vehicle providers; 531 real selectable IDs; nine disabled-only optional variants excluded. All 531 resolve in the native dedicated-server registry.
- Importer: 268 attributed outputs, six stale MCV definitions omitted, 23 native JSON names, 57 duplicate IDs restored. Original ownership, source/output hashes, version layers and merge decisions remain recorded. Five military lightbar writes use a hardware-aware native helper.
- Installed-game Kahlua compiles all 55 runtime Lua files (11 authored/44 integrated). Eleven production-Lua scenarios pass, including all four imported recipes, highway aliases/order, emergency stalls and silent-lightbar server/SP/client authority. The read-only API check verifies 32 exact installed signatures. Six PowerShell files parse. Compiler fixtures run with the installed PZ_Optimization compiler/table overrides; this is disclosed separately from native stock-class runs.
- Native fresh SP generation, checkpoint/camo and highway observations; all four military stories in SP and joined MP; every recorded story survives a dedicated restart without duplicate vehicles. Representative MCV families render and expose real mechanics/armor overlays; all 23 names resolve on both clients after restart.
- Silent police lights work in SP and both joined clients, including late join. Positive siren controls activate native emitters; the real callback stops them while preserving flashing. All 20 police fixtures preserve their skins/modes/decisions and silence across SP and MP restart. Unmodified blue/red native footage frames are published with hashes.
- Final local stage: 289 payload files / 46,570,087 bytes, all SHA-256 hashes equal source and its payload manifest. The final source also matches H/I native candidate hashes. The native read-only uploader validator accepts metadata, PNG preview, content, identity and target visibility. The read-only validator itself does not initialize Steam or upload; actual publication is recorded separately.
- Full profile remains 87 Workshop items / 102 external modules. The only non-vehicle requirements are damnlib and More Car Features / WayMoreCars. YAPZLib is neither bundled nor required.

## Artwork and publication

The icon uses an actual native gameplay screenshot with only ONLY KI5 title lettering at the bottom. The original 1920×1080 capture is byte-identical to Erika's meel_regional_day_4.png from the 2026-10-01 isolated photo session. The square crop, ImageGen title master, prompt and export record remain in tools-src/art. Runtime PNGs are 256×256 (96,767 bytes) and 512×512 (352,510 bytes). Native ImageData/uploader validation requires PNG, a documented opaque-image format exception. TinyPNG compression remains pending because its website blocked the unattended browser and no official API key was configured. Compressed-file review and a native mod-selector/Workshop page review remain open.

The final stage retains Workshop ID 3825545131 and unlisted target visibility at build/workshop/OnlyKI5VehicleSpawnLiveryOverhaul. Prior stages are preserved under build/history. SteamCMD committed item 3825545131 and its official download matched all 289 payload files (manifest 3991554511248186453). After Steam desktop reconnection, the owner API attached and verified all 87 requirements and live unlisted visibility; see [publication verification](workshop-publication.md). Seven actual gameplay gallery images are now published in the reviewed order, and their Steam CDN originals match the local bytes. The requested short-page credit edit leaves detailed imported-file attribution intact. The dated source/permissions audit and author-contact removal/dependency-conversion statement remain available.

The gallery export and native masters are recorded in [Workshop gallery](workshop-gallery.md). All seven JPEG exports were visually inspected. TinyPNG's current website accepted the page visit but rejected every file with INVALID / Something went wrong, so that additional compression remains pending. A guarded fresh-browser page review encountered Steam HTTP 429; an interactive live-carousel review remains unverified. Owner API order/visibility/description checks and seven exact CDN byte comparisons passed.

## Remaining acceptance limits

The tests establish the specific native paths documented above. Every armor installation, trailer driving, additional map combinations, sandbox UI permutations, Steam transport/production hosting, long-run performance and human listening acceptance remain unverified. Forced story selection and small traffic samples do not prove natural story frequency or exact population ratios. These cannot be described as exhaustive integration acceptance.

The original unlisted Workshop item, private predecessor, real saves, active server configuration, subscriptions and load order remain unchanged. GitHub publication, the unlisted Steam upload and downloaded-byte verification do not close the remaining public-release acceptance limits.
