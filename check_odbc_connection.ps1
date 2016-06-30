# Source from 
# https://blog.netways.de/2011/11/07/odbc-datenbankzugriff-mit-powershell/

#DSN angeben, dabei sind _SERVERNAME_, _DATABASE_, _DBUSER_ und _DBPASSWORD_ jeweils zu ersetzen
$DBDSN="Driver={SQL Server};Server=_SERVERNAME_;Database=_DATABASE_;UID=_DBUSER_;PWD=_DBPASSWORD_;"

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
$DBCommand.CommandText="_QUERY_"

#Ein Reader-Objekt erzeugen
$DBResult=$DBCommand.ExecuteReader()

#Anzahl der Rows zählen
#DBCounter=$DBResult.FieldCount

#Rows durchiterieren
while ($DBResult.Read()) {
	for ($i = 0; $i -lt $DBCounter; $i++) {
		#Rows formatiert ausgeben
		@{ $DBResult.GetName($i) = $DBResult.GetValue($i); }
	}
}

#Datenbankverbindung schließen
DBConnection.Close()