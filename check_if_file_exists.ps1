Param(
  [string]$folder,
  [string]$warning,
  [string]$critical
)

$result = (dir $folder | measure).Count;

If ($result -lt $warning){
      Write-Host "OK - $result File exists!|files=$result;"
      exit 0
}

If ($result -gt $warning){
      Write-Host "Warning - $result File exists!|files=$result;"
      Exit 1
}

If ($result -gt $critical){
      Write-Host "Critical - $result File exists!|files=$result;"
      Exit 2
}
