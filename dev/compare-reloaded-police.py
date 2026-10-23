"""Compare saved authority decisions with both actual rejoined native peers."""
from pathlib import Path
import json

root = Path(__file__).resolve().parents[1]
run = root/'build/native/multiplayer-20261023-c-reload'

def rows(value):
    return list(value.values()) if isinstance(value, dict) else value

authority = rows(json.loads((run/'server-after-reload.json').read_text())['value']['vehicles'])
saved = json.loads((run/'saved-police-comparison.json').read_text())
assert len(saved) == 20
assert all(r['matches'] == 1 and r['oldLights'] == r['newLights']
           and r['oldSiren'] == r['newSiren'] == 0 and r['skinSame']
           and r['decisionSame'] for r in saved)
checks = []
for client, filename in [('a', 'client-a-final-reload.json'), ('b', 'client-b-after-reload.json')]:
    peers = rows(json.loads((run/filename).read_text())['result']['vehicles'])
    for old in saved:
        vehicle = next(v for v in authority if v['id'] == old['newId'])
        matches = [v for v in peers if v['id'] == vehicle['id']]
        checks.append({'client': client, 'id': vehicle['id'], 'matches': len(matches),
                       'same': len(matches) == 1 and all(matches[0][key] == vehicle[key]
                                 for key in ('script', 'skin', 'lights', 'siren', 'data'))})
(run/'reloaded-peer-comparison.json').write_text(json.dumps(checks, indent=2)+'\n')
assert all(c['same'] for c in checks), checks
print(f'PASS: {len(saved)} saved decisions, no duplicates, {len(checks)} rejoined peer matches')
