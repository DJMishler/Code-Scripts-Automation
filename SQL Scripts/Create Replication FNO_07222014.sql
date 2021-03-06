/****** Scripting replication configuration. Script Date: 7/22/2014 10:56:18 AM ******/
/****** Please Note: For security reasons, all password parameters were scripted with either NULL or an empty string. ******/

/****** Begin: Script to be run at Publisher ******/

/****** Installing the server as a Distributor. Script Date: 7/22/2014 10:56:18 AM ******/
use master
--exec sp_adddistributor @distributor = N'FTLQSQLCL12\INSTA01', @password = N''
--GO

-- Adding the agent profiles
-- Updating the agent profile defaults
--exec sp_MSupdate_agenttype_default @profile_id = 1
--GO
--exec sp_MSupdate_agenttype_default @profile_id = 2
--GO
--exec sp_MSupdate_agenttype_default @profile_id = 4
--GO
--exec sp_MSupdate_agenttype_default @profile_id = 6
--GO
--exec sp_MSupdate_agenttype_default @profile_id = 11
--GO

-- Adding the distribution databases
--use master
--exec sp_adddistributiondb @database = N'distribution', @data_folder = N'F:\MSSQL11.INSTA01\MSSQL\Data', @data_file = N'distribution.MDF', @data_file_size = 8192, @log_folder = N'E:\MSSQL11.INSTA01\MSSQL\Data', @log_file = N'distribution.LDF', @log_file_size = 1024, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @security_mode = 1
--GO

-- Adding the distribution publishers
--exec sp_adddistpublisher @publisher = N'FTLQSQLCL11', @distribution_db = N'distribution', @security_mode = 1, @working_directory = N'H:\MSSQL11.INSTA01\MSSQL\ReplData', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER'
--GO
--exec sp_adddistpublisher @publisher = N'FTLQSQLCL12\INSTA01', @distribution_db = N'distribution', @security_mode = 1, @working_directory = N'H:\MSSQL11.INSTA01\MSSQL\ReplData', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER'
--GO

--exec sp_addsubscriber @subscriber = N'FTLQLMSQL01', @type = 0, @description = N''
--GO
--exec sp_addsubscriber @subscriber = N'FTLQODSSQLCL01', @type = 0, @description = N''
--GO
--exec sp_addsubscriber @subscriber = N'FTLQODSSQLCL02\INSTA', @type = 0, @description = N''
--GO
--exec sp_addsubscriber @subscriber = N'FTLQSQL07', @type = 0, @description = N''
--GO


/****** End: Script to be run at Publisher ******/


-- Enabling the replication database
use master
exec sp_replicationdboption @dbname = N'FNOShell', @optname = N'publish', @value = N'true'
GO

exec [FNOShell].sys.sp_addlogreader_agent @job_login = null, @job_password = null, @publisher_security_mode = 1
GO
exec [FNOShell].sys.sp_addqreader_agent @job_login = null, @job_password = null, @frompublisher = 1
GO
-- Adding the transactional publication
use [FNOShell]
exec sp_addpublication @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @description = N'Transactional publication of database ''FNOShell'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [FNOShell]
exec sp_addarticle @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @article = N'AUDIT_ITEMS', @source_owner = N'dbo', @source_object = N'AUDIT_ITEMS', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'AUDIT_ITEMS', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAUDIT_ITEMS]', @del_cmd = N'CALL [sp_MSdel_dboAUDIT_ITEMS]', @upd_cmd = N'SCALL [sp_MSupd_dboAUDIT_ITEMS]', @filter_clause = N'[Name] IN (''ProductName'', ''Quantity'')'

-- Adding the article filter
exec sp_articlefilter @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @article = N'AUDIT_ITEMS', @filter_name = N'FLTR_AUDIT_ITEMS_1__86', @filter_clause = N'[Name] IN (''ProductName'', ''Quantity'')', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1

-- Adding the article synchronization object
exec sp_articleview @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @article = N'AUDIT_ITEMS', @view_name = N'SYNC_AUDIT_ITEMS_1__86', @filter_clause = N'[Name] IN (''ProductName'', ''Quantity'')', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO
use [FNOShell]
exec sp_addarticle @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @article = N'AUDIT_TRAIL', @source_owner = N'dbo', @source_object = N'AUDIT_TRAIL', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'AUDIT_TRAIL', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAUDIT_TRAIL]', @del_cmd = N'CALL [sp_MSdel_dboAUDIT_TRAIL]', @upd_cmd = N'SCALL [sp_MSupd_dboAUDIT_TRAIL]'
GO

-- Adding the transactional subscriptions
use [FNOShell]
exec sp_addsubscription @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFNOShell', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNOShell__AUDIT_ITEMS_TRAIL', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFNOShell', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO



-- Enabling the replication database
use master
exec sp_replicationdboption @dbname = N'Fnpops', @optname = N'publish', @value = N'true'
GO

exec [Fnpops].sys.sp_addlogreader_agent @job_login = null, @job_password = null, @publisher_security_mode = 1
GO
exec [Fnpops].sys.sp_addqreader_agent @job_login = null, @job_password = null, @frompublisher = 1
GO
-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @article = N'OPS_ACTIVATABLE_ITEM', @source_owner = N'dbo', @source_object = N'OPS_ACTIVATABLE_ITEM', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'OPS_ACTIVATABLE_ITEM', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboOPS_ACTIVATABLE_ITEM]', @del_cmd = N'CALL [sp_MSdel_dboOPS_ACTIVATABLE_ITEM]', @upd_cmd = N'SCALL [sp_MSupd_dboOPS_ACTIVATABLE_ITEM]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @article = N'OPS_ACTIVATION_INSTANCE', @source_owner = N'dbo', @source_object = N'OPS_ACTIVATION_INSTANCE', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'OPS_ACTIVATION_INSTANCE', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboOPS_ACTIVATION_INSTANCE]', @del_cmd = N'CALL [sp_MSdel_dboOPS_ACTIVATION_INSTANCE]', @upd_cmd = N'SCALL [sp_MSupd_dboOPS_ACTIVATION_INSTANCE]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @article = N'OPS_ENT_PARTNER_TIER', @source_owner = N'dbo', @source_object = N'OPS_ENT_PARTNER_TIER', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'OPS_ENT_PARTNER_TIER', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboOPS_ENT_PARTNER_TIER]', @del_cmd = N'CALL [sp_MSdel_dboOPS_ENT_PARTNER_TIER]', @upd_cmd = N'SCALL [sp_MSupd_dboOPS_ENT_PARTNER_TIER]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__OPS_ENT_PARTNER_TIER', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @article = N'OPS_ENTITLEMENT_ORDER', @source_owner = N'dbo', @source_object = N'OPS_ENTITLEMENT_ORDER', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'OPS_ENTITLEMENT_ORDER', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboOPS_ENTITLEMENT_ORDER]', @del_cmd = N'CALL [sp_MSdel_dboOPS_ENTITLEMENT_ORDER]', @upd_cmd = N'SCALL [sp_MSupd_dboOPS_ENTITLEMENT_ORDER]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__OPS_ENTITLEMENT_ORDER', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @article = N'OPS_ENTITLEMENT_PRODUCT', @source_owner = N'dbo', @source_object = N'OPS_ENTITLEMENT_PRODUCT', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'OPS_ENTITLEMENT_PRODUCT', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboOPS_ENTITLEMENT_PRODUCT]', @del_cmd = N'CALL [sp_MSdel_dboOPS_ENTITLEMENT_PRODUCT]', @upd_cmd = N'SCALL [sp_MSupd_dboOPS_ENTITLEMENT_PRODUCT]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__OPS_HOST_ENTITY', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__OPS_HOST_ENTITY', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__OPS_HOST_ENTITY', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__OPS_HOST_ENTITY', @article = N'OPS_HOST_ENTITY', @source_owner = N'dbo', @source_object = N'OPS_HOST_ENTITY', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'OPS_HOST_ENTITY', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboOPS_HOST_ENTITY]', @del_cmd = N'CALL [sp_MSdel_dboOPS_HOST_ENTITY]', @upd_cmd = N'SCALL [sp_MSupd_dboOPS_HOST_ENTITY]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__OPS_HOST_ENTITY', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__OPS_HOST_ENTITY', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @article = N'OPS_STATE_CHANGE_HISTORY', @source_owner = N'dbo', @source_object = N'OPS_STATE_CHANGE_HISTORY', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'OPS_STATE_CHANGE_HISTORY', @destination_owner = N'dbo', @status = 8, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboOPS_STATE_CHANGE_HISTORY]', @del_cmd = N'CALL [sp_MSdel_dboOPS_STATE_CHANGE_HISTORY]', @upd_cmd = N'SCALL [sp_MSupd_dboOPS_STATE_CHANGE_HISTORY]', @filter_clause = N'CREATED_ON > getdate() - 90
and OBJECT_CLASS = ''com.flexnet.operations.bizobjects.entitlements.SimpleEntitlementBO'''

-- Adding the article filter
exec sp_articlefilter @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @article = N'OPS_STATE_CHANGE_HISTORY', @filter_name = N'FLTR_OPS_STATE_CHANGE_HISTORY_1__94', @filter_clause = N'CREATED_ON > getdate() - 90
and OBJECT_CLASS = ''com.flexnet.operations.bizobjects.entitlements.SimpleEntitlementBO''', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1

-- Adding the article synchronization object
exec sp_articleview @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @article = N'OPS_STATE_CHANGE_HISTORY', @view_name = N'SYNC_OPS_STATE_CHANGE_HISTORY_1__94', @filter_clause = N'CREATED_ON > getdate() - 90
and OBJECT_CLASS = ''com.flexnet.operations.bizobjects.entitlements.SimpleEntitlementBO''', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'Fnpops__OPS_STATE_CHANGE_HISTORY', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__PLT_ORGUNIT', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__PLT_ORGUNIT', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_ORGUNIT', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__PLT_ORGUNIT', @article = N'PLT_ORGUNIT', @source_owner = N'dbo', @source_object = N'PLT_ORGUNIT', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'PLT_ORGUNIT', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPLT_ORGUNIT]', @del_cmd = N'CALL [sp_MSdel_dboPLT_ORGUNIT]', @upd_cmd = N'SCALL [sp_MSupd_dboPLT_ORGUNIT]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__PLT_ORGUNIT', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__PLT_ORGUNIT', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__PLT_USER', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__PLT_USER', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PLT_USER', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__PLT_USER', @article = N'PLT_USER', @source_owner = N'dbo', @source_object = N'PLT_USER', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'PLT_USER', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPLT_USER]', @del_cmd = N'CALL [sp_MSdel_dboPLT_USER]', @upd_cmd = N'SCALL [sp_MSupd_dboPLT_USER]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__PLT_USER', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__PLT_USER', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__PROD_LICENSE_MODEL', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__PROD_LICENSE_MODEL', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_LICENSE_MODEL', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__PROD_LICENSE_MODEL', @article = N'PROD_LICENSE_MODEL', @source_owner = N'dbo', @source_object = N'PROD_LICENSE_MODEL', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'PROD_LICENSE_MODEL', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPROD_LICENSE_MODEL]', @del_cmd = N'CALL [sp_MSdel_dboPROD_LICENSE_MODEL]', @upd_cmd = N'SCALL [sp_MSupd_dboPROD_LICENSE_MODEL]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__PROD_LICENSE_MODEL', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__PROD_LICENSE_MODEL', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__PROD_ORDERABLE', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__PROD_ORDERABLE', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__PROD_ORDERABLE', @article = N'PROD_ORDERABLE', @source_owner = N'dbo', @source_object = N'PROD_ORDERABLE', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'PROD_ORDERABLE', @destination_owner = N'dbo', @status = 8, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPROD_ORDERABLE]', @del_cmd = N'CALL [sp_MSdel_dboPROD_ORDERABLE]', @upd_cmd = N'SCALL [sp_MSupd_dboPROD_ORDERABLE]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__PROD_ORDERABLE', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__PROD_ORDERABLE', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__PROD_ORDERABLE_MODEL', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__PROD_ORDERABLE_MODEL', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_ORDERABLE_MODEL', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__PROD_ORDERABLE_MODEL', @article = N'PROD_ORDERABLE_MODEL', @source_owner = N'dbo', @source_object = N'PROD_ORDERABLE_MODEL', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'none', @destination_table = N'PROD_ORDERABLE_MODEL', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPROD_ORDERABLE_MODEL]', @del_cmd = N'CALL [sp_MSdel_dboPROD_ORDERABLE_MODEL]', @upd_cmd = N'SCALL [sp_MSupd_dboPROD_ORDERABLE_MODEL]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__PROD_ORDERABLE_MODEL', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__PROD_ORDERABLE_MODEL', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [Fnpops]
exec sp_addpublication @publication = N'FNpops__PROD_SKU', @description = N'Transactional publication of database ''Fnpops'' from Publisher ''FTLQSQLCL12\INSTA01''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'false', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'false', @immediate_sync = N'false', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'FNpops__PROD_SKU', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\svcacct_sqlappsprod'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\svcacct_devsqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\kiritc'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\CRMAdmin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\karlf'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\SiebelSQLAdminDev'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\svcacct_sqlbackupcon'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\SQLAdminQA'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'CITRITE\svcacct_sqlapps'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'NT SERVICE\MSSQL$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'NT SERVICE\SQLAgent$INSTA01'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'FNpops__PROD_SKU', @login = N'dba_admin'
GO

-- Adding the transactional articles
use [Fnpops]
exec sp_addarticle @publication = N'FNpops__PROD_SKU', @article = N'PROD_SKU', @source_owner = N'dbo', @source_object = N'PROD_SKU', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF, @identityrangemanagementoption = N'manual', @destination_table = N'PROD_SKU', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPROD_SKU]', @del_cmd = N'CALL [sp_MSdel_dboPROD_SKU]', @upd_cmd = N'SCALL [sp_MSupd_dboPROD_SKU]'
GO

-- Adding the transactional subscriptions
use [Fnpops]
exec sp_addsubscription @publication = N'FNpops__PROD_SKU', @subscriber = N'FTLQODSSQLCL01', @destination_db = N'ReplicaFnpops', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'FNpops__PROD_SKU', @subscriber = N'FTLQODSSQLCL01', @subscriber_db = N'ReplicaFnpops', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO



