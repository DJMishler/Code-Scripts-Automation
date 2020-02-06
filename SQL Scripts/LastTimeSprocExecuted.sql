Select OBJECT_NAME(object_id) ObjectName, database_id, type_desc, last_execution_time from sys.dm_exec_procedure_stats
where database_id = 5
and OBJECT_NAME(object_id) IN ('isp_Accounts_Extract_SAP_GetData', 'isp_Accounts_Extract_SAP_GetIDs')



