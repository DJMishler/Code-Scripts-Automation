--Checks for fragmentation
--The first null is where you would place the object_id
SELECT [object_id], [index_id], [partition_number], CAST([avg_fragmentation_in_percent] AS TINYINT) AS [AvgFragPercent], [index_type_desc]          
   FROM sys.dm_db_index_physical_stats(DB_ID(), 1830006469, NULL, NULL , 'LIMITED')

--This helps you find the object_id, based on the name

--Select * from sys.objects
--where name = 'account'