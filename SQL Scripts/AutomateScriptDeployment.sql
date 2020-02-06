USE master 
GO 
DECLARE @ScriptPath nvarchar(200) = 'D:\Build',
@Test bit = 1,
@ServerName sysname = 'NDDSTGDB01',
@db sysname = 'NDD_ADP_RAW' 

exec sp__RunScripts @path = @ScriptPath, @debug = @Test,@database = @db,@server = @ServerName 
GO  