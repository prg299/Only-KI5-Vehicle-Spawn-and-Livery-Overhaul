# Optional KI5 vehicle packs — 0.3.4

No vehicle pack is a hard requirement. Only damnlib and More Car Features / WayMoreCars remain required, both on Workshop and in the player descriptor. Enable the KI5 packs you want; the Touran and other modern or novelty cars are optional. The linked collection is a browsing aid and does not need to contain every supported car. The full development fleet remains an immutable generation/test input, not a player installation list.

The generated catalog maps every covered script to its supplying vehicle module. `Fleet` intersects that map with enabled modules and the actual native registry before building weighted candidates. Integrated liveries use the corresponding base provider. Exact aliases, profession lists, regional police, military scenes and late map pools share the same availability checks. Missing families redistribute within available compatible choices; ordinary body styles may share other ordinary KI5 cars. Absent specialist service, military and trailer families stay empty. At zero installed KI5 vehicles all managed map/profession pools are empty, including vanilla burnt pools. Existing saved vehicles are never rewritten.

The four 0.3.3 sandbox controls retain their defaults and meaning. Humvee/AM General percentages apply when both preferred and alternate families are available; an absent preferred family cannot force a missing model into the world. New mod selections take effect after a restart. Removing a vehicle pack from an established save is a separate game-level migration risk; this change does not delete saved cars or migrate missing models.

## Conditional integrated variants

Simply removing descriptor requirements was insufficient: eagerly loaded variant scripts referenced templates from missing packs. The importer now leaves inert, empty vehicle IDs plus the original model declarations in the ordinary native script phase. Original attributed vehicle bodies live in generated `OptionalVehicles.lua`. When a base pack is enabled, `Fleet` fills its empty variant with the existing native `VehicleScript.Load` and `Loaded` methods before catalog filtering. Disabled variants retain zero skins/parts and are never candidates. Base-specific MCV Lua extensions also skip their missing base before requiring armor helpers. No extra Java component or library is introduced.

The importer retains original source hashes, transformed output hashes, deferred bodies and attribution. It does not copy any KI5 base vehicle assets. `loadModAfter` preserves ordering for optional packs without requiring them. Game/Workshop inputs, real saves, subscriptions and player load orders remain untouched.

## Verification status

Twenty-eight production-Lua scenarios pass: the previous 23 plus zero, single civilian, police-only, military-only and mixed fleet cases. They deliberately leave ghost definitions in the mock registry to prove provider filtering, and cover absent trailer aliases, ordinary fallbacks and missing preferred military families. All 59 Lua files compile; portable provenance checks cover 14 authored and 45 integrated modules, 269 attributed outputs and exactly two requirements.

Three final native lifetimes pass with identical source payloads and clean exit-0 receipts, without switching the desktop:

- **No vehicle packs:** 93 final map pools, zero positive choices, zero profession choices and zero observed vehicles. All 57 disabled variants retain zero skins/parts. The empty highway scene was opened and reviewed.
- **Only the '59 Meteor pack:** two available native models, 93 final map pools and 76 positive pool choices. After fresh highway streaming, 47 vehicles were observed: 44 ordinary Meteor-pack vehicles and three preserved charred props. The game-rendered scene was opened and reviewed. These counts describe one random scene, not a frequency or density guarantee.
- **Full reference fleet, menu/registry phase:** all 531 catalog vehicles and all 57 populated variants are available. Each variant's native skin count matches its attributed original body; part counts are positive. This is initialization evidence, not another complete full-world acceptance pass.

The raw source/payload hashes and sanitized [receipts](validation/native-20261024-optional-fleets/evidence.json) match all three runs. The stage contains 293 player files. Twenty-eight Lua scenarios, 59 Lua compilations, 37 installed API contracts, six PowerShell parsers and portable provenance checks pass. The mixed-fleet server/two-client test remains deferred while the player's Steam game is running and admission lacks memory headroom. The player chose to keep playing. No player process is stopped, and publication is gated on the missing native receipt. Workshop remains at 0.3.3; 0.3.4 is a source candidate.

Intermediate diagnostics are excluded from final acceptance: the initial zero-profile run exposed missing-template warnings, addressed by conditional initialization. The next world exposed vanilla burnt leftovers, addressed by the explicit empty-fleet branch and verified in the final zero run. Native game runs share a machine-wide exclusive lane; exit 75 defers a run rather than bypassing that lane. Existing option-percent translation diagnostics and disabled optimization-menu warnings are separate from the eliminated missing-template warnings; zero engine warnings are not claimed.
