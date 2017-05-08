Param(
  [string]$Path,
  [string]$ExclusionFilter1,
  [string]$ExclusionFilter2,
  [string]$critical
)

$Status=Get-ChildItem $Path | where-object {(new-timespan $_.LastWriteTime).minutes -gt $critical} | where { $ExclusionFilter1 -notcontains $_ } | where { $ExclusionFilter2 -notcontains $_ }
$StatusNumber=$Status.Count


if (!$Status) {
    Write-Host "OK - No files older than $critical minutes found|result=$StatusNumber;"
    exit 0
}

elseif ($Status) {
    Write-Host "Critical - Files older than $critical minutes found|result=$StatusNumber;"
    $Status | Select Name, LastWriteTime
    exit 2
}
