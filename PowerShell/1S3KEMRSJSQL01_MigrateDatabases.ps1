#This PowerShell script migrates SQL instance logins,sp_configure values,SQL Agent operators,jobs 
#and linked servers from a source instance to a destination instance.

param(
$Source,
$Destination,
$SharePath
)

$Source= "1S3KEMRSJSQL01"
$Destination="COEMRSJDB01P" 
$SharePath="\\sanfl10\sql_bkup_temp$\1S3KEMRSJSQL01"
$LocalPath="C:\TEMP\ServerMigration"

#Export all logins from a source SQL instance to a file. 
#Write-Host "Exporting Logins...." + " to " + $Destination + ' ...' -ForegroundColor Blue
#Measure-Command{Export-DBaLogin -SqlInstance $Source -FilePath $LocalPath + '.\ServerLogins.sql' | Out-Default} 

#Copy instance-level permissions from one SQL server to another 
Write-Host "Copying sp_configure values to" $Destination '...' -ForegroundColor Magenta
Measure-Command{Copy-DbaSpConfigure -Source $Source -Destination $Destination | Out-Default} 

#Copy linked servers from one SQL instance to another
Write-Host "Copying linked servers to"  $Destination + '...' -ForegroundColor Blue
Measure-Command{Copy-DbaLinkedServer -Source $Source -Destination $Destination | Out-Default} 

#Copy database mail settings
Write-Host "Copying database mail configuration to" + $Destination '...' -ForegroundColor Cyan
Copy-DbaDBMail -Source $Source -Destination $Destination

#Copy databases to the new instance
Write-Host "Copying user databases to" $Destination '...' -ForegroundColor Green 
Measure-Command{Copy-DbaDatabase -Source $Source -Destination $Destination -SharedPath $SharePath -AllDatabases -BackupRestore -WithReplace | Out-Default} 

#Copy SQL Agent jobs from one SQL server to another 
Write-Host "Copying SQL Agent jobs to" $Destination '...' -ForegroundColor White 
Measure-Command{Copy-DbaAgentJob -Source $Source -Destination $Destination | Out-Default}
