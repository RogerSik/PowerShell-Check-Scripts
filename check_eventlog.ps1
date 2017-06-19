Param(
[string]$LogName,
[string]$EntryType,
[string]$Hour,
[string]$warning # warn if x is greater than
)

$Count = Get-EventLog  -LogName $LogName -EntryType $EntryType -ErrorAction SilentlyContinue -After (Get-Date).AddHours(-$Hour)  | Measure-Object | Select-Object -expand Count
$Output = Get-EventLog -LogName $LogName -EntryType $EntryType -ErrorAction SilentlyContinue -After (Get-Date).AddHours(-$Hour) | select Index, Source, Message

if ($Count -lt $warning) {
		    Write-Host "OK -" $count"|query="$count";"
				Write-Output $Output
		    exit 0
		}

Else {
		    Write-Host "Warning -" $count"|query="$count";"
				Write-Output $Output
		    exit 2
		}
