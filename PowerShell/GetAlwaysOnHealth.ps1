# Set-ExecutionPolicy RemoteSigned
Import-Module sqlps -DisableNameChecking
# The Server instance where we insert the results
$AppServer = ""
# Name of Primary Node
$primarynode = "ftlpodssqlcl01"
# Name of Availability Group
$AGName = "ODS"
# This is our destination database where we insert the results
$AppDB = ""


cd SQLServer:\sql\$primarynode\default\availabilitygroups\$AGName\DatabaseReplicaStates

$vars = Dir | Select-Object AvailabilityReplicaServerName, AvailabilityDatabaseName, SynchronizationState 

$truncate = "Truncate Table AlwaysOnHealth"
Invoke-SQLCMD -ServerInstance $AppServer -Database $AppDB -Query $truncate

ForEach($var IN $vars)
{
    $var1 = $var.AvailabilityReplicaServerName
    $var2 = $var.AvailabilityDatabaseName
    $var3 = $var.SynchronizationState

    $Query = "Insert INTO AlwaysOnHealth (ServerName, DatabaseName, Status) Values ('$var1', '$var2', '$var3')"

    Invoke-SQLCMD -ServerInstance $AppServer -Database $AppDB -Query $Query

    }