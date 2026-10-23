"""Prepare a Workshop stage locally. Never logs in or uploads."""
from pathlib import Path
import hashlib, json, shutil

ROOT = Path(__file__).resolve().parents[1]
stage = ROOT/'build/workshop/OnlyKI5VehicleSpawnLiveryOverhaul'
package = stage/'Contents/mods/OnlyKI5VehicleSpawnLiveryOverhaul'
if stage.exists():
    raise SystemExit('Stage already exists; archive it or choose a clean checkout before preparing again.')
package.parent.mkdir(parents=True)
shutil.copytree(ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul', package)
shutil.copy2(ROOT/'release/workshop/only-ki5-overhaul-preview.png', stage/'preview.png')
shutil.copy2(ROOT/'release/workshop/workshop.txt', stage/'workshop.txt')
shutil.copy2(ROOT/'release/workshop/dependencies.json', stage/'dependencies.json')
manifest = {p.relative_to(package).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in sorted(package.rglob('*')) if p.is_file()}
(stage/'payload-manifest.json').write_text(json.dumps(manifest, indent=2)+'\n', 'utf-8')
print(f'Prepared {len(manifest)} payload files at {stage}')
metadata=json.loads((ROOT/'release/workshop/metadata.json').read_text())
print('Target visibility: '+metadata['visibility']+'. Nothing uploaded.')
