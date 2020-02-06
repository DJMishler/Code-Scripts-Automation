USE tempdb
GO

IF OBJECT_ID('dbo.#TraceTable', 'U') IS NOT NULL
	DROP TABLE dbo.#TraceTable;

SELECT * INTO #TraceTable
FROM ::fn_trace_gettable
('D:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Log\log_11.trc', default)
GO

Select * from #TraceTable
order by StartTime asc

--SELECT
--	 DatabaseID
--	,DatabaseName
--	,LoginName
--	,HostName
--	,ApplicationName
--	,StartTime
--	,CASE
--		WHEN EventClass = 46 THEN 'Database Created'
--		WHEN EventClass = 47 THEN 'Database Dropped'
--	ELSE 'NONE'
--	END AS EventType
--FROM tempdb.dbo.#TraceTable
--	--WHERE DatabaseName = 'AdventureWorks2017'
--	--	AND (EventClass = 46 /* Event Class 46 refers to Object:Created */
--	--		OR EventClass = 47) /* Event Class 47 refers to Object:Deleted */
--GO

--Event Class 46 and 47 (Create Database, Drop Database)
--Object Type 16964 (Database Object)