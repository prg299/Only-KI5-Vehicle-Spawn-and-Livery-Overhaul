"""Rebuild attributed content from read-only Workshop downloads, with per-file provenance.

Only previously manifested, unchanged generated files may be replaced or removed.
Base KI5 vehicles, damnlib, WayMoreCars and YAPZLib are never imported.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re

ROOT = Path(__file__).resolve().parents[1]
MOD = ROOT / 'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
PREFIX = 'OnlyKI5VehicleSpawnLiveryOverhaul_'
MANIFEST = ROOT / 'docs/imported-content.json'
NATIVE_REQUIRES = {
    'YAPZLib/VehicleZone': PREFIX + 'MilitaryZones',
    'YAPZLib/VehicleZoneDistribution': PREFIX + 'MilitaryZones',
    'YAPZLib/Utils': PREFIX + 'WorldSupport',
    'YAPZLib/RVSBase': PREFIX + 'RoadStories',
}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def read_json(path):
    return json.loads(path.read_text('utf-8-sig'))


def safe_target(relative):
    target = (MOD / relative).resolve()
    if not target.is_relative_to(MOD.resolve()):
        raise ValueError(f'Import target escapes mod: {relative}')
    return target


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--workshop-root', type=Path, default=Path(os.environ.get(
        'PZ_WORKSHOP_DIR', 'C:/SteamLibrary/steamapps/workshop/content/108600')))
    args = parser.parse_args()
    workshop = args.workshop_root
    sources = read_json(ROOT / 'config/bundled-sources.json')
    rules = read_json(ROOT / 'config/merge-rules.json')
    previous = read_json(MANIFEST) if MANIFEST.exists() else {'files': []}
    owned = {entry['targetPath']: entry['sha256'] for entry in previous['files']}
    outputs, records, omitted, translations = {}, {}, [], {}
    translation_inputs = []
    layer_decisions = []
    module_maps = {}
    # Review the external semantic keys before selecting which old definitions to omit.
    inventory = read_json(ROOT / 'docs/ki5-provider-inventory.json')
    external = {entry['Script'].lower(): entry for entry in inventory['scripts']
                if not entry['Bundled'] and not entry['ModId'].startswith('MCV')}
    aliases = {}
    # The old dependency catalog selected MCV on overlaps. Verify the current
    # base definitions directly before changing that reviewed source priority.
    for rule in rules:
        provider = next(p for p in inventory['providers'] if p['ModId'] == rule['baseModId'])
        candidates = workshop / provider['WorkshopId'] / 'mods'
        found = False
        for module in candidates.iterdir():
            if not module.is_dir():
                continue
            descriptors = list(module.glob('*/mod.info')) + list(module.glob('mod.info'))
            if not any(re.search(r'(?m)^id=' + re.escape(rule['baseModId']) + r'\s*$',
                                 p.read_text('utf-8-sig')) for p in descriptors):
                continue
            for root_name in provider['RuntimePath'].split(' + '):
                for path in (module / root_name.replace('\\', '/')).rglob('*.txt'):
                    match = re.search(rb'(?mi)^\s*vehicle\s+(' + rule['script'][5:].encode() + rb')\s*\{?', path.read_bytes())
                    if match:
                        canonical = 'Base.' + match[1].decode()
                        external[rule['script'].lower()] = {'ModId': rule['baseModId'], 'Script': canonical}
                        aliases[rule['script']] = canonical
                        found = True
        if not found:
            raise ValueError(f"Reviewed base definition disappeared: {rule['script']}")
    expected_omissions = {(r['script'], r['addonModId']) for r in rules}

    def add(relative, data, origins, transform='copied'):
        if relative in outputs and outputs[relative] != data:
            raise ValueError(f'Import collision needs a reviewed merge: {relative}')
        outputs[relative] = data
        entry = records.setdefault(relative, {
            'targetPath': relative, 'sha256': sha(data), 'transform': transform, 'sources': []})
        entry['sources'].extend(origins)

    for source in sources:
        if source['workshopId'] in {'3171167894', '3520758551', '3624971238'}:
            raise ValueError('An external framework was selected for bundling')
        module = workshop / source['workshopId'] / 'mods' / source['modDirectory']
        descriptor = next((module / p for p in ('42.20/mod.info', '42.13/mod.info',
                                               '42/mod.info', 'mod.info')
                           if (module / p).is_file()), None)
        if not descriptor:
            raise FileNotFoundError(f"Source not installed: {source['modId']}")
        fields = dict(line.split('=', 1) for line in descriptor.read_text(
            'utf-8-sig').splitlines() if '=' in line)
        if fields.get('id') != source['modId']:
            raise ValueError(f'Unexpected source identity: {descriptor}')
        # Each selected Build 42 module uses common assets plus its current versioned code.
        selected = {}
        for root_name in source['mediaRoots']:
            media = module / root_name
            if not media.is_dir():
                raise FileNotFoundError(media)
            for path in sorted(media.rglob('*')):
                if path.is_file():
                    relative = path.relative_to(media).as_posix()
                    if relative in selected:
                        old = selected[relative]
                        equal = sha(old.read_bytes()) == sha(path.read_bytes())
                        if not equal and relative not in source.get('versionOverrides', []):
                            raise ValueError(f'Overlapping media layers need review: {path}')
                        layer_decisions.append({
                            'modId': source['modId'], 'relativePath': relative,
                            'commonPath': old.relative_to(workshop).as_posix(),
                            'commonSha256': sha(old.read_bytes()),
                            'selectedPath': path.relative_to(workshop).as_posix(),
                            'selectedSha256': sha(path.read_bytes()),
                            'reason': 'identical bytes' if equal else 'reviewed Build 42 version-layer priority'})
                    selected[relative] = path
        lua_map = {}
        for relative in selected:
            if relative.endswith('.lua'):
                scope, suffix = relative[4:].split('/', 1)
                stem = Path(suffix).stem
                renamed = PREFIX + source['modId'].replace('-', '_') + '_' + stem
                lua_map[suffix[:-4]] = renamed
        module_maps[source['modId']] = lua_map

        for relative, path in selected.items():
            data = path.read_bytes()
            origin = {
                'workshopId': source['workshopId'], 'modId': source['modId'],
                'path': path.relative_to(workshop).as_posix(), 'sha256': sha(data),
                'author': source['author'], 'url': source['url']}
            if source['modId'].startswith('MCV') and relative.startswith('scripts/'):
                vehicles = re.findall(rb'(?m)^\s*vehicle\s+([A-Za-z0-9_]+)', data)
                collision_ids = ['Base.' + v.decode() for v in vehicles
                                 if ('Base.' + v.decode()).lower() in external]
                if collision_ids:
                    if len(collision_ids) != len(vehicles):
                        raise ValueError(f'Mixed unique/overlapping definitions: {path}')
                    for script in collision_ids:
                        rule = next((r for r in rules if r['script'] == script
                                     and r['addonModId'] == source['modId']), None)
                        if not rule or external[script.lower()]['ModId'] != rule['baseModId']:
                            raise ValueError(f'Unreviewed MCV collision: {script}')
                        omitted.append(dict(origin, script=script,
                                            baseModId=rule['baseModId'],
                                            baseScript=external[script.lower()]['Script'],
                                            disposition='keep-current-external-base'))
                    continue
            if relative == 'lua/shared/Translate/EN/IG_UI_EN.txt' and source['modId'].startswith('MCV'):
                for key, value in re.findall(r'(?m)^\s*(IGUI_\w+)\s*=\s*(.+?),\s*$',
                                             data.decode('utf-8-sig')):
                    if key in translations and translations[key] != value:
                        raise ValueError(f'Translation conflict: {key}')
                    translations[key] = value
                translation_inputs.append(origin)
                continue
            if relative.endswith('.lua'):
                scope, suffix = relative[4:].split('/', 1)
                target = f'42/media/lua/{scope}/{lua_map[suffix[:-4]]}.lua'
                text = data.decode('utf-8-sig')
                # VMZ's helper requires follow the new filenames; external contracts stay intact.
                for original, renamed in lua_map.items():
                    for quote in ('"', "'"):
                        text = text.replace(quote + original + quote, quote + renamed + quote)
                if source['modId'] == 'VMZNEW':
                    for original, replacement in NATIVE_REQUIRES.items():
                        for quote in ('"', "'"):
                            text = text.replace(quote + original + quote, quote + replacement + quote)
                    if 'YAPZLib/' in text:
                        raise ValueError(f'Unreplaced military library contract: {relative}')
                for original, canonical in aliases.items():
                    for quote in ('"', "'"):
                        text = text.replace(quote + original + quote, quote + canonical + quote)
                header = (f"-- Integrated from {source['name']} ({source['modId']}).\n"
                          f"-- Original author: {source['author']}; {source['url']}\n"
                          "-- Third-party contribution; excluded from the project MIT license.\n")
                add(target, (header + text).replace('\r\n', '\n').encode('utf-8'), [origin], 'namespaced Lua / attributed')
            else:
                if path.suffix.lower() in {'.txt', '.json', '.md'}:
                    data = data.replace(b'\r\n', b'\n')
                add('42/media/' + relative, data, [origin])

    actual_omissions = {(r['script'], r['modId']) for r in omitted}
    if actual_omissions != expected_omissions:
        raise ValueError(f'Expected/current MCV overlap drift: {actual_omissions ^ expected_omissions}')
    if not translations:
        raise ValueError('Missing MCV localization')
    translation = 'IG_UI_EN = {\n' + ''.join(
        f'    {key} = {value},\n' for key, value in sorted(translations.items())) + '}\n'
    add('42/media/lua/shared/Translate/EN/IG_UI_EN.txt',
        translation.encode('utf-8'), translation_inputs, 'merged MCV localization')

    duplicate_path = workshop / '2535461640/mods/NoDuplicateVehicles/42/media/lua/shared/NoDuplicateVehicles.lua'
    duplicate_data = duplicate_path.read_bytes()
    duplicate_ids = sorted(set(re.findall(r'["\x27](Base\.fr_[A-Za-z0-9_]+)["\x27]',
                                          duplicate_data.decode('utf-8-sig'))))
    if not duplicate_ids:
        raise ValueError('No original No Vanilla duplicate data found')
    duplicate_text = ('-- Data derived from Kraz / No Vanilla Vehicles, Workshop 2535461640.\n'
                      '-- https://steamcommunity.com/sharedfiles/filedetails/?id=2535461640\n'
                      '-- Attribution retained; this extracted data is excluded from MIT.\nreturn {\n'
                      + ''.join(f'    ["{name}"] = true,\n' for name in duplicate_ids) + '}\n')
    add(f'42/media/lua/shared/{PREFIX}DuplicateScripts.lua',
        duplicate_text.encode('utf-8'), [{
            'workshopId': '2535461640', 'modId': 'NoVanillaDuplicates',
            'path': duplicate_path.relative_to(workshop).as_posix(),
            'sha256': sha(duplicate_data), 'author': 'Kraz',
            'url': 'https://steamcommunity.com/sharedfiles/filedetails/?id=2535461640'
        }], 'extracted duplicate IDs; guarded authored replacement')

    # Validate the entire replacement set before writing anything.
    for relative, data in outputs.items():
        path = safe_target(relative)
        if path.exists() and sha(path.read_bytes()) != sha(data):
            if relative not in owned or sha(path.read_bytes()) != owned[relative]:
                raise ValueError(f'Preserving unowned/edited file: {relative}')
    for relative, old_hash in owned.items():
        path = safe_target(relative)
        if path.exists() and sha(path.read_bytes()) != old_hash:
            raise ValueError(f'Preserving edited generated content: {relative}')
    for relative in owned.keys() - outputs.keys():
        path = safe_target(relative)
        if path.exists():
            path.unlink()
    for relative, data in outputs.items():
        target = safe_target(relative)
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
    manifest = {
        'schemaVersion': 1, 'generatedBy': 'scripts/import-content.py',
        'workshopAppId': '108600',
        'authorization': 'Owner requested public attributed integration on 2026-10-23. This is not a representation of individual author permission or an MIT sublicense.',
        'authorRequests': 'An original author may contact the maintainer to request removal of their integrated content and conversion to an external dependency.',
        'bundledModuleIds': [s['modId'] for s in sources] + ['NoVanillaDuplicates'],
        'moduleRequireMaps': module_maps,
        'authoredNativeReplacements': NATIVE_REQUIRES,
        'files': [records[p] for p in sorted(records)],
        'omittedFiles': omitted, 'layerDecisions': layer_decisions,
        'mergedLocalizationKeys': len(translations),
        'duplicateIds': len(duplicate_ids),
        'reimplemented': ['NoVanillaVehicles', 'NoVanillaProf', 'NoVanillaStoriesKI5',
                          'ME422RegionalPoliceSkins'],
        'externalOnly': ['damnlib', 'WayMoreCars', 'original KI5 vehicles'],
        'notBundledOrRequired': ['YAPZLib']}
    MANIFEST.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + '\n', 'utf-8')
    print(f'Integrated {len(outputs)} files; omitted {len(omitted)} stale MCV definitions; '
          f'merged {len(translations)} names; restored {len(duplicate_ids)} duplicate IDs.')


if __name__ == '__main__':
    main()
