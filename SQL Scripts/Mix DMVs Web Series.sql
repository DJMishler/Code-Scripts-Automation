-- Session 6 - Demo 2
-- Dynamic management Views - A few query examples
USE AdventureWorks2012;
GO

-- the following DMV based query shows the fragmentation levels within the databsae. 
-- The more fragemented an index is, the slower it performs.
-- The DMV referenced in this query is: dm_db_index_physical_stats
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE WITH OVERRIDE
GO
DECLARE	@DefaultFillFactor INT
DECLARE	@Fillfactor TABLE
	(
	 Name VARCHAR(100)
	,Minimum INT
	,Maximum INT
	,config_value INT
	,run_value INT
	)
INSERT	INTO @Fillfactor
		EXEC sp_configure 'fill factor (%)'     
SELECT	@DefaultFillFactor = CASE WHEN run_value = 0 THEN 100
								  ELSE run_value
							 END
FROM	@Fillfactor 


SELECT	DB_NAME() AS DBname
	   ,QUOTENAME(s.name) AS CchemaName
	   ,QUOTENAME(o.name) AS TableName
	   ,i.name AS IndexName
	   ,stats.Index_type_desc AS IndexType
	   ,stats.page_count AS [PageCount]
	   ,stats.partition_number AS PartitionNumber
	   ,CASE WHEN i.fill_factor > 0 THEN i.fill_factor
			 ELSE @DefaultFillFactor
		END AS [Fill Factor]
	   ,stats.avg_page_space_used_in_percent
	   ,CASE WHEN stats.index_level = 0 THEN 'Leaf Level'
			 ELSE 'Nonleaf Level'
		END AS IndexLevel
FROM	sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'DETAILED')
		AS stats
	   ,sys.objects AS o
	   ,sys.schemas AS s
	   ,sys.indexes AS i
WHERE	o.OBJECT_ID = stats.OBJECT_ID
		AND s.schema_id = o.schema_id
		AND i.OBJECT_ID = stats.OBJECT_ID
		AND i.index_id = stats.index_id
		AND stats.avg_page_space_used_in_percent <= 85
		AND stats.page_count >= 10
		AND stats.index_id > 0
ORDER BY stats.avg_page_space_used_in_percent ASC
	   ,stats.page_count DESC
  

-- this DMV based query identifies the top 5 queries ranked by average CPU time
--the DMVs referenced in this query is: dm_exec_query_stats and dm_exec_sql_text
SELECT TOP 5 query_stats.query_hash AS "Query Hash", 
    SUM(query_stats.total_worker_time) / SUM(query_stats.execution_count) AS "Avg CPU Time",
    MIN(query_stats.statement_text) AS "Statement Text"
FROM 
    (SELECT QS.*, 
    SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,
    ((CASE statement_end_offset 
        WHEN -1 THEN DATALENGTH(ST.text)
        ELSE QS.statement_end_offset END 
            - QS.statement_start_offset)/2) + 1) AS statement_text
     FROM sys.dm_exec_query_stats AS QS
     CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) as ST) as query_stats
GROUP BY query_stats.query_hash
ORDER BY 2 DESC;
GO


-- This DMV based query returns the ratio of time waiting for the CPU to be available for processing vs: waiting for DISK or memory IO to occur.
---- The DMV referenced is this query is: dm_os_waits_stats.


Select signal_wait_time_ms=sum(signal_wait_time_ms)

          ,'%signal (cpu) waits' = cast(100.0 * sum(signal_wait_time_ms) / sum (wait_time_ms) as numeric(20,2))

          ,resource_wait_time_ms=sum(wait_time_ms - signal_wait_time_ms)

          ,'%resource waits'= cast(100.0 * sum(wait_time_ms - signal_wait_time_ms) / sum (wait_time_ms) as numeric(20,2))

From sys.dm_os_wait_stats



-- the following query against DMVs lists indexes and how often they have been used since the last SQL Server restart.
-- The DMV referenced in this query is: dm_db_index_usage_stats

SELECT  o.name ,
        indexname = i.name ,
        i.index_id ,
        reads = user_seeks + user_scans + user_lookups ,
        writes = user_updates ,
        rows = ( SELECT SUM(p.rows)
                 FROM   sys.partitions p
                 WHERE  p.index_id = s.index_id
                        AND s.object_id = p.object_id
               ) ,
        CASE WHEN s.user_updates < 1 THEN 100
             ELSE 1.00 * ( s.user_seeks + s.user_scans + s.user_lookups )
                  / s.user_updates
        END AS reads_per_write ,
        'DROP INDEX ' + QUOTENAME(i.name) + ' ON ' + QUOTENAME(c.name) + '.'
        + QUOTENAME(OBJECT_NAME(s.object_id)) AS 'drop statement'
FROM    sys.dm_db_index_usage_stats s
        INNER JOIN sys.indexes i ON i.index_id = s.index_id
                                    AND s.object_id = i.object_id
        INNER JOIN sys.objects o ON s.object_id = o.object_id
        INNER JOIN sys.schemas c ON o.schema_id = c.schema_id
WHERE   OBJECTPROPERTY(s.object_id, 'IsUserTable') = 1
        AND s.database_id = DB_ID()
        AND i.type_desc = 'nonclustered'
        AND i.is_primary_key = 0
        AND i.is_unique_constraint = 0
        --AND ( SELECT    SUM(p.rows)
        --      FROM      sys.partitions p
        --      WHERE     p.index_id = s.index_id
        --                AND s.object_id = p.object_id
        --    ) > 10000
ORDER BY reads
