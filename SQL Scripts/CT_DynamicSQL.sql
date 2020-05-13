Use CodeTest;
GO

-- Create a Temp Table where all the change tracking tables will be added to; the table names will be used for the itertion command

IF OBJECT_ID('TempDB..#CT_Tables') IS NOT NULL
	DROP Table #CT_Tables
GO

Create Table #CT_Tables (
ID INT Identity(1,1),
[TableName] varchar(200)
)
GO

Insert INTO #CT_Tables ([TableName])
Select Object_Name(Object_ID) TableName 
FROM sys.change_tracking_tables
GO

-- Create two variables to be used for the iteration, the @i will be used to increment the iteration, and the @table will be used to actually hold the values
Declare @i INT
Declare @table varchar(200)

Set @i = 1
Set @table = (Select [TableName] FROM #CT_Tables WHERE ID = @i)

WHILE(@table IS NOT NULL)
BEGIN
	
	--The following set of code creates the dynamic joins; I'm using another temp table to hold the primary key values of each table as it enters the loop

	IF OBJECT_ID('tempdb..#DynamicColumns') IS NOT NULL
		DROP TABLE #DynamicColumns
	

	Create Table #DynamicColumns
	(
		ID INT Identity(1,1),
		[Keys] varchar(100)
	)

-- Find all the primary key columns based on the @table (table name); we're going to use the Keys to materialize the joins

	INSERT INTO #DynamicColumns (Keys)
	SELECT COLUMN_NAME
	FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
	WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA+'.'+CONSTRAINT_NAME), 'IsPrimaryKey') = 1
	AND TABLE_NAME = @table
	ORDER BY ORDINAL_POSITION

	
	-- @lastchangetrack and @currentchangetrack are used for change tracking purposes to create the query necessary to only bring back the new changes
	declare @lastchangetrack varchar(10)
	declare @currentchangetrack varchar(10)

	Set @lastchangetrack = (Select SYS_CHANGE_VERSION FROM CDCTracking.cdc.changetracking_version WHERE TableName = @table)
	Set @currentchangetrack = (Select CHANGE_TRACKING_CURRENT_VERSION())

	-- @sql and @ins are used to pass the dynamic query when it's completed
	declare @sql varchar(500)
	declare @ins varchar(500)


	-- In this piece of code, I'm taking in the keys(columns) we passed to dynammic column table and I'm separating it by commas if there are more than one key.  The substring removes the comma after the last column.
	declare @columns varchar(250)
	SET @columns = ''
	select @columns = @columns + 'CT.' + Keys + ', ' from #DynamicColumns
	Select @columns = SUBSTRING(@columns, 0, LEN(@columns))
--Select @columns

-- This gets the Joins; it builds the dynamic sql which will be used when joining on the source table and change tracking table.  This creates the src.column = ct.column and src.column2 = ct.column2
	declare @joins varchar(250)
	SET @joins = ''
	select @joins = @joins + 'src.' + Keys +  '=CT.' + Keys + ' AND ' from #DynamicColumns
	Select @joins = SUBSTRING(@joins, 0, LEN(@joins)-2)
--Select @joins

	-- This is where we put all of it together to create the dynamic sql and then we execute the code using Exec(@ins).

	Set @sql = 'select src.*, GetDate() AS TIMESTAMP, CT.SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION, ' + @columns +
	' FROM ' + @table + ' src 
	RIGHT OUTER JOIN CHANGETABLE(CHANGES ' + @table + ', ' + @lastchangetrack + ' ) as CT 
	on ' + @joins

	SET @ins = 'IF EXISTS (Select * FROM ChangeTable(Changes ' + @table + ', ' + @lastchangetrack + ') ct)
	BEGIN

	INSERT INTO CDCTracking.cdc.' + @table + ' ' 
	+ @sql + 'WHERE CT.SYS_CHANGE_VERSION <= ' + @currentchangetrack + ' 
	Exec [dbo].[Update_ChangeTracking_Version] ' + @table + ' 

	END'
	

	Print @ins
	--Exec(@ins)

	-- This piece is what controls the iteration, increasing the @i variable by one and proceeding to next value.
	SET @table = NULL
	SET @i = @i + 1
	SELECT @table = (SELECT [TableName] FROM #CT_Tables WHERE ID = @i)
END