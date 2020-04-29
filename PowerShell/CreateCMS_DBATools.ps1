#The way that I'm doing this is I'm basing it off the fact that there is a table called Servers which has Servername, and a column called application which details what application that server is used for



Import-module SQLPS -DisableNameChecking

#Get a list of all Applications

$Apps = invoke-sqlcmd -serverinstance 'Glacier' -database 'CodeTest' -query "Select application FROM servers"


foreach ($App in $Apps)
{
$application = $App.application

Add-DbaRegServerGroup -SqlInstance Glacier -Name $application

#Get a list of all the servers based by application

$cmsservers = invoke-sqlcmd -serverinstance 'Glacier' -database 'CodeTest' -query "SELECT SERVERNAME FROM SERVERS WHERE application = '$application'"

foreach ($server in $cmsservers)
{
 $srv = $server.SERVERNAME

 Add-DbaRegServer -SqlInstance Glacier -ServerName $srv -Group $application

}

}

