Param(
  [string]$drive
)

Get-PSDrive $drive -EA SilentlyContinue | out-null

if ($drive -eq "") {
    Write-Host "No Drive Letter as Argument!"
    exit 2
    }

elseif ($? -eq "TRUE") {
    Write-Host "$drive drive Accessible"
    exit 0
    }

else {
    Write-Host "$drive drive NOT Not Accessible / Problems"
    exit 2
    }
