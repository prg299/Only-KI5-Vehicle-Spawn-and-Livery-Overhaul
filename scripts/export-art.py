"""Prepare derivatives from the ImageGen master; TinyPNG compression is a separate step."""
from pathlib import Path
import json
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
master = ROOT / 'tools-src/art/only-ki5-overhaul-master.png'
im = Image.open(master).convert('RGBA')
assert im.width == im.height, 'Preserve square composition'
assert im.getextrema()[3][0] < 255, 'Transparency must be meaningful'
records = []
for rel, size in [('mod/OnlyKI5VehicleSpawnLiveryOverhaul/only-ki5-overhaul-icon.png', 256),
                  ('mod/OnlyKI5VehicleSpawnLiveryOverhaul/only-ki5-overhaul-poster.png', 512),
                  ('release/workshop/only-ki5-overhaul-preview.png', 512)]:
    p = ROOT / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    im.resize((size, size), Image.Resampling.LANCZOS).save(p, optimize=True)
    records.append({'path': rel, 'width': size, 'height': size, 'format': 'PNG',
                    'beforeTinyPngBytes': p.stat().st_size, 'compression': 'pending'})
(ROOT / 'tools-src/art/exports.json').write_text(json.dumps({
    'master': master.relative_to(ROOT).as_posix(), 'masterDimensions': list(im.size),
    'masterBytes': master.stat().st_size, 'derivatives': records}, indent=2) + '\n', 'utf-8')
for version in ('', '42/'):
    p = ROOT / ('mod/OnlyKI5VehicleSpawnLiveryOverhaul/' + version + 'mod.info')
    p.write_text(p.read_text('utf-8').replace('only-ki5-overhaul-poster.jpg', 'only-ki5-overhaul-poster.png')
                 .replace('only-ki5-overhaul-icon.jpg', 'only-ki5-overhaul-icon.png'), 'utf-8', newline='\n')
    if version:
        import shutil
        for name in ('only-ki5-overhaul-icon.png', 'only-ki5-overhaul-poster.png'):
            shutil.copy2(ROOT / 'mod/OnlyKI5VehicleSpawnLiveryOverhaul' / name, p.parent / name)
print('Prepared PNG derivatives with meaningful corner transparency; TinyPNG still required.')
