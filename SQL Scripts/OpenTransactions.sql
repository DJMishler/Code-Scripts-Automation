--Checks for all Open Transactions on the Server

DECLARE @SQLScript NVARCHAR(MAX)
SELECT @SQLScript = ISNULL(@SQLScript,'') + 'DBCC OPENTRAN('+ Name +');'
FROM sys.databases
EXEC (@SQLScript)