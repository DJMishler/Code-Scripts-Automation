USE [CTAdmin]
GO

/****** Object:  StoredProcedure [dbo].[usp_dba_detectlockedspids]    Script Date: 4/4/2014 4:14:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[usp_dba_detectlockedspids]  
  
(  
 @TimeThreshold AS INT --in seconds  
)  
  
AS  
  
if is_member('sysadmin') = 0   
begin  
  print 'Must be a member of the sysadmin group in order to run this procedure'  
  return  
end  
  
BEGIN  
  
SET NOCOUNT ON   
  
DECLARE @c AS INT          
DECLARE @subject2 AS VARCHAR(200)            
DECLARE @tableHTML AS NVARCHAR(MAX)    
DECLARE @s AS INT  
  
/*  
select spid, request_id, ecid, blocked, waittype, dbid  
into #probclients  
from master.dbo.sysprocesses   
where spid > 50 and (blocked <> 0 or waittype <> 0x0000)  
  
insert #probclients   
select distinct blocked, 0, 0, 0, 0x0000, 0  
from #probclients  
where blocked not in (select spid from #probclients) and blocked != 0  
  
select spid  
into #headofblock  
from #probclients  
where blocked = 0 and spid in (select blocked from #probclients where spid != 0)  
*/  
  
/*  
drop table #probclients  
drop table #headofblock  
*/  
  
select spid, request_id, ecid, blocked, waittype, waittime/1000 as waittime, lastwaittype, p.dbid,   
 last_batch, status, qt.text, loginame, hostname, DATEDIFF(ss, last_batch, GETDATE()) as idletime  
into #probclients  
from master.dbo.sysprocesses as p  
 cross apply sys.dm_exec_sql_text(sql_handle) as qt  
where spid > 50 and (blocked <> 0 or waittype <> 0x0000)  
  
insert #probclients   
select distinct blocked, 0, 0, 0, 0x0000, waittime, lastwaittype, 0, last_batch,   
 status, text, loginame, hostname, idletime  
from #probclients  
where blocked not in (select spid from #probclients) and blocked != 0  
  
select distinct spid, last_batch, status, text, waittype, waittime, idletime, lastwaittype,  
 loginame, hostname  
into #headofblock  
from #probclients  
where blocked = 0 and spid in (select blocked from #probclients where spid != 0)  
  
select   
 spid, status, blocked, open_tran, waitresource, waittype,   
 waittime/1000 as waittime, cmd, lastwaittype, cpu, physical_io,  
 memusage, last_batch=convert(varchar(26), last_batch,121),  
 login_time=convert(varchar(26), login_time,121),net_address,  
 net_library, p.dbid, ecid, kpid, hostname, hostprocess,  
 loginame, program_name, nt_domain, nt_username, uid, sid,  
 sql_handle, stmt_start, stmt_end, request_id, qt.text,  
 DATEDIFF(ss,last_batch,GETDATE()) AS elapsedtime,  
 DB_NAME(p.dbid) AS databasename  
into #blockedspids  
from master.dbo.sysprocesses as p  
 cross apply sys.dm_exec_sql_text(sql_handle) as qt  
 where  
  spid > 50 and   
  (  
   blocked <> 0   
   --or waittype <> 0x0000  
  )  
  and DATEDIFF(ss,last_batch,GETDATE()) > @TimeThreshold  
ORDER BY p.SPID  
  
SELECT @c = COUNT(*) FROM #blockedspids  
  
IF @c > 0  
  
BEGIN  
  
SET @subject2 = CAST(@@SERVERNAME AS VARCHAR(20)) +': Blocking Alert - ' + CAST(GETDATE() AS VARCHAR(29))            
SET @tableHTML =             
N'<H4>'+CAST(@@SERVERNAME AS VARCHAR(20))+' - SPIDS blocked alert: </H4>'+            
  
N'These are the SPIDs head of the blocking chains:' +  
N'<br>' +  
N'<table border="1">' +            
N'<tr><th>SPID</th><th>Last Wait Type</th><th>Status</th><th>Wait Type</th>' +  
N'<th>Wait Time (seconds)</th><th>Idle Time (seconds)</th><th>Last Batch</th>' +  
N'<th>Login</th><th>Host Name</th><th>SQL Text</th>' +  
CAST( (            
SELECT          
 td = spid, '',  
 td = status, '',  
 td = lastwaittype, '',  
 td = waittype, '',  
 td = waittime, '',  
 td = idletime, '',  
 td = last_batch, '',  
 td = loginame, '',  
 td = hostname, '',  
 td = text, ''  
FROM     
#headofblock  
      FOR XML PATH('tr'), TYPE            
) AS NVARCHAR(MAX) ) +             
N'</table>'  +  
N'<br><br>' +  
  
N'These are the SPIDS blocked for over '+CAST(@TimeThreshold AS VARCHAR(5))+' seconds:'+            
N'<br>' +  
N'<table border="1">' +            
N'<tr><th>SPID</th><th>Status</th><th>Database Name</th>' +  
N'<th>Blocked by SPID</th><th>Wait Resource</th><th>Wait Type</th><th>Wait Time (seconds)</th>' +  
N'<th>Last Batch</th><th>Login Time</th><th>Elapsed Time (seconds)</th><th>Host Name</th>' +  
N'<th>Login</th><th>Program Name</th><th>SQL Text</th>' +  
CAST( (            
SELECT          
 td = spid, '',  
 td = status, '',  
 td = databasename, '',  
 td = blocked, '',  
 td = waitresource, '',  
 td = waittype, '',  
 td = waittime, '',  
 td = last_batch, '',  
 td = login_time, '',  
 td = elapsedtime, '',  
 td = hostname, '',  
 td = loginame, '',  
 td = program_name, '',  
 td = text, ''  
FROM     
#blockedspids  
      FOR XML PATH('tr'), TYPE            
) AS NVARCHAR(MAX) ) +             
N'</table>' ;            
  
EXEC msdb.dbo.sp_send_dbmail             
 @profile_name = 'svcacct_sqlappsprod_profile',            
 --@recipients = 'igor.santos@citrix.com',            
 @recipients = 'itdbaoncall@citrix.com',            
 @subject = @subject2,            
 @body = @tableHTML,            
 @body_format = 'HTML',            
 @importance = 'HIGH'    
  
END  
  
END
GO


