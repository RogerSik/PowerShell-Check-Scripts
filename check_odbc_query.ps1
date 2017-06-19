# Source from
# https://blog.netways.de/2011/11/07/odbc-datenbankzugriff-mit-powershell/

Param(
[string]$server,
[string]$database,
[string]$uid,
[string]$pwd,
[string]$query,
[string]$warning, # warning if x is greater than
[string]$critical # critical if x is greater than
)

$DBDSN="Driver={SQL Server};Server=$server;Database=$database;UID=$uid;PWD=$pwd;"

#Datenbankverbindungsobjekt instanzieren
$DBConnection=New-Object System.Data.Odbc.OdbcConnection

#DSN im Objekt setzen
$DBConnection.ConnectionString=$DBDSN

#Datenbankverbindung öffnen
$DBConnection.Open()

#Datenbankbefehlsobjekt instanzieren
$DBCommand=New-Object System.Data.Odbc.OdbcCommand

#Datenbankverbindung in Befehlsobjekt setzen
$DBCommand.Connection=$DBConnection

#Query angeben, dabei muss _QUERY_ durch das gewünschte Query ersetzt werden
$DBCommand.CommandText="$query"

#Ein Reader-Objekt erzeugen
$DBResult=$DBCommand.ExecuteReader()

#Anzahl der Rows zählen
$DBCounter=$DBResult.FieldCount

#Rows durchiterieren
while ($DBResult.Read()) {
	for ($i = 0; $i -lt $DBCounter; $i++) {
		if ($DBResult.GetValue($i) -lt $warning) {
		    $result = $DBResult.GetValue($i)
		    Write-Host "OK -" $result"|query="$result";"
		    exit 0
		}

		ElseIf ($DBResult.GetValue($i) -lt $critical) {
		    $result = $DBResult.GetValue($i)
		    Write-Host "Warning -" $result"|query="$result";"
		    exit 1
		}

		Else {
	            $result = $DBResult.GetValue($i)
		    Write-Host "Critical -" $result"|query="$result";"
		    exit 2
		}
	}
}

#Datenbankverbindung schließen
$DBConnection.Close()
