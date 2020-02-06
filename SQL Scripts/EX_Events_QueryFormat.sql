/* I use this as a template to pull the info I need for Extended Events.  It's obviously customizable to whatever event you want to run
and what data you want to view on.

*/

If OBJECT_ID('tempdb..#Session_Table') IS NOT NULL
	DROP TABLE #Session_Table
Go

WITH xEvents
AS
--This allows you to read the results of the Extended Events Session from File You created.
(Select object_name as EventName,
Cast (event_data as XML) AS xEventData
FROM sys.fn_xe_file_target_read_file('D:\Deployments\SP_batchcomp*.xel', NULL, NULL, NULL))

--This pulls the EventName(Extended Event Used), and Event_Data(holds the values) columns which can be split up by individual columns, like the example below, Duration and Object_id

Select EventName,
xEventData.value('(/event/data[@name="duration"]/value)[1]', 'bigint') Duration,
--Object_name(xEventData.value('(/event/data[@name=''object_id'']/value)[1]', 'bigint')) [Object_Name]
xEventData.value('(/event/action[@name="database_name"]/value)[1]', 'varchar(100)') DatabaseName,
xEventData.value('(/event/data[@name="object_name"]/value)[1]', 'varchar(100)') ObjectName,
xEventData.value('(/event/action[@name="session_id"]/value)[1]', 'int') SessionID,
xEventData.value('(/event/action[@name="username"]/value)[1]', 'varchar(100)') UserName,
xEventData.value('(/event/action[@name="query_plan_hash"]/value)[1]', 'varchar(100)') QueryPlanHash,
xEventData.value('(/event/action[@name="plan_handle"]/value)[1]', 'varchar(100)') PlanHandle,
xEventData.value('(/event/data[@name="logical_reads"]/value)[1]', 'bigint') LogicalReads,
xEventData.value('(/event/data[@name="physical_reads"]/value)[1]', 'bigint') PhysicalReads

INTO #Session_Table
From xEvents

--I sent the results into a temp table where I can go ahead and filter out the results just like a standard SQL query.
Select EventName, DatabaseName, Duration, ObjectName, SessionID, UserName, QueryPlanHash, PlanHandle, LogicalReads, PhysicalReads
From #Session_Table
--Where [ObjectName] = 'uspGetEmployeeManagers'
Go

Drop Table #Session_Table
Go