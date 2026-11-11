param(
    [Parameter(Mandatory = $true)]
    [string]$SessionDirectory
)

$ErrorActionPreference = "Stop"

$cursorProcess = Get-Process -Name "Cursor" -ErrorAction SilentlyContinue
if ($cursorProcess) {
    throw "Close Cursor completely before capture so transcript files are flushed."
}

$projectsRoot = (Resolve-Path -LiteralPath (Join-Path $env:USERPROFILE ".cursor\projects")).Path
$sourcePath = (Resolve-Path -LiteralPath $SessionDirectory).Path
$prefix = $projectsRoot.TrimEnd("\") + "\"

if (-not $sourcePath.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Source must be inside the Cursor projects directory: $projectsRoot"
}

$jsonlFiles = @(Get-ChildItem -LiteralPath $sourcePath -File -Filter "*.jsonl" -Recurse -Force)
if ($jsonlFiles.Count -eq 0) {
    throw "No JSONL transcript found in source session directory: $sourcePath"
}

$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\..")).Path
$destinationRoot = Join-Path $repoRoot "03-ai-agent-evidence\raw\cursor"
$sessionId = Split-Path -Path $sourcePath -Leaf
$workspaceRoot = Split-Path -Path (Split-Path -Path $sourcePath -Parent) -Parent
$workspaceSlug = Split-Path -Path $workspaceRoot -Leaf
$folderName = ($workspaceSlug + "--" + $sessionId) -replace '[<>:"/\\|?*]', '_'
$destination = Join-Path $destinationRoot $folderName

if (Test-Path -LiteralPath $destination) {
    throw "Capture already exists; refusing to overwrite: $destination"
}

New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null
New-Item -ItemType Directory -Path $destination -Force | Out-Null
Get-ChildItem -LiteralPath $sourcePath -Force | Copy-Item -Destination $destination -Recurse

$sourceFiles = @(Get-ChildItem -LiteralPath $sourcePath -File -Recurse -Force)
$capturedFiles = @(Get-ChildItem -LiteralPath $destination -File -Recurse -Force)

if ($sourceFiles.Count -ne $capturedFiles.Count) {
    throw "File-count mismatch. Source=$($sourceFiles.Count), captured=$($capturedFiles.Count). Do not use this capture."
}

$hashRows = foreach ($sourceFile in $sourceFiles) {
    $relative = $sourceFile.FullName.Substring($sourcePath.Length).TrimStart("\")
    $capturedFile = Join-Path $destination $relative
    if (-not (Test-Path -LiteralPath $capturedFile -PathType Leaf)) {
        throw "Captured file missing: $relative"
    }

    $sourceHash = (Get-FileHash -LiteralPath $sourceFile.FullName -Algorithm SHA256).Hash
    $capturedHash = (Get-FileHash -LiteralPath $capturedFile -Algorithm SHA256).Hash
    if ($sourceHash -ne $capturedHash) {
        throw "SHA-256 mismatch for $relative"
    }

    [PSCustomObject]@{
        RelativePath = $relative
        Length = $sourceFile.Length
        SHA256 = $sourceHash
        Match = $true
    }
}

$sourceRelative = $sourcePath.Substring($projectsRoot.Length).TrimStart("\")
$manifest = [PSCustomObject]@{
    CaptureType = "Unmodified directory copy; file contents are not parsed or rewritten"
    SourceRelativeToCursorProjects = $sourceRelative
    CapturedRelativeToRepository = "03-ai-agent-evidence/raw/cursor/$folderName"
    CapturedAtUtc = [DateTime]::UtcNow.ToString("o")
    FileCount = $hashRows.Count
    Files = @($hashRows)
}

$manifestPath = Join-Path $destinationRoot ($folderName + ".capture-manifest.json")
$json = $manifest | ConvertTo-Json -Depth 6
[System.IO.File]::WriteAllText($manifestPath, $json, [System.Text.UTF8Encoding]::new($false))

Write-Host "Capture completed. Source and copied file hashes match."
Write-Host "Captured directory: $destination"
Write-Host "Manifest: $manifestPath"
Write-Host "Review for secrets/PII before committing. Do not edit raw transcript files."
