# KI5: Knox County Fleet catalogue

- External vehicle providers: 94
- Bundled MCV/police providers: 0
- External support-only modules: 11
- Final selectable non-burnt scripts: 528
- Preserved burnt scripts: 6
- Excluded disabled optional vehicle variants: 10
- Specific Loot is explicitly excluded from both bundle and dependency closure.

## Spawn groups

| Group | Scripts |
| --- | ---: |
| civilian | 31 |
| compact | 16 |
| luxury | 13 |
| sports | 69 |
| wagon | 18 |
| pickup | 37 |
| van | 14 |
| commercial | 140 |
| suv | 19 |
| police | 89 |
| prison | 4 |
| fire | 13 |
| ranger | 8 |
| ambulance | 4 |
| taxi | 3 |
| militaryCar | 12 |
| militaryTruck | 13 |
| militaryTrailer | 11 |
| trailer | 14 |

## Military vehicle weighting

- Light/utility military pool: exactly 95% `Base.92amgeneralM998` Humvee; the remaining 5% is evenly spread over the other non-truck military/support scripts.
- Ambulance candidate pools are weighted 95% to `Base.90fordF350ambulance`; the remaining 5% is shared by the other valid KI5 ambulance scripts. The F350 is fixed to its white EMS skin rather than random Brush/Rescue paint.
- Military truck pool: exactly 75% AM General family scripts; `Base.78amgeneralM35A2` is 638/1000 overall (85% of the AM General share), and the other AM General variants divide the remaining 112/1000.
- Burnt military pools use the same exact 95% M998 Humvee and 75% AM General truck family ratios; `Base.78amgeneralM35A2Burnt` is 638/1000 truck-wreck slots.
- Military-zone policy targets VMZ B42 child pools after the split: all-vehicle stalls balance car/truck roles, light stalls use the 95% M998 car pool, heavy stalls use the 75% AM General truck pool, burnt vehicles retain the same role-specific ratios, and trailers are re-sorted by VMZ off-road class.
- Military trailers are isolated from ordinary trailer and commercial pools. Active military vehicles are removed from non-military zones; only rare burnt military wrecks may remain in roads, traffic jams, and junkyards.

## Cross-pool rarity policy

- `CarNormal` and its smashed counterpart contain ordinary passenger cars only; compact cars, station wagons, luxury cars, and sports models remain in their own dedicated pools.
- Explicit upstream `VehicleZoneDistribution` source weights are retained when available, and source-zoned candidates do not leak into another zone when their group has an explicit profile for that zone. Named specialist/one-off models receive a 5% relative weight or less in every generated map, crash, wreck, and profession/story pool; the Medical Examiner E150 receives 2% or less.
- Profession/story arrays use weighted choices; multi-category story pools split choices evenly across their semantic vehicle classes before applying within-class weights.

## Intentional script override

- $(@{Script=Base.76chevyK20brickingit; ReplacedModId=76chevyKseriesExpanded; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.Script) — $(@{Script=Base.76chevyK20brickingit; ReplacedModId=76chevyKseriesExpanded; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacedModId) is intentionally superseded by external $(@{Script=Base.76chevyK20brickingit; ReplacedModId=76chevyKseriesExpanded; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacingModId) content; inspect upstream collision risks.
- $(@{Script=Base.76chevyK20helton; ReplacedModId=76chevyKseriesExpanded; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.Script) — $(@{Script=Base.76chevyK20helton; ReplacedModId=76chevyKseriesExpanded; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacedModId) is intentionally superseded by external $(@{Script=Base.76chevyK20helton; ReplacedModId=76chevyKseriesExpanded; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacingModId) content; inspect upstream collision risks.
- $(@{Script=Base.76chevyK20utility; ReplacedModId=76chevyKseries; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.Script) — $(@{Script=Base.76chevyK20utility; ReplacedModId=76chevyKseries; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacedModId) is intentionally superseded by external $(@{Script=Base.76chevyK20utility; ReplacedModId=76chevyKseries; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacingModId) content; inspect upstream collision risks.
- $(@{Script=Base.76chevyK30CCutility; ReplacedModId=76chevyKseries; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.Script) — $(@{Script=Base.76chevyK30CCutility; ReplacedModId=76chevyKseries; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacedModId) is intentionally superseded by external $(@{Script=Base.76chevyK30CCutility; ReplacedModId=76chevyKseries; ReplacingModId=MCV76chevyKseries; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacingModId) content; inspect upstream collision risks.
- $(@{Script=Base.86chevyM1010; ReplacedModId=86chevyCUCV; ReplacingModId=MCV86chevyCUCV; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.Script) — $(@{Script=Base.86chevyM1010; ReplacedModId=86chevyCUCV; ReplacingModId=MCV86chevyCUCV; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacedModId) is intentionally superseded by external $(@{Script=Base.86chevyM1010; ReplacedModId=86chevyCUCV; ReplacingModId=MCV86chevyCUCV; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacingModId) content; inspect upstream collision risks.
- $(@{Script=Base.67commando; ReplacedModId=67commando; ReplacingModId=MCV67commando; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.Script) — $(@{Script=Base.67commando; ReplacedModId=67commando; ReplacingModId=MCV67commando; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacedModId) is intentionally superseded by external $(@{Script=Base.67commando; ReplacedModId=67commando; ReplacingModId=MCV67commando; Reason=External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.}.ReplacingModId) content; inspect upstream collision risks.
