# Load SMO extension
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null;
 Import-Module SQLPS -DisableNameChecking

# The server instance where we insert the results
$AppServer = ""
$AppDB = ""

# Gets a list of servers
$ServerQuery = "Select [ServerName] FROM MasterServerList Where IsMirrored = 1 and IsEnabled = 1"
$Servers = Invoke-Sqlcmd -Query $ServerQuery -ServerInstance $AppServer

# Deletes the current values of the mirroring health database
$Truncate = "Truncate Table MirroringHealth"
Invoke-Sqlcmd -ServerInstance $AppServer -Database $AppDB -Query $Truncate

# Loop through each server
Foreach ($Server in $Servers)
{

	$srv = New-Object "Microsoft.SqlServer.Management.Smo.Server" $Server;
	# Get mirrored databases
	$databases = $srv.Databases | Where-Object {$_.IsMirroringEnabled -eq $true};
	
	

Foreach($Database IN $Databases)
{

$Dbname = $database.Name
$Status = $database.MirroringStatus

$Query = "Insert INTO MirroringHealth (DatabaseName, MirroringStatus) Values ('$Dbname', '$Status')"

Invoke-sqlcmd -ServerInstance $AppServer -Database $AppDB -Query $Query

} 
}