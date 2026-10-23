"""Prepare derivatives from the ImageGen master; TinyPNG compression is a separate step."""
from pathlib import Path
import json
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
master = ROOT / 'tools-src/art/knox-fleet-master.png'
im = Image.open(master).convert('RGBA')
assert im.width == im.height, 'Preserve square composition'
assert im.getextrema()[3][0] < 255, 'Transparency must be meaningful'
records = []
for rel, size in [('mod/KI5KnoxCountyFleet/knox-fleet-icon.png', 256),
                  ('mod/KI5KnoxCountyFleet/knox-fleet-poster.png', 512),
                  ('release/workshop/knox-fleet-preview.png', 512)]:
    p = ROOT / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    im.resize((size, size), Image.Resampling.LANCZOS).save(p, optimize=True)
    records.append({'path': rel, 'width': size, 'height': size, 'format': 'PNG',
                    'beforeTinyPngBytes': p.stat().st_size, 'compression': 'pending'})
(ROOT / 'tools-src/art/exports.json').write_text(json.dumps({
    'master': master.relative_to(ROOT).as_posix(), 'masterDimensions': list(im.size),
    'masterBytes': master.stat().st_size, 'derivatives': records}, indent=2) + '\n', 'utf-8')
for version in ('', '42/'):
    p = ROOT / ('mod/KI5KnoxCountyFleet/' + version + 'mod.info')
    p.write_text(p.read_text('utf-8').replace('knox-fleet-poster.jpg', 'knox-fleet-poster.png')
                 .replace('knox-fleet-icon.jpg', 'knox-fleet-icon.png'), 'utf-8', newline='\n')
    if version:
        import shutil
        for name in ('knox-fleet-icon.png', 'knox-fleet-poster.png'):
            shutil.copy2(ROOT / 'mod/KI5KnoxCountyFleet' / name, p.parent / name)
print('Prepared PNG derivatives with meaningful corner transparency; TinyPNG still required.')
