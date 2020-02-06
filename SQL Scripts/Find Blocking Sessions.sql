--Script to find the blockin header as well as the wait type.

SELECT session_id, command, blocking_session_id, wait_type, wait_time, wait_resource, t.TEXT
FROM sys.dm_exec_requests 
CROSS apply sys.dm_exec_sql_text(sql_handle) AS t
--WHERE session_id > 50 
where blocking_session_id > 0
UNION
SELECT session_id, '', '', '', '', '', t.TEXT
FROM sys.dm_exec_connections 
CROSS apply sys.dm_exec_sql_text(most_recent_sql_handle) AS t
WHERE session_id IN (SELECT blocking_session_id 
                    FROM sys.dm_exec_requests 
                    WHERE blocking_session_id > 0)


--sp_who2 active

--DBCC INPUTBUFFER(532)

--EXEC sp_helptext N'[boxes].[ausp_CustomerSalesSummary_SalesDetail_Synch]';                                                                    

--Find job name
SELECT * 
FROM msdb.dbo.sysjobs
WHERE job_id = CAST(0xF049C48A99DF64408F1234C09B8F2315 AS UNIQUEIDENTIFIER)

