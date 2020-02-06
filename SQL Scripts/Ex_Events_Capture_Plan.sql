CREATE EVENT SESSION [QueryPlan] ON SERVER 
ADD EVENT sqlserver.query_post_execution_showplan(
    ACTION(sqlserver.plan_handle)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'Compass') AND [sqlserver].[equal_i_sql_unicode_string]([object_name],N'p_ANX_Dashboard_GetCreditApp')))
ADD TARGET package0.ring_buffer
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO
