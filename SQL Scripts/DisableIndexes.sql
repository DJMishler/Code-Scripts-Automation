--Make sure you change the database name here

Use testdb;
Go

Set NOCOUNT ON;

--Create temp table to hold clustered indexes
Create Table #ClusterIndexes
(
	RowID int Identity(1,1),
	[IndexName] nvarchar(100),
	[SchemaTable] nvarchar(250)
)
;
--Create variables for the while loop
Declare @NumberofRows int;
Declare @RowCount int;
Declare @CurrentIndex nvarchar(100);
Declare @SchemaTableName nvarchar(250);
Declare @Command nvarchar(150);
Declare @Command2 nvarchar(150);

--Insert the record set into the temp table
Insert INTO #ClusterIndexes (IndexName, SchemaTable)
select i.name, COALESCE(s.name,'')+ '.'+   COALESCE(object_name(t.object_id), '') 
from sys.indexes i 
left join sys.tables t on i.object_id = t.object_id 
left join sys.schemas s on t.schema_id = s.schema_id
where i.type_desc = 'CLUSTERED' 
and t.type_desc = 'USER_TABLE'
and t.is_ms_shipped = 0

--Get number of records and set the initial count
Set @NumberofRows = @@ROWCOUNT;
Set @RowCount = 1;

--Start the loop
While @RowCount <= @NumberofRows
Begin
	Select @CurrentIndex = IndexName, @SchemaTableName = SchemaTable 
	from #ClusterIndexes where RowID = @RowCount
	 
	 Set @Command = 'Alter Index ' + @CurrentIndex + ' ON ' + @SchemaTableName + ' Disable';
	 exec(@Command);
	 Set @Command2 = 'Alter Index ' + @CurrentIndex + ' ON ' + @SchemaTableName + ' Rebuild';
	 exec(@Command2);

	Set @Rowcount = @Rowcount + 1
End

--Drop temp table
Drop table #ClusterIndexes


--This Code checks for disabled indexes
--Select * from testdb.sys.indexes
--Where is_disabled = 1