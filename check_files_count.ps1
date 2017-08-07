Param(
  [string]$Path,
  [string]$warning,
  [string]$critical,
  [string]$ListFiles
)

$Files=Get-ChildItem $Path -File | Select LastWriteTime,Name
$Files_Count=(Get-ChildItem $Path -File).count

# Logic Check
if ($Warning -gt $Critical) {
    Write-Output "Warning ($warning) can't be higher then critical! ($critical)"
    exit 2
}

# Here happens the magic
if ($Files_count -lt $warning) {
    Write-Output "OK|result=$Files_count;"
    exit 0
}

elseif ($Files_count -le $critical) {
    Write-Output "Warning - Files: $Files_Count found|result=$Files_count;"
    if ($ListFiles -eq 'TRUE') { Write-Output $Files }
    exit 1
}

elseif ($Files_count -ge $critical) {
    Write-Output "Critical - Files: $Files_Count found|result=$Files_count;"
    if ($ListFiles -eq 'TRUE') { Write-Output $Files }
    exit 2
}
