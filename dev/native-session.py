"""Owned acceptance lifetime. Run ONLY through run-heavy.mjs; never shipped.

Reuses the MIT RVI test endpoint/input/framebuffer sources and the workspace's
inactive-desktop keeper as read-only inputs. No player profile or game install
is modified. Commands in request.json execute inside this guarded lifetime.
"""
from pathlib import Path
import argparse, hashlib, json, os, shutil, socket, subprocess, sys, time, traceback
import urllib.request

ROOT = Path(__file__).resolve().parents[1]
GAME = Path(os.environ.get('PZ_GAME_DIR', r'C:\SteamLibrary\steamapps\common\ProjectZomboid'))
WORKSHOP = Path(os.environ.get('PZ_WORKSHOP_DIR', str(GAME.parents[1] / 'workshop/content/108600')))
RVI = Path(os.environ.get('ONLY_KI5_ACCEPTANCE_RVI_DIR', str(ROOT.parent / 'Real-Vehicle-Interiors')))
KEEPER = RVI / 'dev/windows-test-session.py'
JDK = Path(os.environ.get('ONLY_KI5_JAVA_HOME', str(RVI / '.tools/jdk-25.0.4.1+1'))) / 'bin'
PREFIX = 'OnlyKI5VehicleSpawnLiveryOverhaul'
DEV = 'OnlyKI5Acceptance_Dev'


def write(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    pending = path.with_suffix('.pending')
    pending.write_text(json.dumps(value, indent=2), encoding='utf-8')
    for attempt in range(20):
        try: pending.replace(path);break
        except PermissionError:
            if attempt==19:raise
            time.sleep(.01)


def lua(port, code, timeout=15):
    req = urllib.request.Request(f'http://127.0.0.1:{port}/lua?depth=12&sandbox=false',
                                 code.encode(), {'Content-Type': 'text/plain'})
    with urllib.request.urlopen(req, timeout=timeout) as response:
        value = json.load(response)
    if not value.get('ok'):
        raise RuntimeError(value)
    return value.get('result')


def wait(predicate, seconds=180, label='native readiness'):
    deadline = time.monotonic() + seconds
    last = None
    while time.monotonic() < deadline:
        try:
            last = predicate()
            if last:
                return last
        except (OSError, RuntimeError) as error:
            last = str(error)
        time.sleep(.4)
    raise RuntimeError(f'Timed out: {label}; last={last}')


class Session:
    def __init__(self, run, effective=False, reuse=None, resume=None):
        self.run = run
        self.children = []
        self.clients = {}
        self.server = None
        self.ids = None
        self.start = time.time()
        self.effective = effective
        self.reuse = reuse
        self.resume = resume

    def prepare(self):
        self.run.mkdir(parents=True, exist_ok=False)
        profile = dict(line.split('=', 1) for line in (ROOT/'config/fleet-profile.ini').read_text().splitlines())
        wanted = set(profile['Mods'].split(';')) | {'ZombieBuddy'}
        folders = {}
        for wid in profile['WorkshopItems'].split(';') + ['3619862853']:
            for folder in (WORKSHOP/wid/'mods').iterdir():
                if not folder.is_dir():
                    continue
                for desc in [folder/'mod.info', *folder.glob('*/mod.info')]:
                    if not desc.is_file():
                        continue
                    info = dict(line.split('=',1) for line in desc.read_text('utf-8-sig').splitlines() if '=' in line)
                    modid = info.get('id')
                    if modid in wanted:
                        folders[modid] = folder
        if wanted - folders.keys():
            raise RuntimeError('Missing installed module(s): '+str(wanted-folders.keys()))
        mods = self.run/'inputs/mods'
        mods.mkdir(parents=True)
        seen = {}
        for modid, folder in sorted(folders.items()):
            if folder not in seen:
                dest = mods / ('dependency-'+str(len(seen)))
                prior = self.reuse/'inputs/mods'/dest.name if self.reuse else None
                if prior and prior.is_dir():
                    shutil.copytree(prior,dest,copy_function=os.link)
                else:
                    shutil.copytree(folder, dest)
                seen[folder] = dest
        shutil.copytree(ROOT/'mod'/PREFIX, mods/PREFIX)
        dev = mods/DEV
        common = dev/'common/media/lua'
        for side in ('client','server'):
            (common/side).mkdir(parents=True)
        (common/'client/ZZZ_OnlyKI5Acceptance.lua').write_text((ROOT/'dev/probe-client.lua').read_text(), encoding='utf-8')
        (common/'server/ZZZ_OnlyKI5Acceptance.lua').write_text((ROOT/'dev/probe-server.lua').read_text(), encoding='utf-8')
        desc = f'name=Only KI5 acceptance endpoint (TEST ONLY)\nid={DEV}\nrequire=ZombieBuddy\nversionMin=42.21\nmodversion=1.0.0\n'
        (dev/'mod.info').write_text(desc)
        (dev/'42.21').mkdir()
        (dev/'42.21/mod.info').write_text(desc+'javaJarFile=media/java/Acceptance.jar\njavaPkgName=me.lens.dev\n')
        java = dev/'42.21/media/java/Acceptance.jar'
        java.parent.mkdir(parents=True)
        classes = self.run/'classes'
        sources = [p for p in (RVI/'dev/java').rglob('*.java') if p.name != 'Pump.java']
        sources.extend((ROOT/'dev/java').rglob('*.java'))
        pump = self.run/'adapter-src/me/lens/dev/Pump.java'
        pump.parent.mkdir(parents=True)
        pump.write_text('''package me.lens.dev;
import me.zed_0xff.zombie_buddy.Patch;
/** Test endpoint only: main-thread queue stays reachable during startup/UI errors. */
public final class Pump {
 @Patch(className="zombie.GameWindow",methodName="mainThreadStep",strictMatch=true)
 public static final class MainStep {
  @Patch.OnExit public static void exit() { Audio.expose(); Main.runTasks(); }
 }
}
''')
        sources.append(pump)
        subprocess.run([str(JDK/'javac.exe'), '-J-Xmx256m', '--release','25','-d',str(classes),
                        '-cp',f'{GAME}/projectzomboid.jar;{GAME}/ZombieBuddy.jar', *map(str,sources)], check=True)
        subprocess.run([str(JDK/'jar.exe'), '-J-Xmx128m','--create','--file',str(java),'-C',str(classes),'.'],check=True)
        self.ids = ['ZombieBuddy', *profile['Mods'].split(';'), PREFIX, DEV]
        write(self.run/'inputs.json', {'mods':self.ids, 'payload':{
            str(p.relative_to(ROOT/'mod'/PREFIX)):hashlib.sha256(p.read_bytes()).hexdigest()
            for p in (ROOT/'mod'/PREFIX).rglob('*') if p.is_file()},
            'adapterSources':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in sources},
            'keeperSource':str(KEEPER), 'stockClassesFirst':not self.effective, 'testOnlyDependency':'ZombieBuddy'})
        print('INPUTS_READY full fleet; source payload and adapter hashes retained', flush=True)

    def profile(self, name):
        path = self.run/name
        cache = path/'home/Zomboid'
        cache.mkdir(parents=True)
        if self.resume:
            previous=self.resume/name/'home/Zomboid'
            if not previous.is_dir():raise ValueError('Missing stopped owned profile: '+name)
            for item in previous.iterdir():
                if item.name in ('mods','console.txt','server-console.txt','Screenshots','Logs'):continue
                target=cache/item.name
                if item.is_dir():shutil.copytree(item,target)
                else:shutil.copy2(item,target)
        # Hard links are created only between two owned immutable test copies.
        shutil.copytree(self.run/'inputs/mods',cache/'mods',copy_function=os.link)
        (cache/'mods/default.txt').write_text('VERSION = 1,\nmods\n{\n'+''.join(f' mod = {m},\n' for m in self.ids)+'}\nmaps\n{\n}\n')
        (cache/'mods/reset-mods-42_00.txt').touch()
        options = {'version':'8','fullScreen':'false','borderless':'false','width':'1280','height':'720',
                   'focusloss':'false','textureCompression':'true','texture2x':'false','uncappedFPS':'false',
                   'frameRate':'30','soundVolume':'0','musicVolume':'0','uiRenderFPS':'30',
                   'zoomLevels1x':'50;75;100','zoomLevels2x':'50;75;100'}
        prior = Path.home()/'Zomboid/options.ini'
        if prior.exists():
            values = dict(line.split('=',1) for line in prior.read_text().splitlines() if '=' in line)
            for key in ('termsOfServiceVersion','showWelcomeMessage2','tutorialDone'):
                if key in values: options[key]=values[key]
            write(path/'existing-acknowledgements.json',{'source':str(prior),
                'values':{key:values[key] for key in ('termsOfServiceVersion','showWelcomeMessage2','tutorialDone') if key in values}})
        if not self.resume:
            (cache/'options.ini').write_text(''.join(f'{k}={v}\n' for k,v in options.items()))
        # Test profiles suppress the guide overlay; never change the real profile.
        settings=(cache/'options.ini').read_text()
        settings='\n'.join(line for line in settings.splitlines()
                           if not line.startswith(('showSurvivalGuide=','soundVolume=','musicVolume=')))
        (cache/'options.ini').write_text(settings+'\nshowSurvivalGuide=false\nsoundVolume=0\nmusicVolume=0\n')
        (path/'home/zombie_buddy').mkdir()
        return path, cache

    def client(self,name,port):
        with socket.socket() as probe:
            probe.bind(('127.0.0.1',port))
        path,cache = self.profile(name)
        heap='1792m' if name in ('a','b') else '3072m'
        args = [str(GAME/'jre64/bin/java.exe'),'-Xms128m',f'-Xmx{heap}','-XX:MaxDirectMemorySize=128m',
                f'-XX:ErrorFile={path}/hs_err_pid%p.log',
                '-XX:ReservedCodeCacheSize=96m','-XX:ActiveProcessorCount=4','--enable-native-access=ALL-UNNAMED',
                '--add-exports=java.base/jdk.internal.misc=ALL-UNNAMED','-Djava.awt.headless=true',
                '-Djava.library.path=win64/;.','-XX:-OmitStackTraceInFastThrow','-Dzomboid.steam=0',
                f'-Duser.home={path}/home',f'-Dpzopt.enabled={str(self.effective).lower()}','-Dpzopt.gcMode=stock',
                '-Dpzopt.jitSteady=false',
                '-Dpzopt.aotCache=false','-Dpzopt.updateCheck=false',f'-Dmelens.dev.port={port}',
                f'-agentlib:zbNative=policy=allow-all,verbosity=1,config_dir={path}/home/zombie_buddy',
                '-cp','.;projectzomboid.jar' if self.effective else 'projectzomboid.jar;.',
                'zombie.gameStates.MainScreenState','-nosteam',f'-cachedir={cache}']
        config = path/'native-session.json'
        write(config,{'command':args,'cwd':str(GAME)})
        env = {k:v for k,v in os.environ.items() if k not in ('JAVA_TOOL_OPTIONS','_JAVA_OPTIONS','JDK_JAVA_OPTIONS')}
        env['PATH']=str(GAME/'win64')+';'+str(GAME)+';'+env['PATH']
        log=(path/'keeper.log').open('w')
        keeper=subprocess.Popen([sys.executable,str(KEEPER),str(config)],stdout=log,stderr=log,env=env,creationflags=subprocess.CREATE_NO_WINDOW)
        self.children.append((keeper,log))
        receipt=wait(lambda:json.loads((path/'native-session-started.json').read_text()) if (path/'native-session-started.json').exists() else None,30,'owned process receipt')
        record={'port':port,'path':str(path),'cache':str(cache),**receipt}
        self.clients[name]=record
        write(self.run/'clients.json',self.clients)
        wait(lambda:lua(port,'return MainScreen and MainScreen.instance and MEMCNativeLab and "ready"')=='ready',240,'main menu and adapters')
        lua(port,'UIManager.setShowLuaDebuggerOnError(false); return true')
        print(f'CLIENT_READY {name} pid={record["pid"]} port={port}',flush=True)
        return record

    def start_server(self):
        path,cache=self.profile('server')
        directory=cache/'Server';directory.mkdir(exist_ok=True)
        credentials=json.loads((self.resume/'credentials.json').read_text()) if self.resume else {'admin':'OnlyKI5Admin','password':os.urandom(20).hex()}
        self.secret=credentials['password']
        write(self.run/'credentials.json',credentials)
        values={'Open':'true','Public':'false','PVP':'false','PauseEmpty':'true','UPnP':'false',
            'DefaultPort':'17431','UDPPort':'17432','Mods':';'.join(self.ids),'WorkshopItems':'',
            'Map':'Muldraugh, KY','SteamVAC':'false','DoLuaChecksum':'true','AntiCheatChecksum':'2',
            'SpawnPoint':'12580,2050,0','SaveWorldEveryMinutes':'0'}
        (directory/'onlyki5.ini').write_text(''.join(f'{k}={v}\n' for k,v in values.items()))
        if not self.resume:
            (directory/'onlyki5_SandboxVars.lua').write_text('SandboxVars={VERSION=6,Zombies=5,VehicleEasyUse=true,ZombieConfig={PopulationMultiplier=0.0,PopulationStartMultiplier=0.0,PopulationPeakMultiplier=0.0},}\n')
        env={k:v for k,v in os.environ.items() if k not in ('JAVA_TOOL_OPTIONS','_JAVA_OPTIONS','JDK_JAVA_OPTIONS')}
        env['PATH']=str(GAME/'win64')+';'+str(GAME)+';'+env['PATH']
        args=[str(GAME/'jre64/bin/java.exe'),'-Xms128m','-Xmx1792m','-XX:MaxDirectMemorySize=128m',
            f'-XX:ErrorFile={path}/hs_err_pid%p.log',
            '-XX:ActiveProcessorCount=4','--enable-native-access=ALL-UNNAMED',f'-Djava.library.path={GAME}/win64;{GAME}/natives;{GAME}',
            '-Dzomboid.steam=0',f'-Duser.home={path}/home',f'-Ddeployment.user.cachedir={cache}',
            f'-Dpzopt.enabled={str(self.effective).lower()}','-Dpzopt.aotCache=false','-Dpzopt.updateCheck=false',
            '-Dpzopt.gcMode=stock','-cp',f'{GAME};{GAME}/projectzomboid.jar' if self.effective else f'{GAME}/projectzomboid.jar;{GAME}',
            'zombie.network.GameServer',f'-cachedir={cache}','-nosteam','-servername','onlyki5',
            '-ip','127.0.0.1','-port','17431','-udpport','17432','-adminusername','OnlyKI5Admin','-adminpassword',self.secret]
        self.server_out=(path/'stdout.log').open('w');self.server_err=(path/'stderr.log').open('w')
        self.server=subprocess.Popen(args,cwd=GAME,env=env,stdin=subprocess.PIPE,stdout=self.server_out,stderr=self.server_err,
            text=True,creationflags=subprocess.CREATE_NO_WINDOW)
        write(path/'process.json',{'pid':self.server.pid,'port':17431,'cache':str(cache),'javaAgent':False})
        def ready():
            if self.server.poll() is not None:raise ValueError(f'Owned server exited {self.server.returncode}')
            log=cache/'server-console.txt'
            return log.exists() and 'SERVER STARTED' in log.read_text(errors='replace')
        wait(ready,300,'dedicated server')
        print('SERVER_READY port=17431 checksums=true non-Steam loopback',flush=True)

    def command(self,q):
        action=q['action']
        if action=='client': return self.client(q['name'],q['port'])
        record=self.clients[q.get('client','sp')]
        if action=='lua': return lua(record['port'],q['code'],q.get('timeout',15))
        if action=='capture':
            name=q['name']
            lua(record['port'],f'MEMCNativeLab.capture("{name}.png"); return true')
            image=Path(record['cache'])/'Screenshots'/f'{name}.png'
            wait(lambda:image.exists(),15,'completed native frame')
            output=self.run/'captures'/f'{name}.png';output.parent.mkdir(exist_ok=True)
            shutil.copy2(image,output)
            return str(output)
        raise ValueError(action)

    def close(self):
        for record in self.clients.values():
            try: lua(record['port'],'MEMCNativeLab.releaseKeys(); getCore():quitToDesktop(); return true',3)
            except Exception: pass
        for keeper,log in self.children:
            try: keeper.wait(timeout=25)
            except subprocess.TimeoutExpired:
                # PID comes only from our keeper's immutable launch receipt.
                record=next((r for r in self.clients.values() if r['keeperPid']==keeper.pid),None)
                if record:
                    subprocess.run(['taskkill','/PID',str(record['pid']),'/T','/F'],capture_output=True)
                    keeper.wait(timeout=10)
            log.close()
        if self.server:
            if self.server.poll() is None:
                try:
                    self.server.stdin.write('save\nquit\n');self.server.stdin.flush()
                    self.server.wait(timeout=50)
                except (OSError,subprocess.TimeoutExpired):self.server.kill();self.server.wait(timeout=10)
            self.server_out.close();self.server_err.close()
            write(self.run/'server/exit.json',{'exitCode':self.server.returncode})
        write(self.run/'finished.json',{'finishedAt':time.time(),'seconds':time.time()-self.start})


def main():
    p=argparse.ArgumentParser();p.add_argument('--run',required=True);p.add_argument('--minutes',type=int,default=35)
    p.add_argument('--effective',action='store_true');p.add_argument('--reuse');p.add_argument('--mp',action='store_true')
    p.add_argument('--resume')
    args=p.parse_args()
    if not args.run.replace('-','').isalnum(): raise ValueError('Run name')
    reuse=(ROOT/'build/native'/args.reuse).resolve() if args.reuse else None
    if reuse and not reuse.is_relative_to(ROOT/'build/native'):raise ValueError('Reuse escaped test root')
    resume=(ROOT/'build/native'/args.resume).resolve() if args.resume else None
    if resume:
        if not resume.is_relative_to(ROOT/'build/native') or not (resume/'finished.json').is_file():raise ValueError('Resume requires a stopped owned lifetime')
        if args.mp and json.loads((resume/'server/exit.json').read_text())['exitCode']!=0:raise ValueError('Resume requires a clean server save/exit')
    s=Session(ROOT/'build/native'/args.run,args.effective,reuse,resume)
    try:
        s.prepare()
        if args.mp:
            s.start_server();s.client('a',18532);s.client('b',18533)
        else:s.client('sp',18531)
        print('NATIVE_REVIEW_READY',flush=True)
        deadline=time.monotonic()+args.minutes*60
        while time.monotonic()<deadline:
            request=s.run/'request.json'
            if not request.exists(): time.sleep(.2);continue
            q=json.loads(request.read_text('utf-8-sig'));request.unlink()
            if q['action']=='stop':break
            try:write(s.run/'response.json',{'id':q['id'],'ok':True,'result':s.command(q)})
            except Exception:write(s.run/'response.json',{'id':q['id'],'ok':False,'error':traceback.format_exc()})
    finally:s.close()


if __name__=='__main__':main()
