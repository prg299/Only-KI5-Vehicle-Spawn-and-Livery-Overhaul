"""Read installed native implementation into ignored diagnostic artifacts."""
from pathlib import Path
import subprocess
root=Path(__file__).resolve().parents[1]
out=root/'build/bug-reports-20261103';out.mkdir(parents=True,exist_ok=True)
javap=Path('D:/Stuff/Projects/Real-Vehicle-Interiors/.tools/jdk-25.0.4.1+1/bin/javap.exe')
game=Path('C:/SteamLibrary/steamapps/common/ProjectZomboid')
for cls in ('zombie.randomizedWorld.RandomizedWorldBase','zombie.randomizedWorld.randomizedVehicleStory.RandomizedVehicleStoryBase','zombie.vehicles.BaseVehicle','zombie.scripting.objects.VehicleScript'):
    with (out/(cls.rsplit('.',1)[1]+'.txt')).open('w',encoding='utf8') as stream:
        subprocess.run([str(javap),'-p','-c','-classpath',str(game)+';'+str(game/'projectzomboid.jar'),cls],stdout=stream,check=True)
    print('Read installed implementation:',cls)
