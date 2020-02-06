USE [CTAdmin]
GO

/****** Object:  StoredProcedure [dbo].[usp_dba_rebuild_indexes_all_dbs]    Script Date: 4/7/2014 1:55:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[usp_dba_rebuild_indexes_all_dbs]    
 (  @OnlineOperation tinyint  = 1 )    
     
AS    
    
DECLARE @counter INT    
DECLARE @maxdbid INT    
DECLARE @RecoveryModel VARCHAR(64)    
DECLARE @varDBName VARCHAR(256)    
DECLARE @sqlStmt VARCHAR(256)    
    
SELECT IDENTITY(int, 1,1) AS dbid, name,     
   cast(databasepropertyex(name,'RECOVERY')as varchar(30))as 'RECOVERY'     
INTO #tblDBs    
FROM sys.databases     
WHERE database_id > 4  and name not in ('ReportServer', 'ReportServerTempDB')
and state_desc = 'ONLINE'    
and source_database_id IS NULL --ignore snapshots    
    
SELECT @maxdbid = max(dbid)     
FROM #tblDBs    
    
SET @counter = 1    
    
WHILE (@counter <= @maxdbid)    
BEGIN    
   SELECT @varDBName = name, @RecoveryModel = RECOVERY    
   FROM #tblDBs    
   WHERE dbid = @counter    
            
  SELECT 'Reindexing Database: ' + @varDBName    
    
  EXEC [usp_dba_rebuild_indexes_by_db] @DBName = @varDBName, @OnLine = @OnlineOperation, @MaxDOP = 0
     
    
  SET @counter = @counter + 1    
       
END    

GO


