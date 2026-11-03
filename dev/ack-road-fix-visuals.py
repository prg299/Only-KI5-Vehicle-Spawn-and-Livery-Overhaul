"""Record an actual reviewer decision for exact native frames, never auto-review."""
import argparse,hashlib,json
from datetime import datetime,timezone
from native_paths import owned_run
p=argparse.ArgumentParser(description=__doc__);p.add_argument('run');p.add_argument('--note',required=True);a=p.parse_args()
run=owned_run(a.run)
assert (run/'road-fixes-frames-ready.json').is_file() and not (run/'finished.json').exists(),'No live visual review gate'
ready=json.loads((run/'road-fixes-frames-ready.json').read_text())
frames={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in (run/'captures').glob('road-fixes-*.png')}
assert frames and set(frames)==set(ready['frames']),'Retakes must preserve the expected scene/peer set'
assert len(a.note.strip())>=30,'Explain the actual visual review and any limits'
receipt={'accepted':True,'reviewer':'assistant','humanAcceptance':False,'reviewedUtc':datetime.now(timezone.utc).isoformat(),'frames':frames,'note':a.note}
pending=run/'road-fixes-visual-review.pending';pending.write_text(json.dumps(receipt,indent=2)+'\n','utf8');pending.replace(run/'road-fixes-visual-review.json')
print('Recorded visual review of '+str(len(frames))+' exact native frames')
