# Compatibility and merge decisions

Target: installed Project Zomboid 42.21.0, revision `4a0e9546ec`, Steam build `25485521`, observed 2026-10-23. Upstream updates can invalidate a previously passing catalog or native test.

Private Suite 1.1.4 omitted six old More Car Variants vehicle scripts so newer KI5 definitions won. A dependency-based public mod cannot delete files from that upstream download. This release therefore **does not carry forward that filtering guarantee**. It records the six collisions below and requires native mechanics/armor/spawn checks before Workshop release. The generated catalog recognizes each ID once; that alone does not fix which upstream vehicle definition the game loads.

| Vehicle ID | KI5 provider | External MCV provider |
| --- | --- | --- |
| `Base.76chevyK20brickingit` | `76chevyKseriesExpanded` | `MCV76chevyKseries` |
| `Base.76chevyK20helton` | `76chevyKseriesExpanded` | `MCV76chevyKseries` |
| `Base.76chevyK20utility` | `76chevyKseries` | `MCV76chevyKseries` |
| `Base.76chevyK30CCutility` | `76chevyKseries` | `MCV76chevyKseries` |
| `Base.86chevyM1010` | `86chevyCUCV` | `MCV86chevyCUCV` |
| `Base.67commando` | `67commando` | `MCV67commando` |

No full vehicle override is distributed, and no third-party asset is patched or silently relabeled as MIT. The six known overlaps are explicit in `config/merge-rules.json`; catalog generation fails on newly discovered collisions until they are reviewed. If these upstream combinations fail, resolve the supported profile with the original authors or remove/disable the affected variant modules in a separately reviewed profile. Do not repack stale source files to make a public bundle.

Mixed Filibuster duplicate suppression was driven by an extracted upstream key list in the private Suite and is omitted from 0.1.0. This is a KI5-only supported profile. New vehicles appear only in fresh chunks; existing vehicles and saves are not rewritten. Police hotfix and original LFPSP must never be enabled together; the hotfix can be withdrawn by its author. More Car Variants API result 9 remains an availability gate despite its readable/indexed public page.
