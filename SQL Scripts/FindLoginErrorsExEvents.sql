CREATE EVENT SESSION [Test] ON SERVER 
ADD EVENT sqlserver.error_reported(
    ACTION(sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.session_nt_username,sqlserver.username)),
ADD EVENT sqlserver.errorlog_written(
    ACTION(sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.session_nt_username,sqlserver.username)) 
ADD TARGET package0.event_file(SET filename=N'T:\MSSQL11.INSTA01\MSSQL\Log\Test.xel',max_file_size=(250))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


