"""Export native location photographs with separate generated lettering."""
from pathlib import Path
import argparse,hashlib,json,shutil
from PIL import Image,ImageChops
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--capture-root',type=Path,required=True)
a=p.parse_args();CAPTURE=a.capture_root.resolve(strict=True)
allowed={(ROOT/'build/native').resolve(),(Path.home()/'AppData/Local/GameMods/OnlyKI5/Native').resolve()}
if CAPTURE.parent not in allowed or not CAPTURE.name.startswith('gallery-') or not CAPTURE.name.endswith('-natural'):
 raise ValueError('Expected an owned natural-photo lifetime')
ART=ROOT/'tools-src/gallery/natural-locations/expanded-20261024';TITLES=ROOT/'tools-src/gallery/location-titles'
OUT=ROOT/'release/workshop/gallery';BASELINE=ROOT/'release/workshop/archive/20261024-five-natural/gallery'
ART.mkdir(parents=True,exist_ok=True);OUT.mkdir(parents=True,exist_ok=True)
locations=json.loads((ROOT/'config/workshop-gallery-locations.json').read_text('utf8'))
previous=json.loads((BASELINE/'manifest.json').read_text('utf8'))
old={i['location']:i for i in previous['images']}
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
images=[]
for n,location in enumerate(locations,1):
 key=location['key'];name=f'only-ki5-location-{n:02}-{key}.jpg';target=OUT/name
 if location.get('retainApprovedImage'):
  frame=dict(old[key]);source=BASELINE/frame['file'];assert sha(source)==frame['sha256']
  shutil.copy2(source,target);frame.update(file=name,retainedApprovedImage=True,
   retainedFrom=source.relative_to(ROOT).as_posix())
  assert sha(target)==frame['sha256'];images.append(frame);continue
 record=json.loads((CAPTURE/('natural-'+key+'.json')).read_text('utf8'))
 if record['staged'] or record['vehicleMutations'] or record['spawnFixtureCalled'] or not record['photoVisibilityReveal']:
  raise ValueError('Expected unposed natural vehicles with the owned photo visibility setting')
 if record['frame']!=location['frame']:raise ValueError('Record the reviewed final observer coordinates in config: '+key)
 source=CAPTURE/'captures'/('natural-'+key+'.png');native=ART/('only-ki5-'+key+'-native.png')
 shutil.copy2(source,native);assert sha(source)==sha(native)
 original=Image.open(native).convert('RGB');assert original.size==(1280,720)
 crop=(0,0,1280,640);base=original.crop(crop).resize((1024,512),Image.Resampling.LANCZOS)
 title_path=TITLES/(key+'-master.png');title=Image.open(title_path).convert('RGBA')
 bounds=title.getchannel('A').point(lambda x:255 if x>=8 else 0).getbbox()
 assert bounds and title.getchannel('A').getextrema()[0]==0,'Title requires meaningful transparency'
 title=title.crop(bounds);height=56 if key=='louisville-highway' else 76
 width=round(title.width*height/title.height)
 if width>640:height=round(height*640/width);width=640
 title=title.resize((width,height),Image.Resampling.LANCZOS);position=(24,512-height-20)
 full=base.convert('RGBA');full.alpha_composite(title,position);full=full.convert('RGB')
 assert ImageChops.difference(base.crop((0,0,1024,position[1])),full.crop((0,0,1024,position[1]))).getbbox() is None
 composed=ART/('only-ki5-'+key+'-titled-master.png');full.save(composed,optimize=True)
 full.save(target,quality=90,optimize=True,subsampling=0)
 provenance=dict(location=location,frame=record['frame'],zoom=record['zoom'],staged=False,
  vehicleMutations=False,spawnFixtureCalled=False,photoVisibilityReveal=True,
  nearbyVehicles=record['nearbyVehicles'],nativeCaptureSha256=sha(native),captureRun=CAPTURE.name,
  carSpawnRate=record['carSpawnRate'],nativePhotoNoLighting=record['nativePhotoNoLighting'])
 record_path=ART/(key+'-capture.json');record_path.write_text(json.dumps(provenance,indent=2)+'\n',encoding='utf8')
 images.append(dict(file=name,title=location['title'],category=location['category'],location=key,
  sheriffLocation=location.get('sheriffLocation',False),expectedLivery=location.get('expectedLivery'),
  frame=record['frame'],staged=False,photoVisibilityReveal=True,captureRun=CAPTURE.name,
  master=native.relative_to(ROOT).as_posix(),masterSha256=sha(native),titleMaster=title_path.relative_to(ROOT).as_posix(),
  titleSha256=sha(title_path),titlePosition=list(position),titleDimensions=[width,height],
  sourceDimensions=[1280,720],cropBox=list(crop),dimensions=[1024,512],
  composedMaster=composed.relative_to(ROOT).as_posix(),format='JPEG',opaque=True,jpegQuality=90,chromaSubsampling='4:4:4',
  bytes=target.stat().st_size,beforeTinyPngBytes=target.stat().st_size,sha256=sha(target),
  tinyPngCompression='pending',captureProvenance=record_path.relative_to(ROOT).as_posix()))
manifest=dict(workshopId='3825545131',nativeGame='Project Zomboid 42.21.0',
 source='Unposed natural world generation in owned native photo worlds',sceneGeneratedByAI=False,
 generatedContribution='Transparent location lettering only',dimensions=[1024,512],
 processing='Native footage crop and aspect-preserving downsample; separate title composite and JPEG encoding',
 photoSettings='New scenes use a disposable Very High vehicle-abundance sandbox and the native debug no-lighting observer to remove fog of war. Approved military images retain their original bytes/default photo-world settings. No manual vehicle creation, repositioning, repair, skin or light edits. These are not population-frequency evidence.',
 images=images,totalBytes=sum(i['bytes'] for i in images))
(OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf8')
print(f'Exported {len(images)} location-labelled images, {manifest["totalBytes"]:,} bytes; approved military frames unchanged')
