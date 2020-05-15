#https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-change-tracking-feature-portal

$subscriptionId = '1858bd04-a58d-4368-bd55-bd585350e6d3'
$resourceGroupName = "MyResourceGrp"
$location = "EastUS2"
$adminLogin = "azureuser"
$password = "PWD27!"+(New-Guid).Guid
$serverName = "mysqlserver-$(Get-Random)"
$databaseName = "mySampleDatabase"

# The ip address range that you want to allow to access your server 
# (leaving at 0.0.0.0 will prevent outside-of-azure connections to your DB)
$startIp = "66.229.112.22"
$endIp = "66.229.112.22"

# Show randomized variables
Write-host "Resource group name is" $resourceGroupName 
Write-host "Password is" $password  
Write-host "Server name is" $serverName 

# Connect to Azure
Connect-AzAccount

# Set subscription ID
Set-AzContext -SubscriptionId $subscriptionId 

# Create a resource group
#Write-host "Creating resource group..."
#$resourceGroup = New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag @{Owner="SQLDB-Samples"}
#$resourceGroup

# Create a server with a system wide unique server name
Write-host "Creating primary logical server..."
$server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
   -ServerName $serverName `
   -Location $location `
   -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential `
   -ArgumentList $adminLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
$server

# Create a server firewall rule that allows access from the specified IP range
Write-host "Configuring firewall for primary logical server..."
$serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName `
   -ServerName $serverName `
   -FirewallRuleName "AllowedIPs" -StartIpAddress $startIp -EndIpAddress $endIp
$serverFirewallRule

# Create General Purpose Gen4 database with 1 vCore
Write-host "Creating a gen5 2 vCore database..."
$database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
   -ServerName $serverName `
   -DatabaseName $databaseName `
   -Edition GeneralPurpose `
   -VCore 2 `
   -ComputeGeneration Gen5 `
   -MinimumCapacity 2 `
   -SampleName "AdventureWorksLT"
$database