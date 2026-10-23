"""Native server/peer scene acceptance inside an already guarded owned lifetime.

Run this driver through the guard too. Teleports and forced story selections are
test setup; native road generation, construction and replication remain active.
"""
from pathlib import Path
import argparse, json, time
from native_lab import NativeLab, rows

root = Path(__file__).resolve().parents[1]
p = argparse.ArgumentParser(); p.add_argument('run'); p.add_argument('--continue-run',action='store_true'); args = p.parse_args()
lab=NativeLab(args.run);run=lab.run
client,server,wait,move,snapshot,capture=lab.client,lab.server,lab.wait,lab.move,lab.snapshot,lab.capture

client('SendCommandToServer(\'/setaccesslevel "OnlyKI5Guest" admin\');return true')
protection=server('local r={};local ps=getOnlinePlayers();for i=0,ps:size()-1 do local p=ps:get(i);p:getBodyDamage():RestoreToFullHealth();p:setGodMod(true);r[#r+1]={name=p:getUsername(),god=p:isGodMod(),dead=p:isDead()} end;return r')
assert all(p['god'] and not p['dead'] for p in rows(protection)),protection
(run/'authoritative-character-protection.json').write_text(json.dumps(protection,indent=2)+'\n')
for who in ('a','b'):
    client('local p=getPlayer();p:getBodyDamage():RestoreToFullHealth();p:setGodMod(true);getGameTime():setTimeOfDay(12);return true',who)
server('getGameTime():setTimeOfDay(12);return true')
summary=json.loads((run/'military-acceptance-summary.json').read_text()) if args.continue_run else []
for label,x,y in [('checkpoint',12546,4229),('checkpoint-approach',12530,4100),('city-highway',12550,2400)]:
    if any(r.get('area')==label for r in summary): continue
    move(x,y)
    records=snapshot(label)
    local=[v for v in rows(records['server']['vehicles']) if abs(v['x']-x)<85 and abs(v['y']-y)<85]
    assert local,'No native vehicles in '+label
    capture(label)
    summary.append({'area':label,'nativeVehicleCount':len(local)})
    (run/'military-acceptance-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(label+': '+str(len(local))+' natural vehicles observed',flush=True)

force=(root/'dev/force-story.lua').read_text()
for name,x,y in [('MilitaryBlockade',10604,9806),('MilitaryBlockpost',12684,5228),
                 ('MilitaryConvoy',10598,9700),('BiohazardCrash',12684,5616)]:
    if any(r.get('story')==name for r in summary): continue
    move(x,y)
    completed=server('local r=OnlyKI5ForcedStoryResult;return r and r.data.story=='+json.dumps(name)+' and r.data.state=="done" and r.data')
    selection={'selected':True,'resumedCompletedFixture':True} if completed else server('OnlyKI5ForceStory='+json.dumps(name)+';'+force)
    if not selection.get('selected'):
        # Explicit scene-construction fixture only: prepare an empty test road,
        # retaining the failed occupancy check and every removed identity.
        preparation=server('''local cx,cy='''+str(x)+','+str(y)+''';local removed={};local pending={}
local it=getCell():getVehicles():iterator()
while it:hasNext() do local v=it:next();if math.abs(v:getX()-cx)<28 and math.abs(v:getY()-cy)<80 then pending[#pending+1]=v end end
for _,v in ipairs(pending) do removed[#removed+1]={sqlId=v:getSqlId(),script=v:getScriptName(),x=v:getX(),y=v:getY()};v:permanentlyRemove() end
local zs=getCell():getZombieList();local personnel=0
for i=zs:size()-1,0,-1 do local z=zs:get(i);if math.abs(z:getX()-cx)<28 and math.abs(z:getY()-cy)<80 then z:removeFromWorld();z:removeFromSquare();personnel=personnel+1 end end
return {removedVehicles=removed,clearedHostiles=personnel}''')
        (run/(name.lower()+'-footprint-preparation.json')).write_text(json.dumps({'initialSelection':selection,'preparation':preparation},indent=2)+'\n')
        time.sleep(3)
        selection=server('OnlyKI5ForceStory='+json.dumps(name)+';'+force)
    assert selection.get('selected'),selection
    checkpoint=wait(lambda:server('return OnlyKI5ForcedStoryResult.data'),
                    lambda r:r['state'] in ('done','failed','partial','blocked'),name+' scheduling')
    assert checkpoint['state']=='done',checkpoint
    move(round(checkpoint['x']),round(checkpoint['y']+2))
    records=snapshot(name.lower())
    x,y=checkpoint['x'],checkpoint['y']
    authority=[v for v in rows(records['server']['vehicles']) if abs(v['x']-x)<35 and abs(v['y']-y)<45]
    assert authority,'No constructed scene vehicles'
    comparisons=[]
    for who in ('a','b'):
        peers=rows(records[who]['vehicles'])
        for v in authority:
            hits=[p for p in peers if p['id']==v['id']]
            comparisons.append({'client':who,'id':v['id'],'same':len(hits)==1 and all(hits[0][k]==v[k] for k in ('script','skin','lights','siren'))})
    assert all(c['same'] for c in comparisons),comparisons
    capture(name.lower())
    summary.append({'story':name,'selectionFixture':True,'checkpoint':checkpoint,
                    'nearbyVehicles':len(authority),'peerComparisons':comparisons})
    (run/'military-acceptance-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(name+': done, '+str(len(authority))+' native vehicles, both peers match',flush=True)
move(10598,9600)
variants=rows(server((root/'dev/spawn-variants.lua').read_text()))
assert len(variants)==4,variants
time.sleep(5)
for index,v in enumerate(variants):
    registrations={}
    for who in ('a','b'):
        registrations[who]=client('local n='+json.dumps(v['script'])+';return {armor=DAMN.Armor.byVehicleScript[n]~=nil,overlay=ISCarMechanicsOverlay.CarList[n]~=nil}',who)
        assert all(registrations[who].values()),registrations
    ui=lab.mechanics(v,'variant-'+str(index+1)+'-mechanics')
    summary.append({'variant':v['script'],'nativeInput':'Vehicle mechanics key','ui':ui,'registrations':registrations})
    (run/'military-acceptance-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(v['script']+': native mechanics UI and both client registrations passed',flush=True)
print('PASS: native military areas, four scene recipes and four imported variant families on joined dedicated server')
