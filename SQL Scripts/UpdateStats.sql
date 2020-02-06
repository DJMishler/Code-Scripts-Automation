USE Compass
GO
SELECT name AS index_name,
STATS_DATE(OBJECT_ID, index_id) AS StatsUpdated
FROM sys.indexes
WHERE OBJECT_ID = OBJECT_ID('[WebApp].[Lead_Credit_info]')
GO

--USE Compass;
--GO
--UPDATE STATISTICS [WebApp].[Lead_Credit_info]
--WITH FULLSCAN
--GO

Select count(1) from [WebApp].[Lead_Credit_info]