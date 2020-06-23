
#connect-azaccount

$Subs = Get-AzSubscription

Foreach($Sub IN $Subs)
{

Set-AzContext $Sub

$Servers = Get-AzSqlServer | Select ServerName, Location, SqlAdministratorLogin, ServerVersion, FullyQualifiedDomainName, ResourceGroupName

Foreach($Server IN $Servers)
{
    $Server
    #$Sub.Name
    $Query = "INSERT INTO AzureServers (Servername, Location, SqlAdminLogin, ServerVersion, FQDN, ResourceGroupName, SubscriptionName) Values ()"

    Invoke-Sqlcmd -Query $Query -ServerInstance "1S8KSPOTLIGHT01" -Database "Monitoring"
}

}

