# Lists candidate Cursor local agent transcript sessions.
# Read-only: this script does not modify Cursor data or the repository.

$ErrorActionPreference = "Stop"
$projectsRoot = Join-Path $env:USERPROFILE ".cursor\projects"

if (-not (Test-Path -LiteralPath $projectsRoot -PathType Container)) {
    Write-Error "Cursor projects directory not found: $projectsRoot"
    exit 1
}

$transcriptRoots = Get-ChildItem -LiteralPath $projectsRoot -Directory -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -eq "agent-transcripts" }

$rows = foreach ($root in $transcriptRoots) {
    $jsonlFiles = Get-ChildItem -LiteralPath $root.FullName -File -Filter "*.jsonl" -Recurse -ErrorAction SilentlyContinue
    $sessionDirs = Get-ChildItem -LiteralPath $root.FullName -Directory -ErrorAction SilentlyContinue

    foreach ($sessionDir in $sessionDirs) {
        $sessionFiles = Get-ChildItem -LiteralPath $sessionDir.FullName -File -Recurse -ErrorAction SilentlyContinue
        $sessionJsonl = @($sessionFiles | Where-Object { $_.Extension -eq ".jsonl" })
        if ($sessionFiles.Count -gt 0) {
            [PSCustomObject]@{
                WorkspaceTranscriptRoot = $root.FullName
                SessionDirectory = $sessionDir.FullName
                JsonlFiles = ($sessionJsonl.FullName -join "; ")
                FileCount = $sessionFiles.Count
                JsonlCount = $sessionJsonl.Count
                TotalBytes = ($sessionFiles | Measure-Object -Property Length -Sum).Sum
                LastWriteTime = ($sessionFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime
            }
        }
    }

    $directJsonl = @($jsonlFiles | Where-Object { $_.DirectoryName -eq $root.FullName })
    if ($directJsonl.Count -gt 0) {
        [PSCustomObject]@{
            WorkspaceTranscriptRoot = $root.FullName
            SessionDirectory = $root.FullName
            JsonlFiles = ($directJsonl.FullName -join "; ")
            FileCount = $directJsonl.Count
            JsonlCount = $directJsonl.Count
            TotalBytes = ($directJsonl | Measure-Object -Property Length -Sum).Sum
            LastWriteTime = ($directJsonl | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime
        }
    }
}

if (-not $rows) {
    Write-Warning "No candidate JSONL transcript files found. Run the harmless local Agent probe, close Cursor, then retry."
    exit 2
}

$rows | Sort-Object LastWriteTime -Descending | Format-Table -AutoSize -Wrap
