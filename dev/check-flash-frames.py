"""Measure colour changes in native clip frames; never edits the footage."""
from pathlib import Path
import argparse,json
from PIL import Image,ImageStat

p=argparse.ArgumentParser();p.add_argument('directory',type=Path);p.add_argument('--output',type=Path)
p.add_argument('--roi',type=int,nargs=4,default=[580,95,960,300],metavar=('LEFT','TOP','RIGHT','BOTTOM'))
a=p.parse_args();rows=[]
for path in sorted(a.directory.glob('f*.jpg')):
    with Image.open(path) as image:
        # Fixed framing of the test car, excluding both moving player models.
        region=image.crop(tuple(a.roi)).convert('RGB')
        mean=ImageStat.Stat(region).mean
        rows.append({'file':path.name,'redMinusBlue':mean[0]-mean[2],'rgb':mean})
if not rows:raise ValueError('No native frames')
low=min(rows,key=lambda r:r['redMinusBlue']);high=max(rows,key=lambda r:r['redMinusBlue'])
result={'frames':len(rows),'roi':a.roi,'colourRange':high['redMinusBlue']-low['redMinusBlue'],
        'mostBlue':low,'mostRed':high,'framesNotModified':True}
if a.output:a.output.write_text(json.dumps(result,indent=2))
print(json.dumps(result,indent=2))
