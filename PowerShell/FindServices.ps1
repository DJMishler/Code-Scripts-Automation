Import-Module SQLPS -DisableNameChecking

#Gets stopped services for I3
$Services = Get-Service -computer FTLPI3APP03 | ? {$_.displayname -like '*Precise*' -and $_.status -eq 'Stopped'}
$Dest = "FTLDDBASQL01"

Invoke-Sqlcmd -ServerInstance $Dest -Database CTAdmin -Query "Truncate Table StoppedI3Services"

ForEach($Service IN $Services)
{
    $ServiceName = $Service.DisplayName

    

    $Query = "
    Insert INTO StoppedI3Services (ServiceStopped) Values ('$ServiceName')
    GO"

    Invoke-Sqlcmd -ServerInstance $Dest -Database CTAdmin -Query $Query

}