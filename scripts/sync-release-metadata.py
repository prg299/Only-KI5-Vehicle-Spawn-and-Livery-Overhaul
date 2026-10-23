"""Keep Workshop metadata, dependency docs and shipped attribution synchronized."""
from pathlib import Path
import json
import re
import shutil

ROOT = Path(__file__).resolve().parents[1]
MOD = ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
URL = 'https://github.com/prg299/Only-KI5-Vehicle-Spawn-and-Livery-Overhaul/blob/main/'
description = (ROOT/'release/workshop/description.txt').read_text('utf-8-sig')
metadata = json.loads((ROOT/'release/workshop/metadata.json').read_text('utf-8'))
identity = ROOT/'release/workshop/steamcmd-identity.json'
workshop_id = json.loads(identity.read_text())['workshopId'] if identity.exists() else ''
if metadata['visibility'] != 'unlisted':
    raise ValueError('The current release is authorized as unlisted only')
lines = ['version=1', 'id='+workshop_id, 'title='+metadata['title']]
lines += ['description='+line for line in description.splitlines()]
lines += ['visibility='+metadata['visibility'], 'tags='+';'.join(metadata['tags'])]
(ROOT/'release/workshop/workshop.txt').write_text('\n'.join(lines)+'\n', 'utf-8')
for name in ('CREDITS.md', 'THIRD_PARTY_NOTICES.md'):
    text = (ROOT/name).read_text('utf-8')
    text = re.sub(r'\]\((docs/[^)]+)\)', lambda m: ']('+URL+m[1]+')', text)
    (MOD/name).write_text(text, 'utf-8')
shutil.copy2(ROOT/'LICENSE', MOD/'LICENSE')
(MOD/'provenance').mkdir(exist_ok=True)
shutil.copy2(ROOT/'docs/imported-content.json', MOD/'provenance/imported-content.json')
dependencies = json.loads((ROOT/'release/workshop/dependencies.json').read_text('utf-8'))
module_count = sum(len(d['modIds']) for d in dependencies)
descriptor = dict(line.split('=', 1) for line in (MOD/'mod.info').read_text('utf-8').splitlines() if '=' in line)
header = f"""# Dependencies and load order

The {descriptor['modversion']} full-fleet profile requires **{len(dependencies)} external Workshop items / {module_count} modules**.
The non-vehicle requirements are **that DAMN Library**, **More Car Features +
Spawn Zones Expansion / WayMoreCars**. **YAPZLib is not required.**

**Highly recommended, optional:** [KI5 Vehicle Performance Patch (Unofficial)](https://steamcommunity.com/sharedfiles/filedetails/?id=3808100388) by lucygoosey.
Follow its server/client setup instructions. It is not bundled or a required item,
and it was not included in the current native acceptance profile.

KI5 base vehicles and selected vehicle expansion modules remain original external
downloads. No private server configuration is used.

Load all required original vehicle/library modules and WayMoreCars before
OnlyKI5VehicleSpawnLiveryOverhaul. The descriptor declares those edges.

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
        + ', '.join('\x60'+m+'\x60' for m in d['modIds'])+' |' for d in dependencies]
(ROOT/'docs/dependencies.md').write_text(header+'\n'.join(rows)+'\n', 'utf-8')
print('Synchronized Workshop description, linked credits, license, package provenance and dependency list.')
