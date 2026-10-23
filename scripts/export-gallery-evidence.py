"""Export only the whitelisted, stopped native photo-session receipt."""
from pathlib import Path
import hashlib,json,sys

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'dev'))
from native_paths import owned_run

run=owned_run('gallery-20261024-g-natural')
finished=json.loads((run/'finished.json').read_text('utf8'))
exit_record=json.loads((run/'sp/native-session-exit.json').read_text('utf8'))
assert exit_record['exitCode']==0 and exit_record['desktopSwitched'] is False
source=ROOT/'mod/OnlyKI5VehicleSpawnLiveryOverhaul'
current={p.relative_to(source).as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
         for p in source.rglob('*') if p.is_file()}
tested=json.loads((run/'inputs.json').read_text('utf8'))['payload']
assert {k.replace('\\','/'):v for k,v in tested.items()}==current
gallery=json.loads((ROOT/'release/workshop/gallery/manifest.json').read_text('utf8'))
records=[]
for image in gallery['images']:
    if image.get('retainedApprovedImage'):continue
    record=json.loads((run/('natural-'+image['location']+'.json')).read_text('utf8'))
    assert record['staged'] is False and record['vehicleMutations'] is False
    assert record['spawnFixtureCalled'] is False and record['nativePhotoNoLighting'] is True
    assert record['frame']==image['frame'] and record['carSpawnRate']==5
    capture=run/'captures'/('natural-'+image['location']+'.png')
    assert hashlib.sha256(capture.read_bytes()).hexdigest()==image['masterSha256']
    records.append(dict(location=image['location'],frame=record['frame'],zoom=record['zoom'],
                        player=record['player'],lookAt=record.get('lookAt'),
                        nativeCaptureSha256=image['masterSha256']))
assert len(records)==12
out=ROOT/'docs/validation/gallery-20261024/evidence.json'
out.parent.mkdir(parents=True,exist_ok=True)
out.write_text(json.dumps(dict(run=run.name,payloadVersion='0.3.2',game='42.21.0',
    purpose='Photo framing and appearance only; not population-frequency or gameplay acceptance',
    seconds=finished['seconds'],cleanExit={k:exit_record[k] for k in
        ('exitCode','desktopSwitched','keeperInJob','gameInJob')},
    resourceGuardPeakGiB=8.18,carSpawnRate=5,nativePhotoNoLighting=True,
    manualVehicleCreation=False,vehicleMutations=False,spawnFixturesCalled=False,
    captures=records),indent=2)+'\n',encoding='utf8')
print('Exported clean native photo exit and twelve exact source-capture hashes')
