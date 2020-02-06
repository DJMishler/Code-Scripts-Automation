
Import-Module SQLPS -DisableNameChecking

$Files = Get-ChildItem -path "C:\Content"

Foreach ($File IN $Files)
{
    $Content = Get-Content "C:\Content\$File"

$svnm = "ServerName"

Invoke-Sqlcmd -Query "$Content" -ServerInstance $svnm -Database "AdventureWorks2014"

}
