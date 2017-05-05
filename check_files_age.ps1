Param(
  [string]$Path,
  [string]$critical
)

$Status=Get-ChildItem $Path | where-object {(new-timespan $_.LastWriteTime).minutes -gt $critical}


if (!$Status) {
    Write-Host "OK - No files older then $critical minutes found"
    exit 0
}

elseif ($Status) {
    Write-Host "Critical - Files older then $critical minutes found"
    exit 1
}
