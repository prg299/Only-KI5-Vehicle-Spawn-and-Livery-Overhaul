$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$game = if ($env:PZ_GAME_DIR) { $env:PZ_GAME_DIR } else { 'C:\SteamLibrary\steamapps\common\ProjectZomboid' }
$output = Join-Path $root 'build\native-world-api'
New-Item -ItemType Directory -Force -Path $output | Out-Null
& javac -d $output (Join-Path $root 'tools-src\java\NativeWorldContractCheck.java')
if ($LASTEXITCODE) { throw 'Native API contract helper compilation failed' }
& "$game\jre64\bin\java.exe" -cp "$output;$game;$game\projectzomboid.jar" NativeWorldContractCheck
if ($LASTEXITCODE) { throw 'Installed game is missing a required native world API' }
