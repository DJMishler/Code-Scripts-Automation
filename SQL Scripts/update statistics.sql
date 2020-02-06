--USE Banner
--GO
--SELECT name AS index_name,
--STATS_DATE(OBJECT_ID, index_id) AS StatsUpdated
--FROM sys.indexes
--WHERE OBJECT_ID = OBJECT_ID('dbo.as_nsu_sfrstcr')
--GO


UPDATE STATISTICS dbo.[user]
WITH FULLSCAN
GO