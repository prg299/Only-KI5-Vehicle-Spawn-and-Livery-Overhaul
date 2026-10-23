"""Export actual native gameplay frames; preserve original captures separately.

Only rectangular framing and opaque JPEG encoding are applied. No generated art,
retouching, recoloring, compositing, background fill or upscaling is performed.
"""
from pathlib import Path
import hashlib
import json
import shutil
from PIL import Image

ROOT=Path(__file__).resolve().parents[1]
RUN='gallery-20261023-a'
SOURCES=ROOT/'build/native'/RUN/'captures'
MASTERS=ROOT/'tools-src/gallery'
OUTPUT=ROOT/'release/workshop/gallery'
MASTERS.mkdir(parents=True,exist_ok=True)
OUTPUT.mkdir(parents=True,exist_ok=True)
SCENES=[
 ('01-louisville-police','police','Louisville police liveries', (180,15,1108,537),True),
 ('02-silent-lightbars','lightbars','Flashing lightbars, sirens off', (180,15,1108,537),True),
 ('03-military-checkpoint','checkpoint','The Louisville checkpoint fleet',None,False),
 ('04-military-blockpost','blockpost','Military roadside blockpost',None,True),
 ('05-military-convoy','convoy','Military convoy and matching camo',None,True),
 ('06-highway-traffic','traffic','KI5 highway traffic and trailer spawns',(280,40,1160,535),False),
 ('07-integrated-variants','variant-close','Integrated Commando and ambulance variants',None,True),
]

def digest(path):return hashlib.sha256(path.read_bytes()).hexdigest()

records=[]
for slug,scene,title,crop,staged in SCENES:
    original=SOURCES/('gallery-'+scene+'.png')
    master=MASTERS/('only-ki5-'+slug+'-native.png')
    if original.exists():
        shutil.copy2(original,master)
        assert digest(master)==digest(original)
    else:
        assert master.is_file(),'Neither the owned capture nor its retained native master exists'
    source=Image.open(master)
    if 'A' in source.getbands():
        assert source.getchannel('A').getextrema()==(255,255),'Native frame has meaningful transparency'
    frame=source.convert('RGB')
    if crop:frame=frame.crop(crop)
    assert frame.width*9==frame.height*16,'Gallery frame must retain 16:9 composition'
    target=OUTPUT/('only-ki5-'+slug+'.jpg')
    frame.save(target,quality=82,optimize=True,subsampling=2)
    records.append(dict(file=target.name,title=title,scene=scene,staged=staged,
        captureRun=RUN,master=master.relative_to(ROOT).as_posix(),masterSha256=digest(master),
        sourceDimensions=list(source.size),cropBox=list(crop) if crop else None,
        dimensions=list(frame.size),format='JPEG',opaque=True,jpegQuality=82,chromaSubsampling='4:2:0',
        bytes=target.stat().st_size,sha256=digest(target),tinyPngCompression='pending'))
# Do not lower quality silently to force a staging-quota fit. Review the actual
# exported images first; the uploader independently checks the live quota.
total=sum(r['bytes'] for r in records)
manifest=dict(workshopId='3825545131',nativeGame='Project Zomboid 42.21.0',
    source='Owned isolated native game framebuffer, 2026-10-23',
    sceneGeneratedByAI=False,processing='16:9 crop where recorded, then JPEG encoding; no pixel retouching or resizing',
    dimensionPolicy='Native screenshots retain 16:9 and their original pixel density; these are not ImageGen assets.',
    photoSettings='Hidden HUD, daylight/ambient overrides, disabled radio devices, dressed photo character; staged scenes marked per image.',
    credits=['The Indie Stone: Project Zomboid','KI5 and original fleet creators: vehicle models',
             'Integrated addon creators: police liveries, variants, camo and scene recipes; see CREDITS.md',
             'Erika / prg299: integration and native capture session'],
    tinyPngCompression='pending: official website rejected all seven valid JPEGs as INVALID with Something went wrong; no official API key configured',
    images=records,totalBytes=total)
(OUTPUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n','utf-8')
print(f'Exported {len(records)} real gameplay gallery images, {total:,} bytes; native masters retained.')
