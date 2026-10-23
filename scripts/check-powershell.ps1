$ErrorActionPreference = 'Stop'
$files = @(Get-ChildItem -LiteralPath $PSScriptRoot -Filter *.ps1 -Recurse -File)
foreach ($file in $files) {
    $tokens = $null
    $errors = $null
    $null = [Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$errors)
    if ($errors.Count) { throw ($errors.Message -join "`n") }
}
Write-Output "PASS: $($files.Count) PowerShell scripts parsed (not executed)."
