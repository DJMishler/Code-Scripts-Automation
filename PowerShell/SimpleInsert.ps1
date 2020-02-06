Import-Module SQLPS -DisableNameChecking

$TruncateQuery = "Truncate Table TestTable"

#Truncate Query
Invoke-Sqlcmd -Query $TruncateQuery -ServerInstance "local" -Database "TestDatabase"

$InsertStatement = "Insert INTO TestTable (ID, Message) Values (1, 'Test Message')"

Invoke-Sqlcmd -Query $InsertStatement -ServerInstance "local" -Database "TestDatabase"