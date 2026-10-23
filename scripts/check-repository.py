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
check(b42['modversion'] == '0.1.0' and b42['versionMin'] == '42.21', 'Wrong release version')
check(set(b42['require'].split(',')) == set(profile['Mods'].split(';')), 'Profile/dependency drift')
check(set(b42['require'].split(',')) <= set(b42['loadModAfter'].split(',')), 'Missing load-order edges')
check(not set(b42['require'].split(',')) & set(b42['incompatible'].split(',')), 'Dependency declared incompatible')
for name in ['icon', 'poster']:
    for folder in [MOD, MOD/'42']:
        check((folder / b42[name]).is_file(), f'Missing {name} in {folder.name}')
inventory = json.loads((ROOT/'docs/ki5-provider-inventory.json').read_text('utf-8'))
check(not inventory['bundledModuleIds'], 'Bundled dependencies are forbidden')
check(all(not p['Bundled'] for p in inventory['providers']), 'Unexpected bundled provider')
rules = json.loads((ROOT/'config/merge-rules.json').read_text('utf-8'))
check({(r['script'], r['baseModId'], r['addonModId']) for r in rules} ==
      {(r['Script'], r['ReplacedModId'], r['ReplacingModId']) for r in inventory['overrides']}, 'Upstream collision inventory differs from explicit merge decisions')
check(set(inventory['externalRequiredModules']) == set(b42['require'].split(',')), 'Inventory/dependency drift')
check('SpecLoot' not in b42['require'], 'Specific Loot exclusion lost')
check('ME422KI5VehicleSuite' in b42['incompatible'], 'Private predecessor must conflict')
lua_files = list(MOD.rglob('*.lua'))
check(len(lua_files) == 7, f'Unexpected runtime module count {len(lua_files)}')
module_names = {p.stem for p in lua_files}
for p in lua_files:
    text = p.read_text('utf-8')
    check(p.stem.startswith('OnlyKI5VehicleSpawnLiveryOverhaul_'), f'Unrenamed runtime filename {p.name}')
    check(not re.search(r'ME422|ME 422|me422_', text), f'Old runtime identity in {p.name}')
    for target in re.findall(r'require\s*["\'](OnlyKI5VehicleSpawnLiveryOverhaul_[^"\']+)["\']', text):
        check(target in module_names, f'Unresolved authored require {target}')
for p in MOD.rglob('*'):
    if not p.is_file():
        continue
    check(p.name == 'LICENSE' or p.suffix.lower() in {'.info', '.lua', '.md', '.png'}, f'Unexpected shipped file {p.name}')
    check('/media/scripts/' not in p.as_posix() and '/media/textures/' not in p.as_posix(), f'Upstream asset shipped {p.name}')
    check('C:\\Users\\erika' not in p.read_text('utf-8', errors='ignore') if p.suffix != '.png' else True, 'Private absolute path in payload')
for p in (ROOT/'scripts').glob('*.py'):
    ast.parse(p.read_text('utf-8'), filename=str(p))
dependencies = json.loads((ROOT/'release/workshop/dependencies.json').read_text('utf-8'))
check({d['workshopId'] for d in dependencies} == set(profile['WorkshopItems'].split(';')), 'Workshop dependency drift')
audit = json.loads((ROOT/'docs/permissions-audit.json').read_text('utf-8'))
check({d['workshopId'] for d in dependencies} <= {i['workshopId'] for i in audit['items']}, 'Unaudited dependency')
check((ROOT/'LICENSE').read_text().startswith('MIT License'), 'Missing MIT license')
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
print(f'PASS: {len(lua_files)} authored/generated Lua modules; {len(dependencies)} external Workshop dependencies; metadata, rights boundary, current branding and Python syntax.')
