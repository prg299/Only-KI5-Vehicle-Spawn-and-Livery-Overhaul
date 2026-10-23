$ErrorActionPreference = 'Stop'
$gameRoot = if ($env:PZ_GAME_DIR) { $env:PZ_GAME_DIR } else { 'C:\SteamLibrary\steamapps\common\ProjectZomboid' }
$projectRoot = Split-Path -Parent $PSScriptRoot
$testBuild = Join-Path $projectRoot 'build\policy-check'
New-Item -ItemType Directory -Path $testBuild -Force | Out-Null
& javac -d $testBuild (Join-Path $PSScriptRoot '..\tools-src\java\LuaPolicyCheck.java')
if ($LASTEXITCODE -ne 0) { throw 'Policy test runner compilation failed' }
Push-Location $gameRoot
try {
    foreach ($zoneOrder in @('native', 'ascending', 'descending')) {
        foreach ($trafficShape in @('shared', 'copied')) {
            & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\KI5KnoxCountyFleet\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\knox-fleet-policy.lua') $zoneOrder $trafficShape
            if ($LASTEXITCODE -ne 0) { throw "Lua policy tests failed ($zoneOrder zone order, $trafficShape highway table)" }
        }
    }
} finally { Pop-Location }
