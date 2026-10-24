# Spawn options and complete pool audit — 0.3.3

In **Sandbox Options → ONLY KI5: Vehicle Spawn & Skins**, **Custom civilian and novelty weight (%)** defaults to **0.025**. This multiplies original custom-business and novelty/movie model weights by **0.00025**. It is not a fixed overall spawn share. Set **0** to disable those variants or **100** to retain their original weights. In an all-custom dedicated pool, removed weight supplies ordinary counterparts so normalization does not cancel the modifier. Other ordinary source weights remain unchanged. Restart after changing selection settings; existing vehicles keep their model and skin.

Regional police, airport security, military, fire, ambulance and ranger variants remain enabled. **Humvee spawn chance (%)** sets Humvees' share of military light-car weight, including wrecks, from 0–100; its default is **95**. **AM General military trucks (%)** accepts 0–100 and defaults to **75**. It controls AM General weight within military trucks, preserves the family’s M35A2 transport preference, and leaves military density and the car/truck split alone. Wreck pools retain available definitions when an AM General wreck family is absent. Humvee skin selection remains a separate 95% ordinary / 4% medic / 1% JTF decision for supported eight-skin profiles.

**Police lights chance (%)** accepts 0–100 and defaults to **50**. It applies to eligible new police vehicles with working lightbars outside dedicated emergency parking. Sirens are cleared before every exclusion or saved-decision return. Existing decisions are not rerolled when the option changes; players can still operate a siren normally after spawning.

## How selection is balanced

The final policy runs after the upstream vanilla, KI5, More Car Features and integrated military callbacks. It examines every registered vehicle pool and every nested profession/story choice list. It normalizes malformed `Base.Base.*` and bare script names, merges duplicate weights, and keeps empty reserved military pools empty.

The civilian multiplier is applied once after upstream pool changes. At zero it filters choices before selection. All-custom business pools gain ordinary KI5 counterparts so they stay useful. Police and military choices are exempt. The generated per-script classification and fallback inventory is [civilian-spawn-policy.json](civilian-spawn-policy.json); its authored inputs are in `config/civilian-spawn-policy.json`.

Louisville highway (`modified_trfjm`) gets an independent copy of More Car Features' shared traffic-jam list. Relative to ordinary car weight, aggregate limits are 1% sports cars, 1.25% business vehicles, 0.1% specialty vehicles, 0.25% emergency vehicles, 0.25% military vehicles 0.05% unclassified vehicles and 0.05% charred wreck props. When an ordinary selection exists, this guarantees at least **97.13% ordinary car weight**. It does not change the area's spawn density.

Other broad civilian/traffic pools cap sports, business, specialty, emergency, military unclassified and charred-wreck categories at 2.5%, 4%, 0.25%, 1.5%, 1%, 0.25% and 0.25% of ordinary weight respectively. Dedicated sports, profession, emergency and military pools retain their roles.

The optional Town Car limousine and Elgin sweeper packs insert entries independently of the required fleet. Each is additionally capped at 0.05% of other model weight in any applicable pool, and 0.02% on Louisville highway. They are excluded from emergency/military pools. Advertising trailer pools contain trailers, rather than the upstream Elgin entry. These two packs are **test inputs, not new dependencies**, and their code/assets are not bundled.

The secret military base's two long parking rows are split into single stalls six tiles apart with fixed facing. This avoids the native dense-row jitter that allowed wide M62/APC vehicles to overlap. Prison escort choices use prison vehicles and generic police, keeping airport-security liveries out of that pool.

All percentages describe a pool's weighted model choice. They do not promise observed population frequencies, traffic density or a particular outcome in a small sample. Existing chunks keep their saved vehicles.

## Verification

The production-Lua fixtures check fractional original-weight multipliers, zero disabling, original-weight restoration, protected services, independent highway tuning, specialty caps, malformed keys, profession fallback, empty pools and repeated application. The earlier six order/shared-table scenarios continue to check the exact military ratios, and the unchanged silent-lightbar and Humvee-skin regressions remain in the suite.

The [dated native audit](spawn-update-20261024.md) records complete SP/default, SP/original-weight and dedicated-server registries, sandbox input/preset reload, representative natural visual review and two-peer state/audio assertions. Sparse station views and rejected final MP lightbar photos are explicitly excluded from visual acceptance. This audit does not establish population frequencies or exhaustive model/map coverage.
