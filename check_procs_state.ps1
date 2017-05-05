Param(
  [string]$process
)

if ((get-process "$process" -ea SilentlyContinue) -eq $Null)
{ 
    echo "WARNING - $process is not running" 
	exit 2
}

else 
{ 
	echo "OK - $process is running"
	exit 0
}
