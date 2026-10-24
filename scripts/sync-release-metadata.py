"""Keep Workshop metadata, dependency docs and shipped attribution synchronized."""
from pathlib import Path
import json
import re
import shutil
import argparse

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--page-only',action='store_true',help='Synchronize page/dependency documentation without touching the frozen player payload')
args=parser.parse_args()

ROOT = Path(__file__).resolve().parents[1]
MOD = ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
URL = 'https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/blob/main/'
description = (ROOT/'release/workshop/description.txt').read_text('utf-8-sig')
metadata = json.loads((ROOT/'release/workshop/metadata.json').read_text('utf-8'))
identity = ROOT/'release/workshop/steamcmd-identity.json'
workshop_id = json.loads(identity.read_text())['workshopId'] if identity.exists() else ''
if metadata['visibility'] not in ('public','unlisted'):
    raise ValueError('Unsupported release visibility')
lines = ['version=1', 'id='+workshop_id, 'title='+metadata['title']]
lines += ['description='+line for line in description.splitlines()]
lines += ['visibility='+metadata['visibility'], 'tags='+';'.join(metadata['tags'])]
(ROOT/'release/workshop/workshop.txt').write_text('\n'.join(lines)+'\n', 'utf-8')
for name in (() if args.page_only else ('CREDITS.md', 'THIRD_PARTY_NOTICES.md')):
    text = (ROOT/name).read_text('utf-8')
    text = re.sub(r'\]\((docs/[^)]+)\)', lambda m: ']('+URL+m[1]+')', text)
    (MOD/name).write_text(text, 'utf-8')
if not args.page_only:
    shutil.copy2(ROOT/'LICENSE', MOD/'LICENSE')
    (MOD/'provenance').mkdir(exist_ok=True)
    shutil.copy2(ROOT/'docs/imported-content.json', MOD/'provenance/imported-content.json')
dependencies = json.loads((ROOT/'release/workshop/dependencies.json').read_text('utf-8'))
fleet_dependencies=json.loads((ROOT/'config/fleet-dependencies.json').read_text('utf-8'))
module_count = sum(len(d['modIds']) for d in fleet_dependencies)
descriptor = dict(line.split('=', 1) for line in (MOD/'mod.info').read_text('utf-8').splitlines() if '=' in line)
header = f"""# Dependencies and load order

The Workshop page lists only **{len(dependencies)} required items**: **that DAMN Library**
and **More Car Features + Spawn Zones Expansion / WayMoreCars**.
Choose any vehicles you want from the [KI5 collection](https://steamcommunity.com/workshop/filedetails/?id=3652192243) or their individual pages.
The collection is a browsing link, not an exhaustive requirements list. No vehicle pack is required.
**YAPZLib is not required.**

Version {descriptor['modversion']} detects enabled packs and valid native vehicle scripts at runtime.
Use one, several, or none of the covered KI5 packs. Missing vehicles and their
integrated variants are excluded; no suitable service/military pack leaves that
role empty. With no KI5 vehicles enabled, new managed vehicle pools stay empty.
Ordinary body styles can fall back to other installed ordinary KI5 cars.
The **{len(fleet_dependencies)} items / {module_count} modules** below describe only the
development full-fleet reference profile, not player requirements.

**Highly recommended, optional:** [KI5 Vehicle Performance Patch (Unofficial)](https://steamcommunity.com/sharedfiles/filedetails/?id=3808100388) by lucygoosey.
Follow its server/client setup instructions. It is not bundled or a required item,
and it was not included in the current native acceptance profile.

KI5 base vehicles and selected vehicle expansion modules remain original external
downloads. No private server configuration is used.

Load damnlib, WayMoreCars and any selected vehicle packs before
OnlyKI5VehicleSpawnLiveryOverhaul. Only the two support modules are hard requirements;
optional vehicle ordering edges do not enable or require missing packs.

## Integrated content

- More Car Variants: all four modules, with six reviewed older vehicle definitions
  omitted in favor of current external KI5 definitions.
- Consistent Camo: KI5Camo and PapaChadCamo shared texture trees.
- Lore-Friendly Police Skins and its B42 hotfix: selected shared/versioned content.
- Vehicle Military Zones: military locations, split pools, sandbox settings,
  translations and all four road stories. Authored helpers call native game
  APIs for map data, distributions, scene construction and story scheduling.
- No Vanilla selection/profession/story behavior: authored late implementation,
  plus the original duplicate-suppression identifier data.

Disable the originals of those integrated modules, both LFPSP and LFPSP-B42Fix,
VMZNEW, and the private Suite/World Vehicles/Regional Police integrations.
Their IDs are listed in incompatible= to avoid duplicate loading.
Specific Loot and J10 modules remain excluded.

Original authors may contact Erika/prg299 through Steam or
[GitHub issues](https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/issues)
to have their content removed from the bundle and converted to an external
dependency. To make that change, update config/bundled-sources.json, the external
profile and descriptor conflicts, then regenerate/import/check/stage together.
The importer removes only its unchanged, previously manifested files.
Shared paths need review before switching an upstream mod back on.

YAPZLib's role has been replaced with authored code; its files are not bundled.
Other mods may still require it independently, so it is not marked incompatible.

See [credits](../CREDITS.md), [provenance](imported-content.json),
[permissions](permissions.md) and [compatibility](compatibility.md).

| Original Workshop item | Workshop ID | Enabled module IDs |
| --- | --- | --- |
"""
rows = [f"| [{d['name']}]({d['url']}) | \x60{d['workshopId']}\x60 | "
        + ', '.join('\x60'+m+'\x60' for m in d['modIds'])+' |' for d in fleet_dependencies]
(ROOT/'docs/dependencies.md').write_text(header+'\n'.join(rows)+'\n', 'utf-8')
print('Synchronized Workshop description, linked credits, license, package provenance and dependency list.')
