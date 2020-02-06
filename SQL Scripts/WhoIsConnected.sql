

select cs.client_net_address, ss.program_name, ss.host_name, ss.login_name, count(ss.session_id) SessionCount
from sys.dm_exec_sessions ss
JOIN sys.dm_exec_connections cs
ON ss.session_id = cs.session_id
Group by cs.client_net_address, ss.program_name, ss.host_name, ss.login_name
order by SessionCount desc

