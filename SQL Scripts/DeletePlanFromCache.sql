--This finds all the plans cached in the buffer pool

select plan_handle, qs.sql_handle, creation_time, last_execution_time, execution_count, qt.text, qp.query_plan
FROM 
   sys.dm_exec_query_stats qs
   CROSS APPLY sys.dm_exec_sql_text (qs.[sql_handle]) AS qt
   CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp

--The following will remove the plan in cache by passing it the plan handle hash id

DBCC FREEPROCCACHE (0x05000A00DA4F0802F058E29FA801000001000000000000000000000000000000000000000000000000000000)