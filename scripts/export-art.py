"""Composite the generated title over unchanged native capture pixels and export PNGs.

PZ's icon loader and Workshop preview validator use PNGDecoder. This is a
documented native-format exception to the usual opaque-JPG export rule.
"""
from pathlib import Path
import hashlib
import json
import shutil
from PIL import Image, ImageChops

ROOT = Path(__file__).resolve().parents[1]
ART = ROOT / 'tools-src/art'
capture_path = ART / 'only-ki5-native-capture.png'
title_path = ART / 'only-ki5-title-master.png'
master = ART / 'only-ki5-overhaul-master.png'
provenance = json.loads((ART / 'capture-provenance.json').read_text('utf-8'))
assert hashlib.sha256(capture_path.read_bytes()).hexdigest() == provenance['captureSha256'], 'Native capture differs from verified source'
capture = Image.open(capture_path).convert('RGB')
# A square crop containing the two complete center patrol vehicles. No scene
# redraw, color grading, background extension or vehicle edits are performed.
crop_box = (435, 375, 1140, 1080)
assert crop_box[2] <= capture.width and crop_box[3] <= capture.height
base = capture.crop(crop_box)
assert base.width == base.height
title = Image.open(title_path).convert('RGBA')
alpha_bounds = title.getchannel('A').point(lambda value: 255 if value >= 8 else 0).getbbox()
assert alpha_bounds, 'Generated title has no visible pixels'
left, top, right, bottom = alpha_bounds
title = title.crop((max(0, left - 4), max(0, top - 4),
                    min(title.width, right + 4), min(title.height, bottom + 4)))
width = round(base.width * 0.84)
height = round(title.height * width / title.width)
title = title.resize((width, height), Image.Resampling.LANCZOS)
position = ((base.width - width) // 2, base.height - height - round(base.height * 0.025))
assert position[1] >= base.height * 0.70, 'Title must stay in the bottom area'
composite = base.convert('RGBA')
composite.alpha_composite(title, position)
composite = composite.convert('RGB')
# Every pixel above the title is still the exact native screenshot crop.
assert ImageChops.difference(base.crop((0, 0, base.width, position[1])),
                             composite.crop((0, 0, base.width, position[1]))).getbbox() is None
composite.save(master, optimize=True)
records = []
for rel, size in [('mod/OnlyKI5VehicleSpawnLiveryOverhaul/only-ki5-overhaul-icon.png', 256),
                  ('mod/OnlyKI5VehicleSpawnLiveryOverhaul/only-ki5-overhaul-poster.png', 512),
                  ('release/workshop/only-ki5-overhaul-preview.png', 512)]:
    path = ROOT / rel
    path.parent.mkdir(parents=True, exist_ok=True)
    composite.resize((size, size), Image.Resampling.LANCZOS).save(path, optimize=True)
    records.append({'path': rel, 'width': size, 'height': size, 'format': 'PNG',
                    'opaque': True, 'beforeTinyPngBytes': path.stat().st_size,
                    'compression': 'pending'})

manifest = {
    'master': master.relative_to(ROOT).as_posix(), 'masterDimensions': list(composite.size),
    'masterBytes': master.stat().st_size,
    'backgroundKind': 'actual native Project Zomboid screenshot',
    'capture': capture_path.relative_to(ROOT).as_posix(),
    'captureDimensions': list(capture.size),
    'captureSha256': hashlib.sha256(capture_path.read_bytes()).hexdigest(),
    'cropBox': list(crop_box), 'titleText': 'ONLY KI5',
    'titleMaster': title_path.relative_to(ROOT).as_posix(),
    'titlePosition': list(position), 'titleDimensions': list(title.size),
    'capturePixelsAboveTitlePreserved': True,
    'formatException': 'Project Zomboid ImageData and SteamWorkshopItem use PNGDecoder; native icon/poster/preview must remain PNG even when opaque.',
    'compressionPendingReason': 'TinyPNG website explicitly blocked the unattended browser; no configured official Tinify API key was present.',
    'derivatives': records,
}
(ART / 'exports.json').write_text(json.dumps(manifest, indent=2) + '\n', 'utf-8')
for version in ('', '42/'):
    path = ROOT / ('mod/OnlyKI5VehicleSpawnLiveryOverhaul/' + version + 'mod.info')
    assert 'icon=only-ki5-overhaul-icon.png' in path.read_text('utf-8')
    if version:
        for name in ('only-ki5-overhaul-icon.png', 'only-ki5-overhaul-poster.png'):
            shutil.copy2(ROOT / 'mod/OnlyKI5VehicleSpawnLiveryOverhaul' / name, path.parent / name)
print(f'Exported real gameplay capture with ONLY KI5 at {position}, size {title.size}; untouched capture pixels verified.')
print('Native PNG format required; TinyPNG compression remains pending.')
