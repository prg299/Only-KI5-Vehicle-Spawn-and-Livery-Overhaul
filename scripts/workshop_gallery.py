"""Upload the reviewed native gallery and optional description through owner Steam.

RVI-derived client; default read-only. Does not upload content, replace the main
cover, change visibility, or modify requirements. Run through run-heavy.mjs.
"""
from pathlib import Path
import argparse
from datetime import datetime, timezone
import hashlib
import json
from urllib.parse import urlparse
from urllib.request import urlopen
import steam_ugc
from workshop_upload import RELEASE, PRIVATE, saved_id, write


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--upload', action='store_true')
    parser.add_argument('--description', action='store_true', help='Sync reviewed description; requires --upload')
    parser.add_argument('--verify-images', action='store_true', help='Read back each original Steam CDN image and compare SHA-256')
    parser.add_argument('--description-only',action='store_true')
    parser.add_argument('--replace-gallery',action='store_true',help='Replace the explicitly reviewed previous gallery')
    args = parser.parse_args()
    if args.description and not args.upload:
        parser.error('--description requires --upload')
    if args.description_only and not (args.upload and args.description):
        parser.error('--description-only requires --upload --description')
    if args.replace_gallery and (not args.upload or args.description_only):
        parser.error('--replace-gallery requires --upload and cannot combine with --description-only')
    item = saved_id()
    if item != '3825545131':
        raise ValueError('Gallery tool is restricted to the new Only KI5 item')
    steam_ugc.ITEM = int(item)
    steam_ugc.DEPENDENCIES = {int(d['workshopId']): d['name'] for d in
                             json.loads((RELEASE/'dependencies.json').read_text('utf-8'))}
    steam = steam_ugc.Steam()
    try:
        before = steam.query()
        quota = steam.cloud_quota()
        print(json.dumps(dict(workshopId=item, visibility=before['visibility'],
                              galleryImages=len(before['previews']), quota=quota)), flush=True)
        if args.verify_images:
            manifest=json.loads((RELEASE/'gallery/manifest.json').read_text('utf-8'))
            if [p['name'] for p in before['previews']] != [i['file'] for i in manifest['images']]:
                raise ValueError('Live gallery differs from reviewed order')
            checks=[]
            for preview,record in zip(before['previews'],manifest['images']):
                parsed=urlparse(preview['url'])
                if parsed.scheme!='https' or not parsed.hostname.endswith(('.steamusercontent.com','.steamstatic.com')):
                    raise ValueError('Unexpected gallery CDN origin')
                with urlopen(preview['url'],timeout=30) as response:
                    content=response.read(1_000_001)
                if len(content)!=record['bytes'] or hashlib.sha256(content).hexdigest()!=record['sha256']:
                    raise ValueError('Steam CDN gallery bytes differ: '+record['file'])
                checks.append(dict(file=record['file'],bytes=len(content),sha256=record['sha256'],matches=True))
            write(RELEASE/'gallery-download-verified.json',dict(workshopId=item,
                  verifiedUtc=datetime.now(timezone.utc).isoformat(),allImagesMatch=True,images=checks))
            print('Steam CDN originals match all '+str(len(checks))+' reviewed gallery images byte for byte')
        if not args.upload:
            return
        if before['visibility'] != 3 or set(before['dependencies']) != set(steam_ugc.DEPENDENCIES):
            raise ValueError('Unlisted visibility and exact requirements must be verified first')
        manifest = json.loads((RELEASE/'gallery/manifest.json').read_text('utf-8'))
        files = []
        for record in manifest['images']:
            path = (RELEASE/'gallery'/record['file']).resolve(strict=True)
            if not path.is_relative_to((RELEASE/'gallery').resolve()) or path.suffix != '.jpg':
                raise ValueError('Gallery image escaped reviewed folder or format')
            if path.stat().st_size >= 1_000_000 or hashlib.sha256(path.read_bytes()).hexdigest() != record['sha256']:
                raise ValueError('Gallery image differs from reviewed manifest')
            files.append(path)
        names = [p.name for p in files]
        if len(set(names))!=len(names):raise ValueError('Duplicate gallery filenames')
        previous = [p['name'] for p in before['previews']]
        cursor=0;replace_first=False
        if args.description_only:
            files=[];names=previous
        elif args.replace_gallery:
            baselines=[]
            for folder in ('20261023-initial-gallery','20261024-five-natural'):
                baseline=json.loads((RELEASE/'archive'/folder/'page-verified.json').read_text('utf-8'))
                baselines.append([p['name'] for p in baseline['previews']])
            if previous==names[:len(previous)]:cursor=len(previous)
            elif previous in baselines:replace_first=True
            else:
                raise ValueError('Live gallery differs from the explicitly reviewed replacement baseline')
        elif previous != names[:len(previous)]:
            raise ValueError('Existing gallery differs from reviewed order; refusing replacement')
        else:cursor=len(previous)
        description = None
        if args.description:
            description = (RELEASE/'description.txt').read_text('utf-8-sig').strip()+'\n\nMod ID: OnlyKI5VehicleSpawnLiveryOverhaul'
            if '\x00' in description or len(description.encode('utf-8')) >= 8000:
                raise ValueError('Description exceeds Steam limits')
        attempt = dict(workshopId=item, before=before, quota=quota,
                       files=[p.name for p in files], status='submitting')
        write(PRIVATE/'gallery-attempt.json', attempt)
        after=before;batches=[]
        if args.description_only or (cursor==len(files) and description is not None):
            steam.upload_page([],after,description)
            after=steam.query()
        while cursor<len(files):
            available=steam.cloud_quota()['availableBytes']
            budget=min(900_000,available-1024)
            batch=[];size=0
            for path in files[cursor:]:
                if size+path.stat().st_size>budget:break
                batch.append(path);size+=path.stat().st_size
            if not batch:raise ValueError('A reviewed image exceeds available staging quota; no quality reduction attempted')
            steam.upload_page(batch,after,description if not batches else None,replace_first)
            replace_first=False;cursor+=len(batch);after=steam.query()
            if [p['name'] for p in after['previews']]!=names[:cursor]:
                raise RuntimeError('Batch order verification pending; query before resuming')
            for key in ('title','visibility','cover','dependencies'):
                if after[key]!=before[key]:raise RuntimeError('Unexpected '+key+' change during gallery batch')
            batches.append(dict(files=[p.name for p in batch],bytes=size,availableBefore=available))
            write(PRIVATE/'gallery-attempt.json',dict(attempt,verifiedPrefix=cursor,batches=batches))
            print('Verified gallery batch: '+str(cursor)+'/'+str(len(names))+' images',flush=True)
        for key in ('title', 'visibility', 'cover'):
            if after[key] != before[key]:
                raise RuntimeError('Unexpected '+key+' change during gallery update')
        if set(after['dependencies']) != set(before['dependencies']):
            raise RuntimeError('Unexpected requirements change during gallery update')
        if [p['name'] for p in after['previews']] != names or any(p['type'] != 0 for p in after['previews']):
            raise RuntimeError('Gallery commit returned success but fresh order verification is pending')
        expected = description if description is not None else before['description']
        if after['description'].replace('\r\n', '\n') != expected.replace('\r\n', '\n'):
            raise RuntimeError('Description verification is pending; query before retrying')
        stamp = datetime.now(timezone.utc).isoformat()
        receipt = dict(workshopId=item, verified=True, verifiedUtc=stamp,
                       descriptionSha256=hashlib.sha256(after['description'].replace('\r\n','\n').encode()).hexdigest(),
                       galleryImages=len(after['previews']), gallery=after['previews'],
                       preserved=['title', 'visibility', 'cover', 'dependencies', 'content'],
                       payloadUploadAttempted=False, quotaBefore=quota,batches=batches)
        write(RELEASE/'page-update-verified.json', receipt)
        write(RELEASE/'page-verified.json', dict(queriedUtc=stamp, **after))
        write(PRIVATE/'gallery-attempt.json', dict(attempt, status='verified'))
        print('Verified '+str(len(after['previews']))+' ordered gallery images; cover, unlisted visibility and requirements preserved')
    finally:
        steam.api.SteamAPI_Shutdown()


if __name__ == '__main__':
    main()
