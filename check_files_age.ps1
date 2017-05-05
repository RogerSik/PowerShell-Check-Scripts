Param(
  [string]$Path,
  [string]$ExclusionFilter1,
  [string]$ExclusionFilter2,
  [string]$critical
)

$Status=Get-ChildItem $Path | where-object {(new-timespan $_.LastWriteTime).minutes -gt $critical} | where { $ExclusionFilter1 -notcontains $_ } | where { $ExclusionFilter2 -notcontains $_ }


if (!$Status) {
    Write-Host "OK - No files older then $critical minutes found"
    exit 0
}

elseif ($Status) {
    Write-Host "Critical - Files older then $critical minutes found"
    $Status | Select Name, LastWriteTime
    exit 2
}
