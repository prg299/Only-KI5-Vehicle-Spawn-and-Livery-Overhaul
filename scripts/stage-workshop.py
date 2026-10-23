"""Prepare a new public Workshop item locally. Never logs in or uploads."""
from pathlib import Path
import hashlib, json, shutil

ROOT = Path(__file__).resolve().parents[1]
stage = ROOT/'build/workshop/KI5KnoxCountyFleet'
package = stage/'Contents/mods/KI5KnoxCountyFleet'
if stage.exists():
    raise SystemExit('Stage already exists; archive it or choose a clean checkout before preparing again.')
package.parent.mkdir(parents=True)
shutil.copytree(ROOT/'mod/KI5KnoxCountyFleet', package)
shutil.copy2(ROOT/'release/workshop/knox-fleet-preview.png', stage/'preview.png')
shutil.copy2(ROOT/'release/workshop/workshop.txt', stage/'workshop.txt')
shutil.copy2(ROOT/'release/workshop/dependencies.json', stage/'dependencies.json')
manifest = {p.relative_to(package).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in sorted(package.rglob('*')) if p.is_file()}
(stage/'payload-manifest.json').write_text(json.dumps(manifest, indent=2)+'\n', 'utf-8')
print(f'Prepared {len(manifest)} payload files at {stage}')
print('New-item metadata has a blank Workshop ID and public visibility. Nothing uploaded.')
