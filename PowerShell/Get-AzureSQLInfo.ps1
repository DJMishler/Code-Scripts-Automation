# The purpose of this script is to pull all the SQL Servers that are under each subscriptions we are a part of
$azureApplicationID = "20675bc2-a09d-492a-8d60-fb9432fc8209"
$azureTenantID = "ae2bff4d-4382-4532-b4a0-f1e5a9c874a8"
$SecretVault = (Get-AzKeyVaultSecret -vaultname "DM-KeyVaultSecret" -name "DBA-Reader").SecretValueText
$azureSecret = ConvertTo-SecureString -String $SecretVault -AsPlainText -Force
$pscredential = New-Object -TypeName System.Management.Automation.PSCredential($azureApplicationID, $azureSecret)

Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $azureTenantID

$Subs = Get-AzSubscription | Where-Object Name -NE "Visual Studio Professional Subscription"

# Loop through the SQL Servers per Subscription; a good way to do this is to run them through a loop
Foreach($Sub IN $Subs)
{

# this is where you change the subscription
Set-AzContext $Sub

# Pass in all the SQL Servers in the current subscription
$Servers = Get-AzSqlServer | Select-Object ServerName, Location, SqlAdministratorLogin, ServerVersion, FullyQualifiedDomainName, ResourceGroupName

Foreach($Server IN $Servers)
{
    $Servername = $Server.ServerName
    $Location = $Server.Location
    $SqlAdmin = $Server.SqlAdministratorLogin
    $ServerVersion = $Server.ServerVersion
    $FQDN = $Server.FullyQualifiedDomainName
    $Resource = $Server.ResourceGroupName
    $SubName = $Sub.Name
    
    # You can use Invoke-SQLCMD to connect to your SQL Instance and pass in the values to your inventory Database
    
    $Query = "IF (Select ServerName FROM AzureServers WHERE ServerName = '$Servername') IS NULL
              INSERT INTO AzureServers ([ServerName], [Location], [SqlAdminLogin], [ServerVersion], [FQDN], [ResourceGroupName], [SubscriptionName])
              Values ('$Servername', '$Location', '$SqlAdmin', '$ServerVersion', '$FQDN', '$Resource', '$SubName')"
 
    Invoke-Sqlcmd -Query $Query -ServerInstance "1S8KSPOTLIGHT01" -Database monitoring
}

}

