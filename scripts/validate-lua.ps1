[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$luaRoot = Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua'
$gameRoot = if ($env:PZ_GAME_DIR) { $env:PZ_GAME_DIR } else { 'C:\SteamLibrary\steamapps\common\ProjectZomboid' }
$gameJava = Join-Path $gameRoot 'jre64\bin\java.exe'
$gameJar = Join-Path $gameRoot 'projectzomboid.jar'
$javaSource = Join-Path $PSScriptRoot '..\tools-src\java\LuaSyntaxCheck.java'
$outputRoot = Join-Path $projectRoot 'build\syntax-check'

if (-not (Test-Path -LiteralPath $gameRoot -PathType Container)) { throw "Project Zomboid installation was not found: $gameRoot" }
if (-not (Test-Path -LiteralPath $gameJava -PathType Leaf)) { throw "Project Zomboid runtime Java was not found: $gameJava" }
if (-not (Test-Path -LiteralPath $gameJar -PathType Leaf)) { throw "Project Zomboid runtime archive was not found: $gameJar" }
if (-not (Test-Path -LiteralPath $javaSource -PathType Leaf)) { throw "Lua syntax helper is missing: $javaSource" }

New-Item -ItemType Directory -Force -Path $outputRoot | Out-Null
& javac -encoding UTF-8 -cp $gameRoot -d $outputRoot $javaSource
if ($LASTEXITCODE -ne 0) { throw 'Could not compile the Project Zomboid Lua syntax helper.' }

& $gameJava -cp "$outputRoot;$gameRoot;$gameJar" LuaSyntaxCheck $luaRoot
if ($LASTEXITCODE -ne 0) { throw 'Project Zomboid Lua syntax validation failed.' }
