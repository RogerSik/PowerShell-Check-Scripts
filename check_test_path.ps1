Param(
[string]$Path
)

$Command = Test-Path $Path

if ($command -eq "True") {
		    Write-Host "OK -" $Path "is reachable"
		    exit 0
		}

Else {
		    Write-Host "Warning -" $Path "is NOT reachable"
		    exit 2
		}
