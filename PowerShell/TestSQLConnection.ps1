Import-Module SQLPS -DisableNameChecking

#$Servers = @(Get-Content("C:\ListofServers.txt"))
#$AppServer = ""
#$AppDB = ""
#$ServerQuery = 
#"SELECT Distinct [ServerName] FROM [DBA].[dbo].[dba_mastersqlserverlist] 
#where IsEnabled = 1 and Servername NOT IN ('FTLPI3APP03', 'FTLPI3APP04', 'FTLQVDBA01', 'FTLPSSRS02', 'FTLPSSRS03', 'FTLPBISSAS05', 'FTLPBISSAS06')"
#$Servers = Invoke-Sqlcmd -Query $ServerQuery -ServerInstance $AppServer


# For this test we are going to manually add the server name so that we can test the functionality.

$Servers = "Glacier\Instance"

Foreach($Server IN $Servers)
{
$ServerName = $Server.ServerName
$Query = "
Insert INTO FailedConnections (InstanceName) Values ('$ServerName') 
Go"

$connectionString = "Data Source=$ServerName;Integrated Security=true;Initial Catalog=master;Connect Timeout=15;" 
$sqlConn = new-object ("Data.SqlClient.SqlConnection") $connectionString 

Try 
{
$sqlConn.Open()
#We can probably remove this Write-Host since we don't really care if we have a positive connection
#Write-Host "Connected to $ServerName"
$sqlConn.close()
}

Catch
{
#Write-Host "Could not connect to $ServerName"
Invoke-Sqlcmd -ServerInstance $AppServer -Database $AppDB -Query $Query

}


}