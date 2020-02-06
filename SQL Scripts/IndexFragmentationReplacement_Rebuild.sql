/* The first version of this script uses Cursor to fetch and loop over all the indexes on the selected database.
The problem is that Cursors use too much memory to do what they do, so I switched it to do a While Loop for performance
issues. */

--This script will help us find all of our fragmentations and rebuild or reorganize them

--Make sure you select a database to run it in
Use AdventureWorks2012

-- Conditionally select tables and indexes from the sys.dm_db_index_physical_stats function 
-- and add them to temp table
Set NOCOUNT ON;

DECLARE @objectid int;
DECLARE @indexid int;
DECLARE @partitioncount bigint;
DECLARE @schemaname nvarchar(130); 
DECLARE @objectname nvarchar(130); 
DECLARE @indexname nvarchar(130); 
DECLARE @partitionnum bigint;
DECLARE @partitions bigint;
DECLARE @frag float;
DECLARE @command nvarchar(4000); 



Declare @NumberofRows int;
Declare @RowCount int;

Create Table #FragTable (
RowID int Identity(1, 1),
objectID int,
indexID int,
partitionnumber int,
frag int
)

--Insert record set into temp table
Insert into #FragTable (objectID, indexID, partitionnumber, frag)
Select object_id, index_id, partition_number, avg_fragmentation_in_percent
From sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED')
WHERE avg_fragmentation_in_percent > 10.0 AND index_id > 0;

Set @NumberofRows = @@ROWCOUNT
Set @RowCount = 1

While @RowCount <= @NumberofRows
Begin
	
	Select @objectid = objectID, @indexid = indexid, @partitionnum = partitionnumber, @frag = frag
	From #FragTable
	where RowID = @RowCount

	 SELECT @objectname = QUOTENAME(o.name), @schemaname = QUOTENAME(s.name)
        FROM sys.objects AS o
        JOIN sys.schemas as s ON s.schema_id = o.schema_id
        WHERE o.object_id = @objectid;
        SELECT @indexname = QUOTENAME(name)
        FROM sys.indexes
        WHERE  object_id = @objectid AND index_id = @indexid;
        SELECT @partitioncount = count (*)
        FROM sys.partitions
        WHERE object_id = @objectid AND index_id = @indexid;

-- 40 is an arbitrary decision point at which to switch between reorganizing and rebuilding.
        IF @frag < 40.0
            SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REORGANIZE';
        IF @frag >= 41.0
            SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REBUILD';
        IF @partitioncount > 1
            SET @command = @command + N' PARTITION=' + CAST(@partitionnum AS nvarchar(10));
        EXEC (@command);
        PRINT N'Executed: ' + @command;

		Set @RowCount = @RowCount + 1

    END;

--Drop Temp Table
Drop Table #FragTable;
Go

