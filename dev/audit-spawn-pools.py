"""Compare complete native registries; weight shares are not observed frequencies.

Run under the resource guard. Inputs must be read-only snapshots from owned
native sessions; output contains no credentials, private profiles or logs.
"""
import argparse,hashlib,json,math
from collections import Counter
from pathlib import Path

p=argparse.ArgumentParser();p.add_argument('--before',type=Path,required=True)
p.add_argument('--after',type=Path,required=True);p.add_argument('--output',type=Path,required=True)
a=p.parse_args();before=json.loads(a.before.read_text('utf8'));after=json.loads(a.after.read_text('utf8'))
classes=after['classifications'];errors=[]
def canon(name):
    while name.startswith('Base.Base.'):name=name[5:]
    return name if '.' in name else 'Base.'+name
def classification(name):
    return classes.get(name) or classes.get(canon(name)) or {'category':'unknown','custom':False,'suppressed':False}
def summarize(zone):
    categories=Counter();custom=0;total=0
    for name,entry in zone['vehicles'].items():
        weight=entry['weight'];c=classification(name)
        if not math.isfinite(weight) or weight<0:errors.append('Invalid weight '+name)
        if weight<=0:continue
        total+=weight;categories[c['category']]+=weight
        if c['custom']:custom+=weight
    return {'total':total,'categories':dict(categories),'custom':custom,
            'everydayPercent':100*categories['everyday']/total if total else None}
zones={};professions={}
for name,zone in sorted(after['zones'].items()):
    previous=before['zones'].get(name,{'vehicles':{}})
    record={'role':after['trafficPolicy']['zones'][name]['role'],
            'before':summarize(previous),'after':summarize(zone),'optionalShares':{}}
    for script,entry in zone['vehicles'].items():
        if canon(script)!=script:errors.append(name+': malformed '+script)
        if entry['weight']>0 and classification(script)['suppressed']:errors.append(name+': suppressed '+script)
        if classification(script)['custom'] and (original:=entry.get('customOriginal')) is not None:
            if abs(entry['weight']-original*after['civilianWeightPercent']/100)>1e-8:errors.append(name+': wrong custom multiplier '+script)
        category=classification(script)['category']
        if entry['weight']>0 and record['role']=='business':
            if category in ('military','wreck') or (category=='emergency' and name!='airportservice'):
                errors.append(name+': wrong business role '+script)
            if script=='Base.87fordB700school' and name!='transit':errors.append(name+': misplaced school bus')
        if ('limo' in script.lower() or 'elgin' in script.lower()) and entry['weight']>0:
            share=entry['weight']/record['after']['total']
            record['optionalShares'][script]=share
            if share>(.0002 if record['role']=='highway' else .0005)+1e-9:errors.append(name+': specialty cap '+script)
            if record['role'] in ('police','fire','ambulance','ranger','military','trailer'):errors.append(name+': wrong-role '+script)
    if name=='modified_trfjm' and (record['after']['everydayPercent'] or 0)<97:errors.append('Highway ordinary share below 97%')
    if record['before']['total']==0 and record['after']['total']>0 and name in before['zones']:
        errors.append(name+': previously empty pool populated')
    if record['after']['total']==0 and record['before']['total']>0:errors.append(name+': pool emptied')
    zones[name]=record
for name,role in sorted(after['professions'].items()):
    if name=='ProfessionVehicles.UniqueVehicles':continue
    for script,weight in role.get('weights',role['counts']).items():
        if classification(script)['suppressed']:errors.append(name+': suppressed profession '+script)
        if canon(script)!=script:errors.append(name+': malformed profession '+script)
        if (original:=role.get('customOriginal',{}).get(script)) is not None:
            if abs(weight-original*after['civilianWeightPercent']/100)>1e-8:errors.append(name+': wrong fractional profession multiplier '+script)
    professions[name]={'beforeSlots':before['professions'].get(name,{}).get('slots'),
                       'afterSlots':role['slots'],'scripts':role['counts'],'effectiveWeights':role.get('weights')}
for script,valid in after['scripts'].items():
    if not valid:errors.append('Unresolved native script '+script)
for name,role in after['professions'].items():
    if name=='ProfessionVehicles.UniqueVehicles':continue
    if 'VanSeats_Prison.' in name:
        for script in role['counts']:
            if 'Airport' in script or script=='Base.93fordF350as':errors.append(name+': airport-security prison escort')
active_custom={script for zone in after['zones'].values() for script,v in zone['vehicles'].items()
               if v['weight']>0 and classification(script)['custom']}
if after.get('civilianWeightPercent',0)>0 and len(active_custom)<100:errors.append('Nonzero multiplier lost the custom civilian fleet')
for name in ('military_vehicle_light','military_light','modified_trfjm'):
    if name not in after['zones']:continue
    choices=after['zones'][name]['vehicles'];humvee=choices.get('Base.92amgeneralM998',{}).get('weight',0)
    car_names={x['script'] for x in json.loads((Path(__file__).resolve().parents[1]/'docs/civilian-spawn-policy.json').read_text()) if x['group']=='militaryCar'}
    military=sum(v['weight'] for k,v in choices.items() if k in car_names)
    if military and abs(humvee/military-after.get('humveeChance',95)/100)>1e-6:errors.append(name+': Humvee share differs from sandbox setting')
inventory={'baselineSha256':hashlib.sha256(a.before.read_bytes()).hexdigest(),
           'candidateSha256':hashlib.sha256(a.after.read_bytes()).hexdigest(),
           'mode':after.get('suppressCustom'),'civilianWeightPercent':after.get('civilianWeightPercent'), 'zoneCount':len(zones),'professionCount':len(professions),
           'referencedScriptCount':len(after['scripts']),'activeCustomModels':len(active_custom),'mods':after['mods'],'errors':errors,
           'zones':zones,'professions':professions,'classifications':classes,
           'uniqueVehicleConstraints':after['professions'].get('ProfessionVehicles.UniqueVehicles',{}).get('counts',{}),
           'beforePools':before['zones'],'afterPools':after['zones']}
a.output.mkdir(parents=True,exist_ok=True)
(a.output/'pool-inventory.json').write_text(json.dumps(inventory,separators=(',',':'))+'\n','utf8')
lines=['# Complete native spawn-pool audit','',
       f"{len(zones)} final map pools, {len(professions)} profession/story choice lists and the separate unique-vehicle constraint list, full fleet plus optional Town Car/limo and Elgin packs.",
       'Candidate-pool weights describe selection probabilities within each pool, not the number of vehicles in an area.',
       '',f"Custom civilian weight multiplier: {after.get('civilianWeightPercent')}%. Errors: {len(errors)}.",'',
       '| Pool | Role | Ordinary weight before / after | Custom weight before / after | Limo / sweeper after |',
       '| --- | --- | ---: | ---: | --- |']
def percent(value):return 'empty' if value is None else f'{value:.2f}%'
for name,r in zones.items():
    optional=', '.join(f'{k}: {v*100:.4f}%' for k,v in r['optionalShares'].items()) or '-'
    lines.append(f"| {name} | {r['role']} | {percent(r['before']['everydayPercent'])} / {percent(r['after']['everydayPercent'])} | {r['before']['custom']:.3f} / {r['after']['custom']:.3f} | {optional} |")
lines+=['','## Findings requiring review','']+(['- '+e for e in errors] or ['No invariant failures. See the machine-readable inventory for every model weight, category and profession choice.'])
(a.output/'pool-audit.md').write_text('\n'.join(lines)+'\n','utf8')
print(json.dumps({k:inventory[k] for k in ('mode','zoneCount','professionCount','referencedScriptCount','errors')}))
raise SystemExit(bool(errors))
