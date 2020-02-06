# This piece of code here allows you to invoke Admin Rights to this script; may or may not be needed but on my local
# machine, it was necessary

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

$Servers = "DMCOMP"

Foreach($Server IN $Servers)
{
    

# I wanted to check all the SQL Server Services, I didn't want to hard code it.  Wanted to find all the services
# that were on a Running State
$ServiceNameLike = "SQL Server *"
$Services = get-service -ComputerName $Server | Where-Object {$_.DisplayName -like $ServiceNameLike -and $_.Status -eq "Running"}

# This part is easy to read, nough said!
Foreach ($Service In $Services)
{
   
   #Get-Service -ComputerName $Server $Service.DisplayName | Stop-Service -Force
   (Get-Service -ComputerName $Server -DisplayName $Service.DisplayName).Stop()
   

}

}
