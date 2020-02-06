--This query shows the curently running query & excution plan

Select sqltext.TEXT,
req.session_id,
req.status,
req.command,
req.cpu_time,
req.total_elapsed_time, query_plan
From sys.dm_exec_requests req With (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(sql_handle) as sqltext
CROSS APPLY sys.dm_exec_query_plan(req.plan_handle) as QueryPlan
