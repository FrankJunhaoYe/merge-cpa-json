$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$outputPath = Join-Path $scriptRoot "all.json"

$jsonFiles = Get-ChildItem -Path $scriptRoot -Filter "*.json" -File -Recurse |
    Where-Object { $_.Name -ne "all.json" } |
    Sort-Object FullName

$items = [System.Collections.Generic.List[object]]::new()

foreach ($file in $jsonFiles) {
    try {
        $jsonText = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $parsed = $jsonText | ConvertFrom-Json
        [void]$items.Add($parsed)
    }
    catch {
        throw "Failed to read or parse JSON file '$($file.FullName)': $($_.Exception.Message)"
    }
}

$jsonOutput = if ($items.Count -eq 0) {
    @()
}
elseif ($items.Count -eq 1) {
    @($items[0])
}
else {
    $items.ToArray()
}

Set-Content -Path $outputPath -Value ($jsonOutput | ConvertTo-Json -Depth 100) -Encoding UTF8

Write-Host "Merged $($items.Count) JSON file(s) into $outputPath"
