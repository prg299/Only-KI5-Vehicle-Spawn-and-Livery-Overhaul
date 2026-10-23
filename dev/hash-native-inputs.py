"""Fingerprint immutable owned test inputs without redistributing their bytes."""
from pathlib import Path
import argparse, hashlib, json

root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('run');a=p.parse_args()
run=(root/'build/native'/a.run).resolve()
if not run.is_relative_to(root/'build/native'):raise ValueError('Owned run root')
records={};summary={}
for folder in sorted((run/'inputs/mods').iterdir()):
    digest=hashlib.sha256();size=0;count=0
    for path in sorted(folder.rglob('*')):
        if not path.is_file():continue
        file_hash=hashlib.sha256()
        with path.open('rb') as stream:
            for block in iter(lambda:stream.read(1024*1024),b''):file_hash.update(block)
        relative=path.relative_to(folder).as_posix()
        value=file_hash.hexdigest()
        records[folder.name+'/'+relative]=value
        digest.update((relative+'\0'+value+'\n').encode())
        count+=1;size+=path.stat().st_size
    summary[folder.name]={'files':count,'bytes':size,'sha256':digest.hexdigest()}
(run/'input-file-hashes.json').write_text(json.dumps(records,indent=2)+'\n')
(run/'input-fingerprints.json').write_text(json.dumps(summary,indent=2)+'\n')
print(f'Fingerprinted {len(records)} immutable input files in {len(summary)} folders')
