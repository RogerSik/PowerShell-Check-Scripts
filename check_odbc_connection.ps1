# Source from
# https://blog.netways.de/2011/11/07/odbc-datenbankzugriff-mit-powershell/

Param(
[string]$server,
[string]$database,
[string]$uid,
[string]$pwd,
[string]$query,
[string]$critical # warn if x is greater than
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
		if ($DBResult.GetValue($i) -lt $critical) {
		    Write-Host "OK -" $DBResult.GetValue($i)
		    exit 0
		}

		Else {
		    Write-Host "Critical -" $DBResult.GetValue($i)
		    exit 2
		}
	}
}

#Datenbankverbindung schließen
$DBConnection.Close()
