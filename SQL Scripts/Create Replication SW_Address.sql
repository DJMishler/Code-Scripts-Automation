-- Enabling the replication database
use master
exec sp_replicationdboption @dbname = N'VantiveData', @optname = N'publish', @value = N'true'
GO

exec [VantiveData].sys.sp_addlogreader_agent @job_login = null, @job_password = null, @publisher_security_mode = 1
GO
-- Adding the transactional publication
use [VantiveData]
exec sp_addpublication @publication = N'VantiveData__SW_ADDRESS', @description = N'Transactional publication of database ''VantiveData'' from Publisher ''FTLPSQLCL11''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'VantiveData__SW_ADDRESS', @frequency_type = 4, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 8, @frequency_subday_interval = 1, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'CITRITE\svcacct_sqlapps15'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'CITRITE\svcacct_sqlbackup_pr'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'NT SERVICE\SQLSERVERAGENT'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'NT SERVICE\MSSQLSERVER'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'Ronaldinho'
GO
exec sp_grant_publication_access @publication = N'VantiveData__SW_ADDRESS', @login = N'distributor_admin'
GO

-- Adding the transactional articles
use [VantiveData]
exec sp_addarticle @publication = N'VantiveData__SW_ADDRESS', @article = N'SW_ADDRESS', @source_owner = N'dbo', @source_object = N'SW_ADDRESS', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000000080F3, @identityrangemanagementoption = N'none', @destination_table = N'SW_ADDRESS', @destination_owner = N'dbo', @status = 0, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboSW_ADDRESS]', @del_cmd = N'CALL [sp_MSdel_dboSW_ADDRESS]', @upd_cmd = N'MCALL [sp_MSupd_dboSW_ADDRESS]'
GO

-- Adding the transactional subscriptions
use [VantiveData]
exec sp_addsubscription @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPLMSQLCL01', @destination_db = N'ReplicaCRMDB', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPLMSQLCL01', @subscriber_db = N'ReplicaCRMDB', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO
use [VantiveData]
exec sp_addsubscription @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaCRMDB', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPODSSQLCL01', @subscriber_db = N'ReplicaCRMDB', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO
use [VantiveData]
exec sp_addsubscription @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPSQLCL07', @destination_db = N'ReplVantiveSFDC', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPSQLCL07', @subscriber_db = N'ReplVantiveSFDC', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

