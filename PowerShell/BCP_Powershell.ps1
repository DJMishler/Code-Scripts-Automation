Set-ExecutionPolicy RemoteSigned

Import-Module SQLPS -DisableNameChecking

$Databases = Invoke-Sqlcmd -Query "Select name from sys.databases where database_id > 4;" -ServerInstance "DMCOMP"

foreach ($Database in $Databases)
{
 $MyDatabase = $Database.name
$Query = Invoke-Sqlcmd -Query "Select
'BCP [' + DB_NAME() + '].[' + SCH.name + '].[' + OBJ.name + '] out `"\\FTLPELTFSCL01\ELTDataFile\ELTArchiveArea\FTLPELTSQLCL01\BCPs\' + DB_NAME() + '\DAT\'  + SCH.name + '.' + OBJ.name + '.dat`" -c -t `"~|~`" -r `"*|*`" -S FTLPELTSQLCL01\BIELT  -T -o `"\\FTLPELTFSCL01\ELTDataFile\ELTArchiveArea\FTLPELTSQLCL01\BCPs\' + DB_NAME() + '\OUT\' + SCH.name + '.' + OBJ.name + '.txt`" -w' AS BCP_Statement
FROM sys.objects OBJ
JOIN sys.schemas SCH ON OBJ.schema_id = SCH.schema_id
WHERE type = 'U'
AND OBJ.name <> 'sysdiagrams'
ORDER BY SCH.name, OBJ.name" -ServerInstance "DMCOMP" -Database $MyDatabase

$Query.BCP_Statement | Out-File C:\CopyFromProd.$MyDatabase.bat

}