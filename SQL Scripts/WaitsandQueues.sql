Select
	Owt.session_id,
	Owt.exec_context_id,
	Owt.wait_duration_ms,
	Owt.wait_type,
	Owt.blocking_session_id,
	Owt.resource_description,
	Es.program_name,
	Est.text,
	Er.[database_id],
	DB_NAME(er.database_id) [Database],
	Eqp.query_plan,
	Es.cpu_time,
	Es.memory_usage
From sys.dm_os_waiting_tasks owt
Inner Join sys.dm_exec_sessions es ON
	Owt.session_id = es.session_id
Inner Join sys.dm_exec_requests er ON
	Es.session_id = er.session_id
Outer Apply sys.dm_exec_sql_text (er.sql_handle) est
Outer Apply sys.dm_exec_query_plan (er.plan_handle) eqp
--you use to be able to filter out background processes over 50, but you can't do that anymore.
Where es.is_user_process = 1
Order by wait_duration_ms desc


--You can use the following to see what else is going on on the server
Select * from sysprocesses

