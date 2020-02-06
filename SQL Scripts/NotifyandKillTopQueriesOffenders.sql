USE [CTAdmin]
GO

/****** Object:  StoredProcedure [dbo].[usp_NotifyAndKillTopQueryOffenders]    Script Date: 4/8/2014 1:31:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Batch submitted through debugger: usp_NotifyAndKillTopQueryOffenders.sql|8|0|C:\Users\t_krishnak2\Desktop\usp_NotifyAndKillTopQueryOffenders.sql
CREATE PROCEDURE [dbo].[usp_NotifyAndKillTopQueryOffenders]       
     
/*********************************************************************************/
    
-- Created by:  Igor Santos      
-- Created on:  01/25/2011      
-- Purpose:  Identify, kill offending transactions,     
--           alert DBA team and end user running the transaction.      

/*********************************************************************************/      
        
( @Time AS int , 
  @CPU AS int , 
  @IO AS int
)
AS
BEGIN

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET NOCOUNT ON;

    DECLARE @c int;
    DECLARE @subject2 AS varchar( 200 );
    DECLARE @tableHTML AS nvarchar( max );        
        
    --Select offending transactions and store them into a temp table      
    SELECT spid , 
		 DB_NAME( s.dbid )AS dbname , 
		 cpu , 
		 physical_io , 
		 s.login_time , 
		 last_request_start_time , 
           DATEDIFF( mi , s.login_time , GETDATE( ) )AS time_logged_in , 
           DATEDIFF( mi , ss.last_request_start_time , 
           GETDATE( ) )AS last_request_duration , 
           CASE transaction_isolation_level
                      WHEN 0 THEN 'Unspecified'
				  WHEN 1 THEN 'ReadUncomitted'
				  WHEN 2 THEN 'ReadCommitted'
				  WHEN 3 THEN 'Repeatable'
				  WHEN 4 THEN 'Serializable'
				  WHEN 5 THEN 'Snapshot'
				  ELSE 'Not Available'
		  END AS transaction_isolation_level , 
		  hostname , 
		  s.program_name , 
		  loginame , 
		  lastwaittype , 
		  ss.status , 
		  LEFT( qt.text , 200 )AS sql_text 
	 INTO #TopQueryOffenders
      FROM sys.sysprocesses s 
				INNER JOIN sys.dm_exec_sessions ss ON s.spid = ss.session_id 
				CROSS APPLY sys.dm_exec_sql_text( s.sql_handle)AS qt
      WHERE	 spid > 50 
			 AND loginame NOT IN
				( 
				    SELECT LoginName FROM CTAdmin.dbo.ProductionUserList WHERE status = 1 
				 )    
			 --AND ss.status NOT IN ('sleeping')    
			 AND ss.status = 'Running'
			 AND cpu >= @cpu
			 AND physical_io >= @IO
			 AND DATEDIFF( mi , ss.last_request_start_time , GETDATE( ) ) >= @time;  
			   
			   
 --If there are more than zero offending transactions selected by the query above, the system will send an alert to the DBA Team           
	  SELECT @c = COUNT(*)        
	  FROM  #TopQueryOffenders      
        
		IF @c > 0        
        
		BEGIN        
        
			SET @subject2 = CAST(@@SERVERNAME AS VARCHAR(20)) + ': Top CPU and Time Offenders - ' + CAST(GETDATE() AS VARCHAR(29))        
			SET @tableHTML =             
			N'<H4>'+CAST(@@SERVERNAME AS VARCHAR(20))+' - Top Time and CPU Offenders</H4>'+            
			N'<H4>Thresholds:</H4>'+            
			N'<H4>CPU: '+CAST(@CPU AS VARCHAR(15))+'</H4>'+        
			N'<H4>IO: '+CAST(@IO AS VARCHAR(15))+'</H4>'+        
			N'<H4>Time (minutes): '+CAST(@Time AS VARCHAR(15))+'</H4>'+        
			N'<table border="1">' +            
			N'<tr><th>SPID</th><th>Database Name</th>' +            
			N'<th>CPU</th><th>Physical IO</th>' +            
			N'<th>Login Time</th><th>Last Request Start Time</th>'+      
			N'<th>Total Time Logged In(minutes)</th><th>Last Request Duration(minutes)</th>'+      
			N'<th>Transaction Isolation Level</th>'+      
			N'<th>Host Name</th><th>Program Name</th>' +            
			N'<th>Login Name</th><th>Last Wait Type</th><th>Query Status</th><th>SQL Text</th></tr>' +            
			CAST( (            
			SELECT        
			td = spid,       '',            
			td = dbname,       '',      
			td = cpu,       '',            
			td = physical_io,       '',            
			td = login_time,       '',          
			td = last_request_start_time,       '',            
			td = time_logged_in,       '',          
			td = last_request_duration,       '',         
			td = transaction_isolation_level,       '',       
			td = hostname,       '',            
			td = program_name,       '',            
			td = loginame,       '',      
			td = lastwaittype,       '',      
			td = status,       '',      
			td = sql_text,       ''      
			FROM #TopQueryOffenders    
			ORDER BY spid      
			FOR XML PATH('tr'), TYPE            
			) AS NVARCHAR(MAX) ) +             
			N'</table>' ;            
             
			EXEC msdb.dbo.sp_send_dbmail             
			@profile_name = 'svcacct_sqlappsprod_profile',            
			@recipients = 'itdbaoncall@citrix.com',            
			--@recipients = 'igor.santos@citrix.com',            
			@subject = @subject2,            
			@body = @tableHTML,            
			@body_format = 'HTML',            
			@importance = 'HIGH'            
      
		
			
		END            
          
        
	END 
    --Once the DBA Team has been alerted about the transaction, now the system is going to kill the offending transaction and alert the user running it      
    DECLARE @spid int;
    DECLARE @cpu2 int;
    DECLARE @IO2 int;
    DECLARE @request_duration int;
    DECLARE @loginame varchar( 30 );
    DECLARE @sql varchar( 4000 );
    DECLARE @sql_text varchar( 300 );
    DECLARE c CURSOR 
		  FOR SELECT spid , 
            cpu , 
            physical_io , 
            last_request_duration , 
            REPLACE( RTRIM( LTRIM( loginame ) ) , 'CITRITE\' , ''  )AS loginame , 
            LEFT( sql_text , 500  )AS sql_text
            FROM #TopQueryOffenders
            ORDER BY spid;
    OPEN c;
    FETCH NEXT FROM c INTO @spid , @cpu2 , @IO2 , @request_duration , @loginame , @sql_text;
    WHILE @@FETCH_STATUS = 0
    BEGIN
            SET @sql = '     
				   DECLARE @c INT      
				   DECLARE @fullname AS VARCHAR(30)      
				   DECLARE @email2 as VARCHAR(40)      
      
				   SELECT givenName,sn,cn,sAMAccountName,mail              
				   INTO #tmp      
				   FROM OPENQUERY              
				   (ADSI,''SELECT cn,mail,sAMAccountName,givenName,sn,manager FROM ''''LDAP://DC=citrite,DC=net''''      
				   WHERE sAMAccountName = ''''' + @loginame + ''''''')              
				   WHERE sAMAccountName IS NOT NULL      
				   SELECT @c=COUNT(*) FROM #tmp WHERE mail is NOT NULL      
				   SELECT @fullname=cn FROM #tmp      
				   SELECT @email2=mail FROM #tmp      
      
				   IF @c > 0      
      
					   BEGIN      
						  DECLARE @subject2 AS VARCHAR(300)      
						  DECLARE @body2 AS VARCHAR(MAX)    
      
						  SET @subject2 = CAST(@@SERVERNAME AS VARCHAR(20)) + '' ODS Mirror Administrator Alert - Your query has been terminated - '' + CAST(GETDATE() AS VARCHAR(29))        
						  SET @body2 = '' Dear ''+@fullname+'', <BR><BR>      
						  Your query (SPID #: ''''' + CAST( @spid AS varchar( 15 ) ) + ''''') has been terminated by the Administrator account on FTLPLMSQLCL02\INSTA (ODS Mirror).<BR><BR>      
						  This action took place, because your query ran above the 10 minutes time threshold or placed locks on database tables.<BR><BR>    
						  Please contact the DBA Team (#ApplicationServices-CRMDBA@citrix.com) if you continue to receive this message while running queries against FTLPLMSQLCL01.<BR><BR>      
						  Best Regards,<BR>      
						  Database and BI Operations Team    ''      
      
						  EXEC msdb.dbo.sp_send_dbmail             
						  @profile_name = ''svcacct_sqlappsprod_profile'',            
						  @recipients = @email2,    
						  --@recipients = ''igor.santos@citrix.com'',    
						  @copy_recipients = ''itdbaoncall@citrix.com'',    
						  @subject = @subject2,            
						  @body = @body2,            
						  @body_format = ''HTML'',            
						  @importance = ''HIGH''         
     
						  KILL ' + CAST( @spid AS varchar( 15 ) ) + '    
     
				     END      
      
				ELSE      
      
				    BEGIN      
						  DECLARE @subject3 AS VARCHAR(300)      
						  DECLARE @body3 AS VARCHAR(MAX)      
        
						  SET @fullname = ''' + @loginame + '''      
						  SET @subject3 = CAST(@@SERVERNAME AS VARCHAR(20)) + '' ODS Mirror Administrator Alert - Your query has been terminated - '' + CAST(GETDATE() AS VARCHAR(29))        
						  SET @body3 = '' Dear ''+@fullname+'', <BR><BR>      
						  Your query (SPID #: ''''' + CAST( @spid AS varchar( 15 )) + ''''') has been terminated by the Administrator account on FTLPLMSQLCL01 (ODS).<BR><BR>      
						  This action took place, because your query ran above the 10 minutes time threshold or placed locks on database tables.<BR><BR>    
						  Please contact the DBA Team (#ApplicationServices-CRMDBA@citrix.com) if you continue to receive this message while running queries against FTLPLMSQLCL02\INSTA (ODS Mirror).<BR><BR>      
						  Best Regards,<BR>      
						  Database and BI Operations Team    
						  ''      
						  EXEC msdb.dbo.sp_send_dbmail             
						  @profile_name = ''svcacct_sqlappsprod_profile'',            
						  @recipients = ''itdbaoncall@citrix.com'',            
						  --@recipients = ''igor.santos@citrix.com'',            
						  @subject = @subject3,            
						  @body = @body3,            
						  @body_format = ''HTML'',            
						  @importance = ''HIGH''         
     
						  KILL ' + CAST( @spid AS varchar( 15 ) ) + '    
				    END';
            EXECUTE ( @sql );

            FETCH NEXT FROM c INTO @spid , @cpu2 , @IO2 , @request_duration , @loginame , @sql_text;

      END;
    CLOSE c;
    DEALLOCATE c;
  
     


GO


