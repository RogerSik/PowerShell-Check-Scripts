Param(
  [string]$folder
)

If (Test-Path $folder){
    # // File exists
    Write-Host "CRITICAL - File exists!"
    exit 2
}

Else {
    # // File does not exist
    Write-Host "OK - No File exists!"
    exit 0
}