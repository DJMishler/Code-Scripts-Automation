-- Loops through all the database names and places them into a variable to pass to stored proc
DECLARE @dbname2 varchar(50)
 DECLARE C CURSOR FOR SELECT name FROM master..sysdatabases WHERE name NOT IN ('master','model','msdb','tempdb')
 OPEN C
 FETCH NEXT FROM C INTO @dbname2
 WHILE @@FETCH_STATUS = 0
 BEGIN
  --PRINT 'EXECUTE YOUR PROCEDURE HERE WITH THE db NAME ' + @dbname
  Exec [usp_GenerateRestoreScripts] @dbname2


  FETCH NEXT FROM C INTO @dbname2
 END
 CLOSE C
 DEALLOCATE C


--Create replacement script for the one above
Set NOCOUNT ON

Create Table #DatabaseNames (
RowID int Identity(1, 1)
,[DBName] nvarchar(100)
)

--Create the variables for the While Loop count

Declare @NumberofRecords int
Declare @RowCount int
Declare @DBname2 nvarchar(100)

--Insert the result set we want to loop into the temp table

Insert Into #DatabaseNames (DBName)
Select name from sys.databases
Where name NOT IN ('master', 'msdb', 'model', 'tempdb')

-- Get the number of records
Set @NumberofRecords = @@ROWCOUNT
Set @RowCount = 1

--Loop Through the record set
While @RowCount <= @NumberofRecords
Begin

	Set @dbname2 = (Select [dbname] from #DatabaseNames where RowID = @RowCount)
	Exec [usp_GenerateRestoreScripts] @dbname2

	Set @RowCount = @RowCount +1
End


--Drop temp table
Drop Table #DatabaseNames

