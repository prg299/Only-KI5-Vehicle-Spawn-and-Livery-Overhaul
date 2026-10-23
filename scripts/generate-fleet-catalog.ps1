[CmdletBinding()]
param(
    [string] $ServerConfig = (Join-Path $PSScriptRoot '..\config\fleet-profile.ini'),
    [string] $WorkshopRoot = $(if ($env:PZ_WORKSHOP_DIR) { $env:PZ_WORKSHOP_DIR } else { 'C:\SteamLibrary\steamapps\workshop\content\108600' })
)

$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$sourceRoot = Join-Path $projectRoot 'mod\KI5KnoxCountyFleet'
$catalogPath = Join-Path $sourceRoot '42\media\lua\shared\KI5KnoxCountyFleet_Catalog.lua'
$provenancePath = Join-Path $projectRoot 'docs\ki5-provider-inventory.json'
$reportPath = Join-Path $projectRoot 'docs\fleet-inventory.md'
$rootDescriptor = Join-Path $sourceRoot 'mod.info'
$b42Descriptor = Join-Path $sourceRoot '42\mod.info'
$mergeRules = @(Get-Content -LiteralPath (Join-Path $projectRoot 'config\merge-rules.json') -Raw | ConvertFrom-Json)

function Fail([string] $Message) {
    throw "[KI5KnoxCountyFleet catalog] $Message"
}

function Read-Descriptor([string] $Path) {
    $values = @{}
    foreach ($line in Get-Content -LiteralPath $Path) {
        if ($line -match '^([^=]+)=(.*)$') {
            $values[$matches[1]] = $matches[2]
        }
    }
    return $values
}

function Set-DescriptorField([string] $Path, [string] $Field, [string] $Value) {
    $found = $false
    $lines = foreach ($line in Get-Content -LiteralPath $Path) {
        if ($line -match ('^' + [regex]::Escape($Field) + '=')) {
            $found = $true
            "$Field=$Value"
        }
        else {
            $line
        }
    }
    if (-not $found) { Fail "Descriptor is missing $Field=: $Path" }
    [IO.File]::WriteAllText($Path, (($lines -join "`n") + "`n"), [Text.UTF8Encoding]::new($false))
}

function Escape-Lua([string] $Value) {
    return $Value.Replace('\', '\\').Replace('"', '\"')
}

function Get-DescriptorPath([string] $ModDirectory) {
    foreach ($relativePath in @('42.20\mod.info', '42.13\mod.info', '42.0\mod.info', '42\mod.info', 'mod.info')) {
        $path = Join-Path $ModDirectory $relativePath
        if (Test-Path -LiteralPath $path -PathType Leaf) { return $path }
    }
    return $null
}

function Get-RuntimeScriptRoots([string] $ModDirectory) {
    $roots = [Collections.Generic.List[string]]::new()
    foreach ($relativePath in @('42.20\media\scripts', '42.13\media\scripts', '42.0\media\scripts', '42\media\scripts', 'media\scripts')) {
        $path = Join-Path $ModDirectory $relativePath
        if (-not (Test-Path -LiteralPath $path -PathType Container)) { continue }
        $hasVehicle = Get-ChildItem -LiteralPath $path -Recurse -File -Filter '*.txt' | ForEach-Object {
            Select-String -LiteralPath $_.FullName -Pattern '^\s*vehicle\s+([A-Za-z0-9_]+)' -Quiet
        } | Where-Object { $_ } | Select-Object -First 1
        if ($hasVehicle) {
            $roots.Add($path)
            if ($relativePath -ne 'media\scripts') {
                $sharedRoot = Join-Path $ModDirectory 'media\scripts'
                if (Test-Path -LiteralPath $sharedRoot -PathType Container) { $roots.Add($sharedRoot) }
            }
            break
        }
    }
    return $roots.ToArray()
}

function Get-RuntimeLuaFiles([string] $ModDirectory) {
    foreach ($relativePath in @('42.20\media\lua', '42.13\media\lua', '42.0\media\lua', '42\media\lua', 'media\lua')) {
        $path = Join-Path $ModDirectory $relativePath
        if (-not (Test-Path -LiteralPath $path -PathType Container)) { continue }
        $files = @(Get-ChildItem -LiteralPath $path -Recurse -File -Filter '*.lua')
        if ($files.Count -gt 0) { return $files }
    }
}

function Get-VehicleDistributionReferences([string] $ModDirectory, [hashtable] $DistributionProfiles = $null) {
    $references = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($file in Get-RuntimeLuaFiles $ModDirectory) {
        $contents = Get-Content -LiteralPath $file.FullName -Raw
        if ([string]::IsNullOrWhiteSpace($contents) -or $contents -notmatch '(?i)VehicleZoneDistribution') { continue }
        foreach ($match in [regex]::Matches($contents, '(?i)["''](?<script>Base\.[A-Za-z0-9_]+)["'']')) {
            [void]$references.Add($match.Groups['script'].Value)
        }
        if ($null -ne $DistributionProfiles) {
            foreach ($pattern in @(
                'VehicleZoneDistribution\.(?<zone>[A-Za-z0-9_]+)\.vehicles\s*\[\s*["''](?<script>Base\.[A-Za-z0-9_]+)["'']\s*\]\s*=\s*\{(?<entry>.*?)\}',
                'VehicleZoneDistribution\[\s*["''](?<zone>[A-Za-z0-9_]+)["'']\s*\]\.vehicles\s*\[\s*["''](?<script>Base\.[A-Za-z0-9_]+)["'']\s*\]\s*=\s*\{(?<entry>.*?)\}'
            )) {
                foreach ($assignment in [regex]::Matches($contents, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)) {
                    $chanceMatch = [regex]::Match($assignment.Groups['entry'].Value, '(?i)spawnChance\s*=\s*(?<chance>[0-9]+(?:\.[0-9]+)?)')
                    if (-not $chanceMatch.Success) { continue }
                    $zoneName = $assignment.Groups['zone'].Value.ToLowerInvariant()
                    $scriptName = $assignment.Groups['script'].Value
                    if (-not $DistributionProfiles.ContainsKey($scriptName)) { $DistributionProfiles[$scriptName] = @{} }
                    $chance = [double]::Parse($chanceMatch.Groups['chance'].Value, [Globalization.CultureInfo]::InvariantCulture)
                    if (-not $DistributionProfiles[$scriptName].ContainsKey($zoneName) -or $chance -gt $DistributionProfiles[$scriptName][$zoneName]) {
                        $DistributionProfiles[$scriptName][$zoneName] = $chance
                    }
                }
            }
        }
    }
    return $references
}

function Merge-DistributionProfiles([hashtable] $Destination, [hashtable] $Source) {
    foreach ($scriptName in $Source.Keys) {
        if (-not $Destination.ContainsKey($scriptName)) { $Destination[$scriptName] = @{} }
        foreach ($zoneName in $Source[$scriptName].Keys) {
            $chance = [double]$Source[$scriptName][$zoneName]
            if (-not $Destination[$scriptName].ContainsKey($zoneName) -or $chance -gt $Destination[$scriptName][$zoneName]) {
                $Destination[$scriptName][$zoneName] = $chance
            }
        }
    }
}

function Get-CombinedFileHash([IO.FileInfo[]] $Files) {
    $algorithm = [Security.Cryptography.SHA256]::Create()
    try {
        foreach ($file in $Files | Sort-Object FullName) {
            $bytes = [IO.File]::ReadAllBytes($file.FullName)
            [void] $algorithm.TransformBlock($bytes, 0, $bytes.Length, $bytes, 0)
        }
        [void] $algorithm.TransformFinalBlock([byte[]]::new(0), 0, 0)
        return ([BitConverter]::ToString($algorithm.Hash)).Replace('-', '')
    }
    finally { $algorithm.Dispose() }
}

if (-not (Test-Path -LiteralPath $ServerConfig -PathType Leaf)) { Fail "Missing public fleet profile: $ServerConfig" }
if (-not (Test-Path -LiteralPath $WorkshopRoot -PathType Container)) { Fail "Missing Project Zomboid Workshop root: $WorkshopRoot" }
foreach ($path in @($rootDescriptor, $b42Descriptor)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { Fail "Missing suite descriptor: $path" }
}

$modsLine = Get-Content -LiteralPath $ServerConfig | Where-Object { $_ -like 'Mods=*' } | Select-Object -First 1
$workshopLine = Get-Content -LiteralPath $ServerConfig | Where-Object { $_ -like 'WorkshopItems=*' } | Select-Object -First 1
if (-not $modsLine -or -not $workshopLine) { Fail 'Fleet profile is missing Mods= or WorkshopItems=.' }
$activeMods = ($modsLine -replace '^Mods=', '').Split(';') | Where-Object { $_ }
$workshopItems = ($workshopLine -replace '^WorkshopItems=', '').Split(';') | Where-Object { $_ }

$moduleLookup = @{}
foreach ($workshopId in $workshopItems) {
    $modsDirectory = Join-Path (Join-Path $WorkshopRoot $workshopId) 'mods'
    if (-not (Test-Path -LiteralPath $modsDirectory -PathType Container)) { continue }
    foreach ($modDirectory in Get-ChildItem -LiteralPath $modsDirectory -Directory) {
        $descriptorPath = Get-DescriptorPath $modDirectory.FullName
        if (-not $descriptorPath) { continue }
        $descriptor = Read-Descriptor $descriptorPath
        $modId = $descriptor['id']
        if ([string]::IsNullOrWhiteSpace($modId) -or $moduleLookup.ContainsKey($modId)) { continue }
        $moduleLookup[$modId] = [pscustomobject]@{
            ModId = $modId
            WorkshopId = $workshopId
            Name = $descriptor['name']
            Directory = $modDirectory.FullName
            DescriptorPath = $descriptorPath
        }
    }
}

$excludedModuleIds = @('82jeepJ10', '82jeepJ10t')
$ki5ModuleIds = @('KI5campers', 'KI5trailers')
$candidateModuleIds = @($activeMods | Where-Object {
    ($_ -match '^\d{2}' -or $ki5ModuleIds -contains $_ -or $_ -match '^MCV' -or $_ -eq 'LFPSP-B42Fix') -and
    $excludedModuleIds -notcontains $_
})

$defaultGroupByModule = @{
    '04vwTouran' = 'compact'; '59meteor' = 'luxury'; '63beetle' = 'compact'; '63Type2Van' = 'van'
    '65banshee' = 'sports'; '66pontiacLeMans' = 'civilian'; '67commando' = 'military'; '67gt500' = 'sports'
    '68firebird' = 'sports'; '69camaro' = 'sports'; '69charger' = 'sports'; '69fordMustang' = 'sports'; '69mini' = 'compact'
    '70barracuda' = 'sports'; '70chevelle' = 'civilian'; '70dodge' = 'sports'; '70fordEscort' = 'compact'; '70roadRunner' = 'sports'
    '73fordFalcon' = 'civilian'; '73nissanGTR' = 'sports'; '75grandPrix' = 'civilian'; '76chevyKseries' = 'pickup'
    '76chevyKseriesExpanded' = 'commercial'; '76chryslerNewYorker' = 'luxury'; '77firebird' = 'sports'
    '78amgeneralM35A2' = 'military'; '78lamboCountach' = 'sports'; '79camaro' = 'sports'; '80manKat1' = 'military'
    '81deloreanDMC12' = 'sports'; '82firebird' = 'sports'; '82oshkoshM911' = 'military'; '82porsche911' = 'sports'
    '83amgeneralM923' = 'military'; '83gmcGseriesVans' = 'van'; '84buickElectra' = 'luxury'; '84cadillacDeVille' = 'luxury'
    '84corvette' = 'sports'; '84gageV300' = 'military'; '84jeepXJ' = 'suv'; '84merc' = 'suv'; '84oldsmobile98' = 'luxury'
    '85buickLeSabre' = 'civilian'; '85chevyCaprice' = 'civilian'; '85chevyStepVan' = 'commercial'
    '85chevyStepVanexpanded' = 'commercial'; '85oldsmobileDelta88' = 'civilian'; '85pontiacParisienne' = 'civilian'
    '86chevyCUCV' = 'military'; '86fordE150' = 'van'; '86fordE150expanded' = 'commercial'; '86oshkoshP19A' = 'military'
    '87buickRegal' = 'civilian'; '87chevySuburban' = 'suv'; '87fordB700' = 'commercial'; '87toyotaCorolla' = 'compact'
    '87toyotaMR2' = 'sports'; '88chevyS10' = 'pickup'; '88toyotaHilux' = 'pickup'; '89defender' = 'suv'
    '89dodgeCaravan' = 'van'; '89fordBronco' = 'suv'; '89trooper' = 'suv'; '89volvo200' = 'civilian'
    '90bmwE30' = 'luxury'; '90fordF350ambulance' = 'ambulance'; '90pierceArrow' = 'fire'; '91fordLTD' = 'civilian'
    '91fordRanger' = 'pickup'; '91geoMetro' = 'compact'; '91lexusLS400' = 'luxury'; '91nissan240sx' = 'sports'
    '91range' = 'suv'; '92amgeneralM998' = 'military'; '92fordCVPI' = 'police'; '92jeepYJ' = 'suv'
    '92nissanGTR' = 'sports'; '93chevySuburban' = 'pickup'; '93chevySuburbanExpanded' = 'commercial'
    '93fordF350' = 'pickup'; '93fordTaurus' = 'civilian'; '93mustangSSP' = 'sports'; '95impreza' = 'sports'
    '96lancerEVO' = 'sports'; '96saturnSseries' = 'compact'; '98stagea' = 'wagon'; '99fordCVPI' = 'police'
    'KI5campers' = 'trailer'; 'KI5trailers' = 'trailer'
    'MCV93fordFseries' = 'commercial'; 'MCV76chevyKseries' = 'pickup'; 'MCV86chevyCUCV' = 'military'; 'MCV67commando' = 'military'; 'LFPSP-B42Fix' = 'police'
}
$militaryModuleIds = @('67commando', '78amgeneralM35A2', '80manKat1', '82oshkoshM911', '83amgeneralM923', '84gageV300', '86chevyCUCV', '86oshkoshP19A', '92amgeneralM998', 'MCV86chevyCUCV', 'MCV67commando')
$militaryTruckPattern = '^(?:78amgeneralM35A2|78amgeneralM49A2C|78amgeneralM50A3|78amgeneralM62|80manKat1|82oshkoshM911|83amgeneralM923|86chevyM1008|86chevyM1010|86chevyM1028|86chevyM1031|86oshkoshUSMC)'
$amGeneralTruckPattern = '^(?:78amgeneralM35A2|78amgeneralM49A2C|78amgeneralM50A3|78amgeneralM62|83amgeneralM923)'
$commercialPattern = '(?i)(blacksmith|brewster|brush|building|carpentry|catering|construction|deer|distil|electrics|fabrication|farming|fossoil|garden|glass|landscap|laundry|lumber|masonry|mechanic|metal|mccoy|mobile|motorshop|painting|plumb|postal|propane|repair|service|shuttle|tailor|transit|utility|welding|wood|wrecker|zippee|box|flatbed|bank|airport|calloway|camille|helton|kimble|marchridge|yingswood|brickingit)'

function Get-Group([string] $ModId, [string] $ScriptName) {
    if ($ScriptName -match '(?i)burnt') { return 'preserved-burnt' }
    if ($ScriptName -match '^Trailer' -and $ScriptName -match '(?i)(?:M101|M1082|M1095|M127|M128|M129|M747|M967|M1101|M1165)') { return 'militaryTrailer' }
    if ($ScriptName -match '^Trailer') { return 'trailer' }
    if ($ScriptName -match '(?i)(ambulance|med$)') { return 'ambulance' }
    if ($ScriptName -match '(?i)prison') { return 'prison' }
    # Pontiac Firebird is a sports car, not a fire-service vehicle. Prefer
    # per-vehicle service roles: the P19A provider also supplies military
    # transports, so its module identity alone must not classify every vehicle
    # as fire-service.
    if (($ModId -eq '86oshkoshP19A' -and $ScriptName -match '(?i)(?:FRTR55|KYFD)$') -or
        $ModId -eq '90pierceArrow' -or
        $ScriptName -match '(?i)(?:firetruck|fire$|fd$|kyfd$|frtr55$)') { return 'fire' }
    # Ranger is also a Ford pickup model name. Only the explicit ranger-service
    # livery suffix belongs in the park-ranger pool; RangerSC/XC are civilian.
    if ($ScriptName -match '(?i)ranger$') { return 'ranger' }
    # The CVPI provider also defines an ordinary Crown Victoria and puts it
    # in civilian parking/medium pools. Do not treat every provider script as
    # a police interceptor merely because the module is named CVPI.
    if ($ModId -eq '92fordCVPI' -and $ScriptName -eq '92fordCV') { return 'civilian' }
    # SO is the sheriff-service suffix on E150 and F350 bodies. The plain SSP
    # Mustang is civilian; only its PD/KSP/unmarked suffixes are police.
    if ($ScriptName -match '(?i)(police|pd\w*$|ksp|sheriff|swat|so$|pdu|unmarked)' -or
        $ModId -eq 'LFPSP-B42Fix') { return 'police' }
    if ($ScriptName -eq '86fordE150valkyriesSpear') { return 'van' }
    if ($ModId -eq '86chevyCUCV' -and $ScriptName -match '(?i)K5pd$') { return 'police' }
    if ($ScriptName -match '(?i)taxi') { return 'taxi' }
    if ($ScriptName -match '(?i)(military|CUCV$|wolf$)' -or $militaryModuleIds -contains $ModId) {
        if ($ScriptName -match $militaryTruckPattern) { return 'militaryTruck' }
        return 'militaryCar'
    }
    if ($ScriptName -match '(?i)wagon') { return 'wagon' }
    if ($ScriptName -match $commercialPattern) { return 'commercial' }
    if (-not $defaultGroupByModule.ContainsKey($ModId)) { Fail "No semantic category is declared for vehicle provider $ModId script $ScriptName" }
    return $defaultGroupByModule[$ModId]
}

$recordsByScript = @{}
$providers = [Collections.Generic.List[object]]::new()
$supportOnly = [Collections.Generic.List[object]]::new()
$overrides = [Collections.Generic.List[object]]::new()
$optionalDisabledVariants = [Collections.Generic.List[object]]::new()
$optionalDisabledScripts = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)

$activeModuleSet = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
foreach ($modId in $activeMods) { [void]$activeModuleSet.Add($modId) }
$enabledSpawnScripts = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$disabledSpawnModulesByScript = @{}
$sourceDistributionProfiles = @{}
foreach ($module in $moduleLookup.Values) {
    $isEnabled = $activeModuleSet.Contains($module.ModId)
    $moduleProfiles = @{}
    foreach ($scriptName in Get-VehicleDistributionReferences $module.Directory $moduleProfiles) {
        if ($isEnabled) {
            [void]$enabledSpawnScripts.Add($scriptName)
        } else {
            if (-not $disabledSpawnModulesByScript.ContainsKey($scriptName)) {
                $disabledSpawnModulesByScript[$scriptName] = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
            }
            [void]$disabledSpawnModulesByScript[$scriptName].Add($module.ModId)
        }
    }
    if ($isEnabled) { Merge-DistributionProfiles $sourceDistributionProfiles $moduleProfiles }
}

function Is-DisabledOptionalVariant([string] $Script, [string] $SourceModId, [string] $WorkshopId, [bool] $Bundled) {
    if (-not $disabledSpawnModulesByScript.ContainsKey($Script) -or $enabledSpawnScripts.Contains($Script)) { return $false }
    if ($optionalDisabledScripts.Add($Script)) {
        $optionalDisabledVariants.Add([pscustomobject]@{
            Script = $Script
            SourceModId = $SourceModId
            WorkshopId = $WorkshopId
            Bundled = $Bundled
            DisabledSpawnModuleIds = @($disabledSpawnModulesByScript[$Script] | Sort-Object)
            Reason = 'Vehicle is defined by an enabled provider, but its explicit spawn references exist only in disabled modules.'
        })
    }
    return $true
}

function Add-ScriptRecord([object] $Record) {
    $existing = $recordsByScript[$Record.Script]
    if ($existing) {
        $rule = @($mergeRules | Where-Object { $_.script -eq $Record.Script -and $_.baseModId -eq $existing.ModId -and $_.addonModId -eq $Record.ModId })
        if ($rule.Count -ne 1) { Fail "Unreviewed vehicle ID collision: $($Record.Script) from $($existing.ModId) and $($Record.ModId)" }
        $overrides.Add([pscustomobject]@{ Script = $Record.Script; ReplacedModId = $existing.ModId; ReplacingModId = $Record.ModId; Reason = 'External add-on redeclares the same ID; no upstream definition is copied. Inspect upstream compatibility before gameplay acceptance.' })
    }
    $recordsByScript[$Record.Script] = $Record
}

foreach ($modId in $candidateModuleIds) {
    $module = $moduleLookup[$modId]
    if (-not $module) { Fail "Active KI5 module is not present in the installed Workshop items: $modId" }
    $scriptRoots = @(Get-RuntimeScriptRoots $module.Directory)
    $descriptorHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $module.DescriptorPath).Hash
    if ($scriptRoots.Count -eq 0) {
        $supportOnly.Add([pscustomobject]@{ ModId = $modId; WorkshopId = $module.WorkshopId; Name = $module.Name; DescriptorHash = $descriptorHash; Bundled = $false })
        continue
    }
    $scriptFiles = @($scriptRoots | ForEach-Object { Get-ChildItem -LiteralPath $_ -Recurse -File -Filter '*.txt' } | Sort-Object FullName)
    $runtimePaths = @($scriptRoots | ForEach-Object { $_.Substring($module.Directory.Length).TrimStart('\') })
    $runtimePath = $runtimePaths -join ' + '
    $sourceHash = Get-CombinedFileHash $scriptFiles
    $seen = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($file in $scriptFiles) {
        Select-String -LiteralPath $file.FullName -Pattern '^\s*vehicle\s+([A-Za-z0-9_]+)' | ForEach-Object {
            $bareName = $_.Matches[0].Groups[1].Value
            if (-not $seen.Add($bareName)) { return }
            $scriptName = "Base.$bareName"
            if (-not (Is-DisabledOptionalVariant $scriptName $modId $module.WorkshopId $false)) {
                Add-ScriptRecord ([pscustomobject]@{
                    Script = $scriptName; ModId = $modId; WorkshopId = $module.WorkshopId; Group = Get-Group $modId $bareName
                    DescriptorHash = $descriptorHash; SourceHash = $sourceHash; Bundled = $false; RuntimePath = $runtimePath
                })
            }
        }
    }
    $providers.Add([pscustomobject]@{ ModId = $modId; WorkshopId = $module.WorkshopId; Name = $module.Name; RuntimePath = $runtimePath; ScriptCount = $seen.Count; DescriptorHash = $descriptorHash; SourceHash = $sourceHash; Bundled = $false })
}

$allGroups = @('civilian', 'compact', 'luxury', 'sports', 'wagon', 'pickup', 'van', 'commercial', 'suv', 'police', 'prison', 'fire', 'ranger', 'ambulance', 'taxi', 'militaryCar', 'militaryTruck', 'militaryTrailer', 'trailer')
$groups = @{}
foreach ($group in $allGroups) { $groups[$group] = [Collections.Generic.List[string]]::new() }
foreach ($record in $recordsByScript.Values | Sort-Object Script) {
    if ($record.Group -ne 'preserved-burnt') { $groups[$record.Group].Add($record.Script) }
}
if ($recordsByScript.Count -eq 0) { Fail 'No external or bundled KI5 vehicle scripts were discovered.' }
$militaryCars = @($groups['militaryCar'] | Sort-Object -Unique)
$militaryTrucks = @($groups['militaryTruck'] | Sort-Object -Unique)
if ($militaryCars -notcontains 'Base.92amgeneralM998') { Fail 'Active Humvee Base.92amgeneralM998 was not classified in the military car pool.' }
$otherMilitaryCars = @($militaryCars | Where-Object { $_ -ne 'Base.92amgeneralM998' })
if ($otherMilitaryCars.Count -eq 0) { Fail 'The 95-percent Humvee policy requires at least one other military car/support vehicle.' }
$amGeneralTrucks = @($militaryTrucks | Where-Object { ($_ -replace '^Base\.', '') -match $amGeneralTruckPattern })
$m35Transport = @($amGeneralTrucks | Where-Object { $_ -eq 'Base.78amgeneralM35A2' })
$otherAMGeneralTrucks = @($amGeneralTrucks | Where-Object { $_ -ne 'Base.78amgeneralM35A2' })
$otherMilitaryTrucks = @($militaryTrucks | Where-Object { ($_ -replace '^Base\.', '') -notmatch $amGeneralTruckPattern })
$requiredAMGeneralTrucks = @('Base.78amgeneralM35A2', 'Base.83amgeneralM923')
$missingAMGeneralTrucks = @($requiredAMGeneralTrucks | Where-Object { $_ -notin $amGeneralTrucks })
if ($missingAMGeneralTrucks.Count -gt 0) { Fail "The preferred AM General truck families are missing: $($missingAMGeneralTrucks -join ', ')." }
if ($m35Transport.Count -eq 0 -or $otherAMGeneralTrucks.Count -eq 0) { Fail 'The military truck weighting requires the M35A2 cargo transport and at least one rarer AM General variant.' }
if ($otherMilitaryTrucks.Count -eq 0) { Fail 'The 75-percent AM General policy requires at least one other military truck.' }

$wreckedMilitaryCars = @($recordsByScript.Values | Where-Object {
    $_.Group -eq 'preserved-burnt' -and (Get-Group $_.ModId (($_.Script -replace '^Base\.', '') -replace '(?i)Burnt$', '')) -eq 'militaryCar'
} | Select-Object -ExpandProperty Script | Sort-Object -Unique)
$wreckedMilitaryTrucks = @($recordsByScript.Values | Where-Object {
    $_.Group -eq 'preserved-burnt' -and (Get-Group $_.ModId (($_.Script -replace '^Base\.', '') -replace '(?i)Burnt$', '')) -eq 'militaryTruck'
} | Select-Object -ExpandProperty Script | Sort-Object -Unique)
$wreckedHumvee = @($wreckedMilitaryCars | Where-Object { $_ -eq 'Base.92amgeneralM998Burnt' })
$otherWreckedMilitaryCars = @($wreckedMilitaryCars | Where-Object { $_ -ne 'Base.92amgeneralM998Burnt' })
$wreckedAMGeneralTrucks = @($wreckedMilitaryTrucks | Where-Object { (($_ -replace '^Base\.', '') -replace '(?i)Burnt$', '') -match $amGeneralTruckPattern })
$otherWreckedMilitaryTrucks = @($wreckedMilitaryTrucks | Where-Object { (($_ -replace '^Base\.', '') -replace '(?i)Burnt$', '') -notmatch $amGeneralTruckPattern })
if ($wreckedHumvee.Count -eq 0 -or $otherWreckedMilitaryCars.Count -eq 0) { Fail 'Burnt military car sources must include the M998 and at least one non-Humvee military car to preserve the 95/5 wreck ratio.' }
if ($wreckedAMGeneralTrucks.Count -eq 0 -or $otherWreckedMilitaryTrucks.Count -eq 0) { Fail 'Burnt military truck sources must include an AM General and another truck family to preserve the 75/25 wreck ratio.' }
if ($wreckedMilitaryTrucks -notcontains 'Base.78amgeneralM35A2Burnt') { Fail 'Burnt military trucks must include the M35A2 transport wreck.' }

$derivedGroups = @{
    # Keep specialty luxury and performance bodies in their own vanilla pools.
    # A CarNormal replacement must not make them as common as ordinary cars.
    normal = @('civilian')
    modern = @('civilian', 'compact')
    offroad = @('suv', 'pickup')
    race = @('sports')
    prisonPolice = @('prison', 'police')
    commercialVan = @('commercial', 'van')
    military = @('militaryCar', 'militaryTruck', 'militaryTrailer')
}

$rarityWeights = @{}
$specialtyRarityPattern = '(?i)(?:ecto|ghostbuster|kitt|mr.?bean|spiffo|valkyrie|medical|examiner|swat|prison|airportsecurity|bank|armou?red|prototype|showcar)'
foreach ($record in $recordsByScript.Values) {
    $weight = 1.0
    if ($record.Script -eq 'Base.86fordE150med') {
        # The medical-examiner E150 is a special liveried ambulance, not a
        # routine substitute for every ambulance or burnt ambulance.
        $weight = 0.02
    }
    elseif ($record.Script -match $specialtyRarityPattern) {
        # Named one-off, tactical, branded, or specialist variants stay in
        # their semantic pool but are strongly down-weighted in any broad role.
        $weight = 0.05
    }
    $rarityWeights[$record.Script] = $weight
}

function Add-WeightedEntries([Collections.Generic.List[string]] $Destination, [string[]] $ScriptNames, [int] $Count) {
    if ($ScriptNames.Count -eq 0) { Fail 'Cannot allocate weighted slots to an empty vehicle group.' }
    $baseCount = [Math]::Floor($Count / $ScriptNames.Count)
    $remainder = $Count % $ScriptNames.Count
    for ($index = 0; $index -lt $ScriptNames.Count; $index++) {
        $copies = $baseCount + $(if ($index -lt $remainder) { 1 } else { 0 })
        for ($copy = 0; $copy -lt $copies; $copy++) { $Destination.Add($ScriptNames[$index]) }
    }
}

$ambulanceCandidates = @($groups['ambulance'] | Sort-Object -Unique)
$preferredAmbulance = 'Base.90fordF350ambulance'
if ($preferredAmbulance -notin $ambulanceCandidates) { Fail "The preferred KI5 ambulance is missing: $preferredAmbulance." }
$otherAmbulances = @($ambulanceCandidates | Where-Object { $_ -ne $preferredAmbulance })
if ($otherAmbulances.Count -eq 0) { Fail 'The ambulance pool requires at least one backup ambulance so the preferred KI5 ambulance can be near-exclusive, not exclusive.' }
$ambulanceSlots = [Collections.Generic.List[string]]::new()
Add-WeightedEntries $ambulanceSlots @($preferredAmbulance) 950
Add-WeightedEntries $ambulanceSlots $otherAmbulances 50

$militaryCarSlots = [Collections.Generic.List[string]]::new()
Add-WeightedEntries $militaryCarSlots @('Base.92amgeneralM998') 950
Add-WeightedEntries $militaryCarSlots $otherMilitaryCars 50
$militaryTruckSlots = [Collections.Generic.List[string]]::new()
Add-WeightedEntries $militaryTruckSlots $m35Transport 638
Add-WeightedEntries $militaryTruckSlots $otherAMGeneralTrucks 112
Add-WeightedEntries $militaryTruckSlots $otherMilitaryTrucks 250
$militaryCarWreckSlots = [Collections.Generic.List[string]]::new()
Add-WeightedEntries $militaryCarWreckSlots $wreckedHumvee 950
Add-WeightedEntries $militaryCarWreckSlots $otherWreckedMilitaryCars 50
$militaryTruckWreckSlots = [Collections.Generic.List[string]]::new()
$wreckedM35Transport = @($wreckedAMGeneralTrucks | Where-Object { $_ -eq 'Base.78amgeneralM35A2Burnt' })
$otherWreckedAMGeneralTrucks = @($wreckedAMGeneralTrucks | Where-Object { $_ -ne 'Base.78amgeneralM35A2Burnt' })
Add-WeightedEntries $militaryTruckWreckSlots $wreckedM35Transport 638
Add-WeightedEntries $militaryTruckWreckSlots $otherWreckedAMGeneralTrucks 112
Add-WeightedEntries $militaryTruckWreckSlots $otherWreckedMilitaryTrucks 250
if ($militaryCarSlots.Count -ne 1000) { Fail "Military car weighted catalog must contain 1000 slots, got $($militaryCarSlots.Count)." }
if ($militaryTruckSlots.Count -ne 1000) { Fail "Military truck weighted catalog must contain 1000 slots, got $($militaryTruckSlots.Count)." }
if ($militaryCarWreckSlots.Count -ne 1000) { Fail "Military wrecked car weighted catalog must contain 1000 slots, got $($militaryCarWreckSlots.Count)." }
if ($militaryTruckWreckSlots.Count -ne 1000) { Fail "Military wrecked truck weighted catalog must contain 1000 slots, got $($militaryTruckWreckSlots.Count)." }

$policeRegionalPattern = '(?i)(Louisville|Muldraugh|Meade|WestPoint|Bulletin|CLPD|LCPD|MPD|WPPD|MCS|BCS|Airport|Security|Prison|SWAT)'
$policeRegionalScripts = @($groups['police'] | Where-Object { $_ -match $policeRegionalPattern } | Sort-Object -Unique)
$policeGenericScripts = @($groups['police'] | Where-Object { $_ -notmatch $policeRegionalPattern } | Sort-Object -Unique)
if ($policeGenericScripts.Count -eq 0) { Fail 'The generic police pool is empty after regional livery isolation.' }

$lua = [Text.StringBuilder]::new()
[void] $lua.AppendLine('-- Generated by scripts/generate-fleet-catalog.ps1 from config/fleet-profile.ini and read-only external Workshop inputs.')
[void] $lua.AppendLine('-- The catalog never contains Specific Loot (Workshop 3457132019).')
[void] $lua.AppendLine('local Catalog = {')
[void] $lua.AppendLine('    groups = {')
foreach ($groupName in $allGroups) {
    [void] $lua.AppendLine("        $groupName = {")
    foreach ($scriptName in $groups[$groupName] | Sort-Object -Unique) { [void] $lua.AppendLine(('            "' + (Escape-Lua $scriptName) + '",')) }
    [void] $lua.AppendLine('        },')
}
[void] $lua.AppendLine('        policeGeneric = {')
foreach ($scriptName in $policeGenericScripts) { [void] $lua.AppendLine(('            "' + (Escape-Lua $scriptName) + '",')) }
[void] $lua.AppendLine('        },')
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    policeScripts = {')
foreach ($scriptName in $groups['police'] | Sort-Object -Unique) { [void] $lua.AppendLine(('        ["' + (Escape-Lua $scriptName) + '"] = true,')) }
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    regionalPoliceScripts = {')
foreach ($scriptName in $policeRegionalScripts) { [void] $lua.AppendLine(('        "' + (Escape-Lua $scriptName) + '",')) }
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    disabledOptionalScripts = {')
foreach ($optional in $optionalDisabledVariants | Sort-Object Script) { [void] $lua.AppendLine(('        ["' + (Escape-Lua $optional.Script) + '"] = true,')) }
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    wreckedGroups = {')
foreach ($wreckedPolicy in @(
    @{ Name = 'militaryCar'; Scripts = $wreckedMilitaryCars },
    @{ Name = 'militaryTruck'; Scripts = $wreckedMilitaryTrucks }
)) {
    [void] $lua.AppendLine("        $($wreckedPolicy.Name) = {")
    foreach ($scriptName in $wreckedPolicy.Scripts) { [void] $lua.AppendLine(('            "' + (Escape-Lua $scriptName) + '",')) }
    [void] $lua.AppendLine('        },')
}
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    weights = {')
foreach ($weightPolicy in @(
    @{ Name = 'ambulance'; Slots = $ambulanceSlots },
    @{ Name = 'militaryCar'; Slots = $militaryCarSlots },
    @{ Name = 'militaryTruck'; Slots = $militaryTruckSlots },
    @{ Name = 'militaryCarWreck'; Slots = $militaryCarWreckSlots },
    @{ Name = 'militaryTruckWreck'; Slots = $militaryTruckWreckSlots }
)) {
    [void] $lua.AppendLine("        $($weightPolicy.Name) = {")
    foreach ($scriptName in @($weightPolicy.Slots | Sort-Object -Unique)) {
        $weight = @($weightPolicy.Slots | Where-Object { $_ -eq $scriptName }).Count
        [void] $lua.AppendLine(('            ["' + (Escape-Lua $scriptName) + '"] = ' + $weight + ','))
    }
    [void] $lua.AppendLine('        },')
}
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    rarityWeights = {')
foreach ($scriptName in $rarityWeights.Keys | Where-Object { [double]$rarityWeights[$_] -lt 1 } | Sort-Object) {
    $weight = ([double]$rarityWeights[$scriptName]).ToString('0.###', [Globalization.CultureInfo]::InvariantCulture)
    [void] $lua.AppendLine(('        ["' + (Escape-Lua $scriptName) + '"] = ' + $weight + ','))
}
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    zoneWeights = {')
foreach ($scriptName in $sourceDistributionProfiles.Keys | Where-Object { $recordsByScript.ContainsKey($_) } | Sort-Object) {
    [void] $lua.AppendLine(('        ["' + (Escape-Lua $scriptName) + '"] = {'))
    foreach ($zoneName in $sourceDistributionProfiles[$scriptName].Keys | Sort-Object) {
        $weight = ([double]$sourceDistributionProfiles[$scriptName][$zoneName]).ToString('0.###', [Globalization.CultureInfo]::InvariantCulture)
        [void] $lua.AppendLine(('            ["' + (Escape-Lua $zoneName) + '"] = ' + $weight + ','))
    }
    [void] $lua.AppendLine('        },')
}
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    weightedGroups = {')
foreach ($weightPolicy in @(
    @{ Name = 'militaryCar'; Slots = $militaryCarSlots },
    @{ Name = 'militaryTruck'; Slots = $militaryTruckSlots },
    @{ Name = 'militaryCarWreck'; Slots = $militaryCarWreckSlots },
    @{ Name = 'militaryTruckWreck'; Slots = $militaryTruckWreckSlots }
)) {
    [void] $lua.AppendLine("        $($weightPolicy.Name) = {")
    foreach ($scriptName in $weightPolicy.Slots) { [void] $lua.AppendLine(('            "' + (Escape-Lua $scriptName) + '",')) }
    [void] $lua.AppendLine('        },')
}
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('    providers = {')
foreach ($provider in $providers | Sort-Object ModId, Bundled) {
    [void] $lua.AppendLine(('        {{ modId = "{0}", workshopId = "{1}", scriptCount = {2}, bundled = {3}, descriptorHash = "{4}", sourceHash = "{5}" }},' -f (Escape-Lua $provider.ModId), $provider.WorkshopId, $provider.ScriptCount, $provider.Bundled.ToString().ToLowerInvariant(), $provider.DescriptorHash, $provider.SourceHash))
}
[void] $lua.AppendLine('    },')
[void] $lua.AppendLine('}')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('local function union(...)')
[void] $lua.AppendLine('    local result, seen = {}, {}')
[void] $lua.AppendLine('    for index = 1, select("#", ...) do')
[void] $lua.AppendLine('        for _, scriptName in ipairs(select(index, ...)) do')
[void] $lua.AppendLine('            if not seen[scriptName] then seen[scriptName] = true; table.insert(result, scriptName) end')
[void] $lua.AppendLine('        end')
[void] $lua.AppendLine('    end')
[void] $lua.AppendLine('    return result')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
foreach ($derivedName in $derivedGroups.Keys | Sort-Object) {
    $inputs = ($derivedGroups[$derivedName] | ForEach-Object { 'Catalog.groups.' + $_ }) -join ', '
    [void] $lua.AppendLine("Catalog.groups.$derivedName = union($inputs)")
}
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.copy(groupName)')
[void] $lua.AppendLine('    return union(Catalog.groups[groupName] or {})')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.combine(...)')
[void] $lua.AppendLine('    local inputs = {}')
[void] $lua.AppendLine('    for index = 1, select("#", ...) do table.insert(inputs, Catalog.groups[select(index, ...)] or {}) end')
[void] $lua.AppendLine('    return union(unpack(inputs))')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.weight(groupName, scriptName, zoneName)')
[void] $lua.AppendLine('    local weights = Catalog.weights[groupName]')
[void] $lua.AppendLine('    if weights and weights[scriptName] ~= nil then return weights[scriptName] end')
[void] $lua.AppendLine('    local rarity = Catalog.rarityWeights[scriptName] or 1')
[void] $lua.AppendLine('    local sourceWeights = Catalog.zoneWeights[scriptName]')
[void] $lua.AppendLine('    local zoneKey = type(zoneName) == "string" and string.lower(zoneName) or nil')
[void] $lua.AppendLine('    if zoneKey then')
[void] $lua.AppendLine('        local groupHasSourceWeight = false')
[void] $lua.AppendLine('        for _, candidate in ipairs(Catalog.groups[groupName] or {}) do')
[void] $lua.AppendLine('            local candidateWeights = Catalog.zoneWeights[candidate]')
[void] $lua.AppendLine('            if candidateWeights and candidateWeights[zoneKey] ~= nil then groupHasSourceWeight = true; break end')
[void] $lua.AppendLine('        end')
[void] $lua.AppendLine('        if sourceWeights and sourceWeights[zoneKey] ~= nil then')
[void] $lua.AppendLine('            local sourceWeight = sourceWeights[zoneKey]')
[void] $lua.AppendLine('            if rarity < 1 then return math.min(sourceWeight * rarity, rarity) end')
[void] $lua.AppendLine('            return sourceWeight')
[void] $lua.AppendLine('        elseif sourceWeights and groupHasSourceWeight then')
[void] $lua.AppendLine('            return 0 -- explicitly zoned vehicles do not leak into a different source zone')
[void] $lua.AppendLine('        end')
[void] $lua.AppendLine('    end')
[void] $lua.AppendLine('    return rarity')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.wreckedWeight(groupName, scriptName, zoneName)')
[void] $lua.AppendLine('    local weights = Catalog.weights[groupName .. "Wreck"]')
[void] $lua.AppendLine('    if weights and weights[scriptName] ~= nil then return weights[scriptName] end')
[void] $lua.AppendLine('    local rarity = Catalog.rarityWeights[scriptName] or 1')
[void] $lua.AppendLine('    local sourceWeights = Catalog.zoneWeights[scriptName]')
[void] $lua.AppendLine('    local zoneKey = type(zoneName) == "string" and string.lower(zoneName) or nil')
[void] $lua.AppendLine('    if zoneKey then')
[void] $lua.AppendLine('        local groupHasSourceWeight = false')
[void] $lua.AppendLine('        for _, candidate in ipairs(Catalog.wreckedGroups[groupName] or {}) do')
[void] $lua.AppendLine('            local candidateWeights = Catalog.zoneWeights[candidate]')
[void] $lua.AppendLine('            if candidateWeights and candidateWeights[zoneKey] ~= nil then groupHasSourceWeight = true; break end')
[void] $lua.AppendLine('        end')
[void] $lua.AppendLine('        if sourceWeights and sourceWeights[zoneKey] ~= nil then')
[void] $lua.AppendLine('            local sourceWeight = sourceWeights[zoneKey]')
[void] $lua.AppendLine('            if rarity < 1 then return math.min(sourceWeight * rarity, rarity) end')
[void] $lua.AppendLine('            return sourceWeight')
[void] $lua.AppendLine('        elseif sourceWeights and groupHasSourceWeight then')
[void] $lua.AppendLine('            return 0')
[void] $lua.AppendLine('        end')
[void] $lua.AppendLine('    end')
[void] $lua.AppendLine('    return rarity')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('local function weightedList(groupName, candidates, slots, zoneName, wrecked)')
[void] $lua.AppendLine('    slots = math.max(1, math.floor(tonumber(slots) or 250))')
[void] $lua.AppendLine('    local entries, total = {}, 0')
[void] $lua.AppendLine('    for _, scriptName in ipairs(candidates or {}) do')
[void] $lua.AppendLine('        local weight = wrecked and Catalog.wreckedWeight(groupName, scriptName, zoneName) or Catalog.weight(groupName, scriptName, zoneName)')
[void] $lua.AppendLine('        if weight and weight > 0 then total = total + weight; table.insert(entries, { script = scriptName, weight = weight }) end')
[void] $lua.AppendLine('    end')
[void] $lua.AppendLine('    if total <= 0 then return {} end')
[void] $lua.AppendLine('    local result, remainders, assigned = {}, {}, 0')
[void] $lua.AppendLine('    for index, entry in ipairs(entries) do')
[void] $lua.AppendLine('        local exact = slots * entry.weight / total')
[void] $lua.AppendLine('        local count = math.floor(exact)')
[void] $lua.AppendLine('        assigned = assigned + count')
[void] $lua.AppendLine('        remainders[index] = { index = index, value = exact - count }')
[void] $lua.AppendLine('        for _ = 1, count do table.insert(result, entry.script) end')
[void] $lua.AppendLine('    end')
[void] $lua.AppendLine('    table.sort(remainders, function(a, b) if a.value == b.value then return a.index < b.index end return a.value > b.value end)')
[void] $lua.AppendLine('    for index = 1, slots - assigned do table.insert(result, entries[remainders[index].index].script) end')
[void] $lua.AppendLine('    return result')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.weightedCopy(groupName, slots, zoneName)')
[void] $lua.AppendLine('    local special = Catalog.weightedGroups[groupName]')
[void] $lua.AppendLine('    if special and (slots == nil or slots == 1000) then')
[void] $lua.AppendLine('        local copy = {}')
[void] $lua.AppendLine('        for _, scriptName in ipairs(special) do table.insert(copy, scriptName) end')
[void] $lua.AppendLine('        return copy')
[void] $lua.AppendLine('    end')
[void] $lua.AppendLine('    return weightedList(groupName, Catalog.groups[groupName] or {}, slots, zoneName, false)')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.weightedList(groupName, candidates, slots, zoneName)')
[void] $lua.AppendLine('    return weightedList(groupName, candidates, slots, zoneName, false)')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.weightedCombine(slots, ...)')
[void] $lua.AppendLine('    local count = select("#", ...)')
[void] $lua.AppendLine('    if count == 0 then return {} end')
[void] $lua.AppendLine('    slots = math.max(count, math.floor(tonumber(slots) or 250))')
[void] $lua.AppendLine('    local result = {}')
[void] $lua.AppendLine('    for index = 1, count do')
[void] $lua.AppendLine('        local groupName = select(index, ...)')
[void] $lua.AppendLine('        local groupSlots = math.floor(slots / count) + (index <= (slots % count) and 1 or 0)')
[void] $lua.AppendLine('        for _, scriptName in ipairs(Catalog.weightedCopy(groupName, groupSlots)) do table.insert(result, scriptName) end')
[void] $lua.AppendLine('    end')
[void] $lua.AppendLine('    return result')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('function Catalog.wreckedWeightedCopy(groupName, slots)')
[void] $lua.AppendLine('    return weightedList(groupName, Catalog.wreckedGroups[groupName] or {}, slots, nil, true)')
[void] $lua.AppendLine('end')
[void] $lua.AppendLine('')
[void] $lua.AppendLine('return Catalog')
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $catalogPath) | Out-Null
[IO.File]::WriteAllText($catalogPath, $lua.ToString(), [Text.UTF8Encoding]::new($false))

$requiredModules = @('damnlib') + $candidateModuleIds + @('KI5Camo', 'PapaChadCamo')
foreach ($moduleId in $requiredModules) {
    if (-not $moduleLookup.ContainsKey($moduleId)) { Fail "Required external module is absent from current Workshop inputs: $moduleId" }
}
$requireValue = $requiredModules -join ','
Set-DescriptorField $rootDescriptor 'require' $requireValue
Set-DescriptorField $b42Descriptor 'require' $requireValue

$finalRecords = @($recordsByScript.Values | Sort-Object ModId, Script)
$provenance = [ordered]@{
    schemaVersion = 1
    sourceConfiguration = [IO.Path]::GetFileName($ServerConfig)
    sourceConfigurationHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $ServerConfig).Hash
    workshopAppId = '108600'
    externalRequiredModules = $requiredModules
    bundledModuleIds = @($providers | Where-Object Bundled | Select-Object -ExpandProperty ModId | Sort-Object -Unique)
    providers = @($providers | Sort-Object ModId, Bundled)
    supportOnly = @($supportOnly | Sort-Object ModId)
    scripts = $finalRecords
    optionalDisabledVariants = @($optionalDisabledVariants | Sort-Object Script)
    overrides = @($overrides)
    excluded = @(
        [ordered]@{ WorkshopId = '3457132019'; ModId = 'SpecLoot'; Reason = 'Explicit user exclusion.' },
        [ordered]@{ ModId = '82jeepJ10'; Reason = 'Explicit older-project exclusion remains outside the generated world catalogue.' },
        [ordered]@{ ModId = '82jeepJ10t'; Reason = 'Dependent J10 skin remains excluded with the J10 base vehicle.' }
    )
}
[IO.File]::WriteAllText($provenancePath, (($provenance | ConvertTo-Json -Depth 9) + [Environment]::NewLine), [Text.UTF8Encoding]::new($false))

$report = [Text.StringBuilder]::new()
[void] $report.AppendLine('# KI5: Knox County Fleet catalogue')
[void] $report.AppendLine('')
[void] $report.AppendLine("- External vehicle providers: $(@($providers | Where-Object { -not $_.Bundled }).Count)")
[void] $report.AppendLine("- Bundled MCV/police providers: $(@($providers | Where-Object Bundled).Count)")
[void] $report.AppendLine("- External support-only modules: $($supportOnly.Count)")
[void] $report.AppendLine("- Final selectable non-burnt scripts: $(@($finalRecords | Where-Object { $_.Group -ne 'preserved-burnt' }).Count)")
[void] $report.AppendLine("- Preserved burnt scripts: $(@($finalRecords | Where-Object { $_.Group -eq 'preserved-burnt' }).Count)")
[void] $report.AppendLine("- Excluded disabled optional vehicle variants: $($optionalDisabledVariants.Count)")
[void] $report.AppendLine('- Specific Loot is explicitly excluded from both bundle and dependency closure.')
[void] $report.AppendLine('')
[void] $report.AppendLine('## Spawn groups')
[void] $report.AppendLine('')
[void] $report.AppendLine('| Group | Scripts |')
[void] $report.AppendLine('| --- | ---: |')
foreach ($groupName in $allGroups) { [void] $report.AppendLine("| $groupName | $($groups[$groupName].Count) |") }
[void] $report.AppendLine('')
[void] $report.AppendLine('## Military vehicle weighting')
[void] $report.AppendLine('')
[void] $report.AppendLine('- Light/utility military pool: exactly 95% `Base.92amgeneralM998` Humvee; the remaining 5% is evenly spread over the other non-truck military/support scripts.')
[void] $report.AppendLine('- Ambulance candidate pools are weighted 95% to `Base.90fordF350ambulance`; the remaining 5% is shared by the other valid KI5 ambulance scripts. The F350 is fixed to its white EMS skin rather than random Brush/Rescue paint.')
[void] $report.AppendLine('- Military truck pool: exactly 75% AM General family scripts; `Base.78amgeneralM35A2` is 638/1000 overall (85% of the AM General share), and the other AM General variants divide the remaining 112/1000.')
[void] $report.AppendLine('- Burnt military pools use the same exact 95% M998 Humvee and 75% AM General truck family ratios; `Base.78amgeneralM35A2Burnt` is 638/1000 truck-wreck slots.')
[void] $report.AppendLine('- Military-zone policy targets VMZ B42 child pools after the split: all-vehicle stalls balance car/truck roles, light stalls use the 95% M998 car pool, heavy stalls use the 75% AM General truck pool, burnt vehicles retain the same role-specific ratios, and trailers are re-sorted by VMZ off-road class.')
[void] $report.AppendLine('- Military trailers are isolated from ordinary trailer and commercial pools. Active military vehicles are removed from non-military zones; only rare burnt military wrecks may remain in roads, traffic jams, and junkyards.')
[void] $report.AppendLine('')
[void] $report.AppendLine('## Cross-pool rarity policy')
[void] $report.AppendLine('')
[void] $report.AppendLine('- `CarNormal` and its smashed counterpart contain ordinary passenger cars only; compact cars, station wagons, luxury cars, and sports models remain in their own dedicated pools.')
[void] $report.AppendLine('- Explicit upstream `VehicleZoneDistribution` source weights are retained when available, and source-zoned candidates do not leak into another zone when their group has an explicit profile for that zone. Named specialist/one-off models receive a 5% relative weight or less in every generated map, crash, wreck, and profession/story pool; the Medical Examiner E150 receives 2% or less.')
[void] $report.AppendLine('- Profession/story arrays use weighted choices; multi-category story pools split choices evenly across their semantic vehicle classes before applying within-class weights.')
[void] $report.AppendLine('')
[void] $report.AppendLine('## Intentional script override')
[void] $report.AppendLine('')
foreach ($override in $overrides) { [void] $report.AppendLine("- `$($override.Script)` — `$($override.ReplacedModId)` is intentionally superseded by external `$($override.ReplacingModId)` content; inspect upstream collision risks.") }
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $reportPath) | Out-Null
[IO.File]::WriteAllText($reportPath, $report.ToString(), [Text.UTF8Encoding]::new($false))

Write-Output "Generated catalog: $catalogPath"
Write-Output "Generated $(@($providers | Where-Object { -not $_.Bundled }).Count) external providers, $(@($providers | Where-Object Bundled).Count) bundled providers, $($finalRecords.Count) selectable scripts, and $($optionalDisabledVariants.Count) disabled optional variants excluded; ambulance pools are 95% F350 EMS and M35A2 transport is 638/1000 military-truck weight."
