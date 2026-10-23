"""Portable structural checks. Does not claim native gameplay or Workshop delivery."""
from pathlib import Path
import ast, hashlib, json, re

ROOT = Path(__file__).resolve().parents[1]
MOD = ROOT / 'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
errors = []

def check(ok, message):
    if not ok:
        errors.append(message)

def info(path):
    return dict(line.split('=', 1) for line in path.read_text('utf-8-sig').splitlines() if '=' in line)

profile = info(ROOT / 'config/fleet-profile.ini')
root_info, b42 = info(MOD / 'mod.info'), info(MOD / '42/mod.info')
check(root_info == b42, 'Root and B42 descriptors differ')
check(b42['name'] == 'Only KI5: Vehicle Spawn & Livery Overhaul', 'Wrong display name')
check(b42['id'] == 'OnlyKI5VehicleSpawnLiveryOverhaul', 'Wrong mod identity')
check(b42['modversion'] == '0.2.0' and b42['versionMin'] == '42.21', 'Wrong release version')
check(set(b42['require'].split(',')) == set(profile['Mods'].split(';')), 'Profile/dependency drift')
check(set(b42['require'].split(',')) <= set(b42['loadModAfter'].split(',')), 'Missing load-order edges')
check(not set(b42['require'].split(',')) & set(b42['incompatible'].split(',')), 'Dependency declared incompatible')
for name in ['icon', 'poster']:
    for folder in [MOD, MOD/'42']:
        check((folder / b42[name]).is_file(), f'Missing {name} in {folder.name}')
inventory = json.loads((ROOT/'docs/ki5-provider-inventory.json').read_text('utf-8'))
imports = json.loads((ROOT/'docs/imported-content.json').read_text('utf-8'))
sources = json.loads((ROOT/'config/bundled-sources.json').read_text('utf-8'))
check(set(inventory['bundledModuleIds']) == set(imports['bundledModuleIds']), 'Bundled inventory drift')
check({'WayMoreCars', 'YAPZLib', 'damnlib'} <= set(b42['require'].split(',')), 'Missing external framework')
check(set(imports['bundledModuleIds']) <= set(b42['incompatible'].split(',')), 'Integrated originals must conflict')
check(not set(imports['bundledModuleIds']) & set(b42['require'].split(',')), 'Integrated module still required externally')
check(all(p['ModId'] in imports['bundledModuleIds'] for p in inventory['providers'] if p['Bundled']), 'Unexpected bundled vehicle provider')
rules = json.loads((ROOT/'config/merge-rules.json').read_text('utf-8'))
check({(r['script'], r['baseModId'], r['addonModId']) for r in rules} ==
      {(r['script'], r['baseModId'], r['modId']) for r in imports['omittedFiles']}, 'Upstream collision filtering differs from explicit merge decisions')
check(not inventory['overrides'], 'Duplicate vehicle definitions survived filtering')
check(set(inventory['externalRequiredModules']) == set(b42['require'].split(',')), 'Inventory/dependency drift')
check('SpecLoot' not in b42['require'], 'Specific Loot exclusion lost')
check('ME422KI5VehicleSuite' in b42['incompatible'], 'Private predecessor must conflict')
lua_files = list(MOD.rglob('*.lua'))
imported = {entry['targetPath']: entry for entry in imports['files']}
allowed_origins = {s['workshopId'] for s in sources} | {'2535461640'}
for relative, entry in imported.items():
    path = (MOD/relative).resolve()
    check(path.is_relative_to(MOD.resolve()), 'Import escaped mod root')
    check(path.is_file() and hashlib.sha256(path.read_bytes()).hexdigest() == entry['sha256'], 'Imported content drift: '+relative)
    check(bool(entry['sources']) and all(s['workshopId'] in allowed_origins for s in entry['sources']), 'Unknown import origin: '+relative)
    check(not any(s['workshopId'] in {'3171167894', '3520758551', '3624971238'} for s in entry['sources']), 'External framework was bundled')
authored_lua = [p for p in lua_files if p.relative_to(MOD).as_posix() not in imported]
check(len(authored_lua) == 7, f'Unexpected authored runtime module count {len(authored_lua)}')
module_names = {p.stem for p in lua_files}
for p in lua_files:
    text = p.read_text('utf-8')
    check(p.stem.startswith('OnlyKI5VehicleSpawnLiveryOverhaul_'), f'Unrenamed runtime filename {p.name}')
    check(not re.search(r'ME422|ME 422|me422_', text), f'Old runtime identity in {p.name}')
    for target in re.findall(r'require\s*\(?\s*["\'](OnlyKI5VehicleSpawnLiveryOverhaul_[^"\']+)["\']', text):
        check(target in module_names, f'Unresolved authored require {target}')
for p in MOD.rglob('*'):
    if not p.is_file():
        continue
    check(p.name == 'LICENSE' or p.suffix.lower() in {'.info', '.lua', '.md', '.png', '.txt', '.json', '.fbx'}, f'Unexpected shipped file {p.name}')
    if '/media/' in p.as_posix() and p.suffix != '.lua':
        check(p.relative_to(MOD).as_posix() in imported, f'Unmanifested content shipped {p.name}')
    if p.suffix.lower() not in {'.png', '.fbx'}:
        check('C:\\Users\\erika' not in p.read_text('utf-8', errors='ignore'), 'Private absolute path in payload')
for p in (ROOT/'scripts').glob('*.py'):
    ast.parse(p.read_text('utf-8'), filename=str(p))
dependencies = json.loads((ROOT/'release/workshop/dependencies.json').read_text('utf-8'))
check({d['workshopId'] for d in dependencies} == set(profile['WorkshopItems'].split(';')), 'Workshop dependency drift')
audit = json.loads((ROOT/'docs/permissions-audit.json').read_text('utf-8'))
check({d['workshopId'] for d in dependencies} <= {i['workshopId'] for i in audit['items']}, 'Unaudited dependency')
check((ROOT/'LICENSE').read_text().startswith('MIT License'), 'Missing MIT license')
check('imported-content.json' in (ROOT/'LICENSE').read_text(), 'MIT exclusion missing')
description = (ROOT/'release/workshop/description.txt').read_text('utf-8')
check('external dependency' in description and 'original author' in description, 'Missing author-contact/dependency statement')
for wid in allowed_origins | {'3395145553', '3520758551', '3624971238', '3171167894'}:
    check('id='+wid in description, 'Missing Workshop description attribution link: '+wid)
capture_record = json.loads((ROOT/'tools-src/art/capture-provenance.json').read_text('utf-8'))
capture_path = ROOT/'tools-src/art'/capture_record['captureFile']
check(hashlib.sha256(capture_path.read_bytes()).hexdigest() == capture_record['captureSha256'], 'Verified native artwork capture changed')
for required in ['README.md', 'CREDITS.md', 'THIRD_PARTY_NOTICES.md', 'CONTRIBUTING.md', 'SECURITY.md', 'docs/release-readiness.md']:
    check((ROOT/required).is_file(), 'Missing '+required)

# Original prompts/masters are historical provenance. Every active owned path
# and text reference must use the current project identity.
former_names = ('ki5knoxcountyfleet', 'ki5-knox-county-fleet', 'knox county fleet',
                'knox-fleet', 'knox_fleet', 'kcf_java_home')
text_extensions = {'.md', '.lua', '.py', '.ps1', '.java', '.json', '.ini', '.info', '.txt', '.yml', '.yaml'}
active_files = [p for p in ROOT.iterdir() if p.is_file()]
for directory in ('.github', 'config', 'docs', 'mod', 'release', 'scripts', 'tools-src'):
    active_files.extend(p for p in (ROOT/directory).rglob('*')
                        if p.is_file() and 'archive' not in p.relative_to(ROOT).parts)
for path in active_files:
    relative = path.relative_to(ROOT).as_posix()
    check(not any(name in relative.lower() for name in former_names), 'Former brand in active filename: '+relative)
    if path != Path(__file__).resolve() and (path.suffix.lower() in text_extensions or path.name == 'LICENSE'):
        check(not any(name in path.read_text('utf-8-sig').lower() for name in former_names),
              'Former brand in active text: '+relative)
if errors:
    raise SystemExit('\n'.join(errors))
print(f'PASS: {len(authored_lua)} authored and {len(lua_files)-len(authored_lua)} integrated Lua modules; {len(imported)} attributed files; {len(dependencies)} external Workshop dependencies; metadata, provenance, current branding and Python syntax.')
