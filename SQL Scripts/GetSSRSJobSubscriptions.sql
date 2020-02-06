--This allows you to see the SSRS subscription jobs.  You can get the job name and execute it.


SELECT
sj.[name] AS [Job Name],
c.[Name] AS [Report Name],
c.[Path],
su.Description,
su.EventType,
su.LastStatus,
su.LastRunTime
FROM msdb..sysjobs AS sj INNER JOIN ReportServer..ReportSchedule AS rs
ON sj.[name] = CAST(rs.ScheduleID AS NVARCHAR(128)) INNER JOIN
ReportServer..Subscriptions AS su
ON rs.SubscriptionID = su.SubscriptionID INNER JOIN
ReportServer..[Catalog] c
ON su.Report_OID = c.ItemID
order by LastRunTime desc

--Use msdb
--Go
--Exec sp_start_job @job_name = '61529605-1FA2-4DBE-AD0B-71198F89F1F7'
--Go
