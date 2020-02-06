SELECT DB_NAME(database_id) AS [DB Name], name AS [Logical Name], physical_name AS [Physical Name] 
FROM sys.master_files AS mf