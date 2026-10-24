param([switch] $OptionalOnly)
$ErrorActionPreference = 'Stop'
$gameRoot = if ($env:PZ_GAME_DIR) { $env:PZ_GAME_DIR } else { 'C:\SteamLibrary\steamapps\common\ProjectZomboid' }
$projectRoot = Split-Path -Parent $PSScriptRoot
$testBuild = Join-Path $projectRoot 'build\policy-check'
New-Item -ItemType Directory -Path $testBuild -Force | Out-Null
& javac -d $testBuild (Join-Path $PSScriptRoot '..\tools-src\java\LuaPolicyCheck.java')
if ($LASTEXITCODE -ne 0) { throw 'Policy test runner compilation failed' }
Push-Location $gameRoot
try {
    if (-not $OptionalOnly) {
    & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $projectRoot 'tools-src/tests/only-ki5-police-routing.lua') native shared
    if ($LASTEXITCODE -ne 0) { throw 'Regional police skin-index regression failed' }
    foreach ($authority in @('singleplayer','client')) {
        & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-civilian-share.lua') native $authority
        if ($LASTEXITCODE -ne 0) { throw "Fractional civilian share failed ($authority)" }
    }
    & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-traffic-policy.lua') native shared
    if ($LASTEXITCODE -ne 0) { throw 'Default/opt-in civilian traffic policy regression failed' }
    foreach ($zoneOrder in @('native', 'ascending', 'descending')) {
        foreach ($trafficShape in @('shared', 'copied')) {
            & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-overhaul-policy.lua') $zoneOrder $trafficShape
            if ($LASTEXITCODE -ne 0) { throw "Lua policy tests failed ($zoneOrder zone order, $trafficShape highway table)" }
        }
    }
    foreach ($chance in @('0','37','100')) {
        & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-overhaul-policy.lua') native $chance
        if ($LASTEXITCODE -ne 0) { throw "Configurable Humvee policy failed ($chance percent)" }
    }
    foreach ($chance in @('0','37','100')) {
        & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-overhaul-policy.lua') native shared $chance
        if ($LASTEXITCODE -ne 0) { throw "Configurable military truck policy failed ($chance percent)" }
    }
    & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-integrated-content.lua') native shared
    if ($LASTEXITCODE -ne 0) { throw 'Integrated VMZ content/callback regression failed' }
    & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-native-world.lua') native shared
    if ($LASTEXITCODE -ne 0) { throw 'Authored native world/scene regression failed' }
    & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-lightbars.lua') native shared
    if ($LASTEXITCODE -ne 0) { throw 'Native emergency parking/lightbar regression failed' }
    foreach ($authority in @('singleplayer', 'client')) {
        & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-spawn-skins.lua') native $authority
        if ($LASTEXITCODE -ne 0) { throw "Weighted livery regression failed ($authority)" }
        & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-lightbars.lua') native $authority
        if ($LASTEXITCODE -ne 0) { throw "Silent lightbar authority regression failed ($authority)" }
    }
    }
    foreach ($fleet in @('none','civilian','police','military','mixed')) {
        & '.\jre64\bin\java.exe' -cp "$testBuild;.;projectzomboid.jar" LuaPolicyCheck (Join-Path $projectRoot 'mod\OnlyKI5VehicleSpawnLiveryOverhaul\42\media\lua') (Join-Path $PSScriptRoot '..\tools-src\tests\only-ki5-optional-fleet.lua') native "fleet-$fleet"
        if ($LASTEXITCODE -ne 0) { throw "Optional fleet regression failed ($fleet)" }
    }
} finally { Pop-Location }
