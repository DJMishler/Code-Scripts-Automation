Select * from sys.dm_os_ring_buffers
where timestamp = 1495956679

Select * from sys.dm_os_sys_info

SELECT  *  FROM sys.dm_os_performance_counters WHERE object_name = 'SQLServer:General Statistics'

SELECT ring_buffer_type, timestamp, COUNT(ring_buffer_type) FROM sys.dm_os_ring_buffers 
GROUP BY ring_buffer_type, timestamp
ORDER BY timestamp DESC

select r.ring_buffer_address,  
r.ring_buffer_type,  
dateadd (ms, r.[timestamp] - sys.ms_ticks, getdate()) as record_time,  
cast(r.record as xml) record  
from sys.dm_os_ring_buffers r  
cross join sys.dm_os_sys_info sys  

order by timestamp desc



SELECT ring_buffer_type, timestamp, COUNT(ring_buffer_type) FROM sys.dm_os_ring_buffers 
where timestamp = 1495956679
GROUP BY ring_buffer_type, timestamp
ORDER BY timestamp DESC


Select * from sys.sysmessages
--where error=3617
where severity = 20
and msglangid = 1033
order by error desc