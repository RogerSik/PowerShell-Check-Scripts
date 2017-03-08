Param(
  [string]$drive
)

Get-PSDrive $drive -EA SilentlyContinue | out-null

if ($drive -eq "") {
    Write-Host "No Drive Letter as Argument!"
    }

elseif ($? -eq "TRUE") {
    Write-Host "$drive drive Accessible"
    }

else {
    Write-Host "$drive drive NOT Not Accessible / Problems"
    }
