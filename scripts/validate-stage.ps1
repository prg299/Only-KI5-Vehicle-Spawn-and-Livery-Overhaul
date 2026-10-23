param(
    [string] $Stage = (Join-Path $PSScriptRoot '..\build\workshop\OnlyKI5VehicleSpawnLiveryOverhaul'),
    [string] $JavaHome = $env:ONLY_KI5_JAVA_HOME
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$game = if ($env:PZ_GAME_DIR) { $env:PZ_GAME_DIR } else { 'C:\SteamLibrary\steamapps\common\ProjectZomboid' }
$classes = Join-Path $root 'build\stage-check'
New-Item -ItemType Directory -Force $classes | Out-Null
$compiler = if ($JavaHome) { Join-Path $JavaHome 'bin\javac.exe' } elseif ($env:JAVA_HOME) { Join-Path $env:JAVA_HOME 'bin\javac.exe' } else { 'javac' }
& $compiler -cp "$game;$game\projectzomboid.jar" -d $classes (Join-Path $root 'tools-src\java\ValidateWorkshopStage.java')
if ($LASTEXITCODE) { throw 'Native uploader adapter compilation failed.' }
# The game's path guard admits uploader content beneath its cache prefix.
# Use only this checkout's ignored build directory as the disposable cache.
& "$game\jre64\bin\java.exe" -cp "$classes;$game;$game\projectzomboid.jar" ValidateWorkshopStage $Stage (Join-Path $root 'build') $game OnlyKI5VehicleSpawnLiveryOverhaul public
if ($LASTEXITCODE) { throw 'Native uploader stage validation failed.' }
