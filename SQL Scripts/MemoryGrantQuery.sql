--Shows you how many queries have been granted memory and how many queries are waiting to receive memory (grantee_count, waiter_count)
--resource_semaphore_id of 1 means the query is less than 5MB
SELECT * FROM sys.dm_exec_query_resource_semaphores
order by resource_semaphore_id

--Shows you the queries which have request the most amount of memory
Select * from sys.dm_exec_query_memory_grants
Order By requested_memory_kb desc

--You can get the sql text based on the sql_handle from the previous DMV
SELECT * FROM sys.dm_exec_sql_text(0x02000000CB2A3C1C3CA37B615586DFE6C8E5B2EE9B4046140000000000000000000000000000000000000000)

