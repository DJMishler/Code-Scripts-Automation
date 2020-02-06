USE [msdb]
GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: SQL Could Not Allocate Additional Space (1105)', 
		@message_id=1105, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: SQL Could Not Allocate Additional Space (1105)', @operator_name=N'DBATeam', @notification_method = 1

GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Insufficient memory (17803)', 
		@message_id=17803, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Insufficient memory (17803)', @operator_name=N'DBATeam', @notification_method = 1

GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Full Database Log', 
		@message_id=9002, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=900, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Full Database Log', @operator_name=N'DBATeam', @notification_method = 1


GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Sev. 19 Errors', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Sev. 19 Errors', @operator_name=N'DBATeam', @notification_method = 1

GO


EXEC msdb.dbo.sp_add_alert @name=N'Alert: Sev. 20 Errors', 
		@message_id=0, 
		@severity=20, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Sev. 20 Errors', @operator_name=N'DBATeam', @notification_method = 1
GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Sev. 21 Errors', 
		@message_id=0, 
		@severity=21, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Sev. 21 Errors', @operator_name=N'DBATeam', @notification_method = 1

GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Sev. 22 Errors', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Sev. 22 Errors', @operator_name=N'DBATeam', @notification_method = 1

GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Sev. 23 Errors', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 

		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Sev. 23 Errors', @operator_name=N'DBATeam', @notification_method = 1

GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Sev. 24 Errors', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Sev. 24 Errors', @operator_name=N'DBATeam', @notification_method = 1

GO

EXEC msdb.dbo.sp_add_alert @name=N'Alert: Sev. 25 Errors', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=5, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name= N'Alert: Sev. 25 Errors', @operator_name=N'DBATeam', @notification_method = 1;

GO
