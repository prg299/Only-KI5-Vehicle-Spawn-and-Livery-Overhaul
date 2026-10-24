"""Read native siren/audio state; use an active-siren positive control.

The owned profile's output volume stays muted. Native VehicleSounds and emitter
state must still distinguish an intentionally enabled siren from silent flashing.
"""
import argparse,json,time
from native_lab import NativeLab,ROOT,rows

p=argparse.ArgumentParser();p.add_argument('run');p.add_argument('--single-player',action='store_true')
p.add_argument('--police-baseline',help='Optional previous owned run containing saved-police-comparison.json')
a=p.parse_args()
lab=NativeLab(a.run)
who='sp' if a.single_player else 'a'
call=(lambda code:lab.client(code,'sp')) if a.single_player else lab.server
if a.single_player:
    # Keep this twenty-car positive-control sample separate from boundary
    # fixtures already saved around the northern highway observation area.
    lab.client('getPlayer():teleportTo(12558,2322,0);return true','sp')
    lab.wait(lambda:lab.client('return getCell():getGridSquare(12558,2322,0)~=nil','sp'),bool,'streamed audio fixture area')
    time.sleep(5)
    audio=json.loads(call('return OnlyKI5NativeAudio.enableMutedProbe()'))
    assert audio['masterMuted'] and not audio['soundDisabled'] and audio['soundVolume']>0,audio
    result=call((ROOT/'dev/spawn-police.lua').read_text())
    assert result['count']==20,result
    authority=rows(result['vehicles'])
    ids=[v['id'] for v in authority]
else:
    lab.move(12558,2042)
    if a.police_baseline:
        baseline=(ROOT/'build/native'/a.police_baseline).resolve()
        if not baseline.is_relative_to(ROOT/'build/native'):raise ValueError('Baseline root')
        expected=json.loads((baseline/'saved-police-comparison.json').read_text())
        sql_ids={v['sqlId'] for v in expected}
        all_vehicles=rows(call((ROOT/'dev/snapshot.lua').read_text())['vehicles'])
        authority=[v for v in all_vehicles if v['sqlId'] in sql_ids]
    else:
        fixture=call((ROOT/'dev/spawn-police.lua').read_text())
        authority=rows(fixture['vehicles'])
    assert len(authority)==20,authority
    ids=[v['id'] for v in authority]
time.sleep(3)
id_table='{'+','.join(str(i) for i in ids)+'}'
probe='''local r={};for _,id in ipairs('''+id_table+''') do local v=getVehicleById(id)
if v then local sounds=v:getVehicleSounds();local emitter=v:getVehicleSoundEmitter()
r[#r+1]={id=id,script=v:getScriptName(),lights=v:getLightbarLightsMode(),siren=v:getLightbarSirenMode(),
 active=v:isSirenActive(),sounding=v:isSirenSounding(),audioManagerPresent=sounds~=nil,emitterEmpty=emitter and emitter:isEmpty(),
 engine=v:isEngineRunning(),alarm=v:isAlarmActive()}
end end;return r'''
peers=['sp'] if a.single_player else ['a','b']
before={peer:rows(lab.client(probe,peer)) for peer in peers}
lab.write('silent-lightbar-fixture',{'authority':authority,'before':before})
assert all(len(v)==20 for v in before.values())
assert all(v['siren']==0 and not v['active'] and not v['sounding'] for peer in before.values() for v in peer),before
target=next(v['id'] for v in authority if v['lights']>0)
positive_code='local v=getVehicleById('+str(target)+');v:setLightbarSirenMode(2);v:setSirenStartTime(getGameTime():getWorldAgeHours());return true'
positive={}
after={}
audio_evidence={}
def native_audio():
    status=json.loads(call('return OnlyKI5NativeAudio.status()'))
    assert status['masterMuted'],status
    return json.loads(call('return OnlyKI5NativeAudio.inspect(getVehicleById('+str(target)+'))'))
try:
    call(positive_code)
    for peer in peers:
        positive[peer]=lab.wait(lambda:rows(lab.client(probe,peer)),
            lambda vs:any(v['id']==target and v['siren']>0 and v['active'] and v['sounding']
                          and v['audioManagerPresent'] and v.get('emitterEmpty') is False for v in vs),
            'native positive-control siren/audio path')
    if a.single_player:
        audio_evidence['positive']=lab.wait(native_audio,
            lambda r:r['managerPresent'] and r['sirenSounding'] and not r['emitterEmpty'],
            'native VehicleSounds and nonempty FMOD emitter')
    call('local v=getVehicleById('+str(target)+');triggerEvent("OnSpawnVehicleEnd",v);return true')
    for peer in peers:
        after[peer]=lab.wait(lambda:rows(lab.client(probe,peer)),
            lambda vs:all(v['siren']==0 and not v['active'] and not v['sounding'] for v in vs),
            'native spawn policy silences active siren')
        final=next(v for v in after[peer] if v['id']==target)
        assert final['lights']>0 and final.get('emitterEmpty') is True,final
    if a.single_player:
        audio_evidence['after']=lab.wait(native_audio,
            lambda r:r['managerPresent'] and not r['sirenSounding'] and r['emitterEmpty'],
            'native FMOD emitter stops while lightbar remains on')
finally:
    # Positive controls never leave an active siren in the disposable world.
    call('local v=getVehicleById('+str(target)+');if v then v:setLightbarSirenMode(0) end;return true')
report={'singlePlayer':a.single_player,'vehicles':len(ids),'before':before,'positiveControl':positive,'after':after,
        'outputMuted':True,'hearingAcceptance':False,'nativeSirenStateVerified':True,
        'nativeAudioManagerVerified':True,'nativeJavaAudioProbeUsed':bool(audio_evidence),'audioEvidence':audio_evidence}
lab.write('silent-lightbar-audio',report)
lab.write('silent-lightbar-saved-vehicles',call((ROOT/'dev/snapshot.lua').read_text()))
print('PASS: '+str(len(ids))+' silent lightbar vehicles; active native siren control detected and silenced; lights retained')
