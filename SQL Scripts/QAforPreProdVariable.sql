DECLARE 
    @folder_id bigint,
    @environment_id bigint
 
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[folders] WHERE name = N'BI.PREPROD')
    EXEC [SSISDB].[catalog].[create_folder] @folder_name=N'BI.PREPROD', @folder_id=@folder_id OUTPUT
ELSE
    SET @folder_id = (SELECT folder_id FROM [SSISDB].[catalog].[folders] WHERE name = N'BI.PREPROD')
 
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environments] WHERE folder_id = @folder_id AND name = N'BI.Global.Parameters')
    EXEC [SSISDB].[catalog].[create_environment] @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD'
 
SET @environment_id = (SELECT environment_id FROM [SSISDB].[catalog].[environments] WHERE folder_id = @folder_id and name = N'BI.Global.Parameters')
 
DECLARE @var sql_variant
 
SET @var = N'QA_CTX_EDW'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'CTX_EDW_Database')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'CTX_EDW_Database', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA_CTX_STG'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'CTX_STG_Database')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'CTX_STG_Database', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'sapciq12.citrite.net'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SAPBWConnection_Host')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SAPBWConnection_Host', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
 
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SAPBWConnection_Password')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SAPBWConnection_Password', @sensitive=1, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'RFCQSSISBI'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SAPBWConnection_Username')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SAPBWConnection_Username', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'ssis_config'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SSISConfiguration_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SSISConfiguration_InitialCatalog', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'MSDB'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'BIELT_MSDB_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'BIELT_MSDB_InitialCatalog', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'FTLPELTSQLCL01\BIELT'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'BIELT_ServerName')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'BIELT_ServerName', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'17001'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'PDW.PortNumber')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'PDW.PortNumber', @sensitive=0, @description=N'PDW Port Number', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'PDWDOM-CTL01-CL.fabdom.local,17001'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'PDW.SQLHost')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'PDW.SQLHost', @sensitive=0, @description=N'Connection string for SQLconnections to PDW', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'PDWDOM-CTL01-CL.fabdom.local'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'PDW_Host')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'PDW_Host', @sensitive=0, @description=N'PDW SQL Instance Control Node Name, Host URL or IP Address', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA_CTX_EDW_R1'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'CTX_EDW_R1_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'CTX_EDW_R1_InitialCatalog', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA_ReportalEDWPull'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'ReportalEDWPull_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ReportalEDWPull_InitialCatalog', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA_SDW1'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SDW1_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SDW1_InitialCatalog', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA_SSTAGE1'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SSTAGE1_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SSTAGE1_InitialCatalog', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'StageDB'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'StageDB_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'StageDB_InitialCatalog', @sensitive=0, @description=N'Name of the StageDB for PDW Destinations', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'\\FTLPHYPSQLCL01\ETLDataFiles\BI.SIR.ETL\SummaryReport\'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SummaryReport_FileLocation')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SummaryReport_FileLocation', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'SummaryReport'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SummaryReport_FileName')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SummaryReport_FileName', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QAODSREPLICA'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'QAODSREPLICA_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'QAODSREPLICA_InitialCatalog', @sensitive=0, @description=N'Server Name for OdsReplica', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'ReplicaCallidus'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'ReplicaCallidus_InitialCatalog')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ReplicaCallidus_InitialCatalog', @sensitive=0, @description=N'DB Name for ReplicaCallidus', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'BI.ETL.SIR.SummaryReport.txt'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SIR_NotificationFileName')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SIR_NotificationFileName', @sensitive=0, @description=N'Notification File Name', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'PDW.Environment')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'PDW.Environment', @sensitive=0, @description=N'Current Environment (SB (default) or DEV or QA or PREPROD or PROD', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'marcos.germano@citrix.com'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SMTP.Recipient')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SMTP.Recipient', @sensitive=0, @description=N'SMTP Recipient(s)', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'marcos.germano@citrix.com'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SMTP.Sender')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SMTP.Sender', @sensitive=0, @description=N'SMTP Sender', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'hqsmtp.citrite.net'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SMTP.Server')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SMTP.Server', @sensitive=0, @description=N'SMTP Server', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA.CTX_EDW_R0_Conformed_Dims'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SSISDB.Execute.Job.ConformedDims')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SSISDB.Execute.Job.ConformedDims', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'R0_Load_Conformed_Dims'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SSISDB.Execute.Step.ConformedDims')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SSISDB.Execute.Step.ConformedDims', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'QA.EDW: Bookings_1_ETL'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SSISDB.Execute.Job.Bookings')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SSISDB.Execute.Job.Bookings', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
SET @var = N'Set Status Processing'
IF NOT EXISTS (SELECT 1 FROM [SSISDB].[catalog].[environment_variables] WHERE environment_id = @environment_id AND name = N'SSISDB.Execute.Step.Bookings')
            EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SSISDB.Execute.Step.Bookings', @sensitive=0, @description=N'', @environment_name=N'BI.Global.Parameters', @folder_name=N'BI.PREPROD', @value=@var, @data_type=N'String'
 
