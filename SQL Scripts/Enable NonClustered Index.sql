--Make sure you change the table name here

use testdb;
go



Set NOCOUNT ON;

--Create Temp Table
Create Table #EnableIndexes
(
	RowID int identity(1,1),
	IndexName nvarchar(100),
	SchemaTable nvarchar(250)
)

Declare @NumberofRows int;
Declare @RowCount int;
Declare @CurrentIndex nvarchar(100);
Declare @SchemaTableName nvarchar(250);
Declare @Command nvarchar(150);

--Insert the record set into the temp table
Insert INTO #EnableIndexes (IndexName, SchemaTable)
select i.name, COALESCE(s.name,'')+ '.'+   COALESCE(object_name(t.object_id), '') 
from sys.indexes i 
left join sys.tables t on i.object_id = t.object_id 
left join sys.schemas s on t.schema_id = s.schema_id
where i.is_disabled = 1 
and t.type_desc = 'USER_TABLE'
and t.is_ms_shipped = 0

Set @NumberofRows = @@ROWCOUNT;
Set @RowCount = 1

--Start the loop
While @RowCount <= @NumberofRows
Begin
	Select @CurrentIndex = IndexName, @SchemaTableName = SchemaTable 
	from #EnableIndexes where RowID = @RowCount
	 
	 Set @Command = 'Alter Index ' + @CurrentIndex + ' ON ' + @SchemaTableName + ' Rebuild';
	 --Print @Command

	 exec(@Command);
	

	Set @Rowcount = @Rowcount + 1
End

--Drop Table
Drop Table #EnableIndexes