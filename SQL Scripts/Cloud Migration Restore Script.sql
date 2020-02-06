--Steps to be performed in FTLQSQL05\Insta

--Step 1: Restore Databases
--use master
--Go

--RESTORE DATABASE OrchestratorProcess
--FROM 
--DISK='\\ftlpfs08\SQLDUMPS03\PROD\FTLPSQLCL02_INSTA\CloudMigration\OrchestratorProcessMigration.bak'
--WITH 
--MOVE 'OrchestratorProcess.mdf' TO 'S:\Program Files\Microsoft SQL Server\MSSQL11.INSTA\MSSQL\DATA\OrchestratorProcess.mdf',
--MOVE 'OrchestratorProcess.ndf' TO 'S:\Program Files\Microsoft SQL Server\MSSQL11.INSTA\MSSQL\DATA\OrchestratorProcess.ndf',
--MOVE 'OrchestratorProcess_log.ldf' TO  'S:\Program Files\Microsoft SQL Server\MSSQL11.INSTA\MSSQL\DATA\OrchestratorProcess_log.ldf'
--,REPLACE ,STATS=10
--GO

--RESTORE DATABASE OrchestratorReporting
--FROM 
--DISK='\\ftlpfs08\SQLDUMPS03\PROD\FTLPSQLCL02_INSTA\CloudMigration\OrchestratorReportingMigration.bak'
--WITH 
--MOVE 'OrchestratorReporting.mdf' TO 'S:\Program Files\Microsoft SQL Server\MSSQL11.INSTA\MSSQL\DATA\OrchestratorReporting.mdf',
--MOVE 'OrchestratorReporting_log.ldf' TO  'S:\Program Files\Microsoft SQL Server\MSSQL11.INSTA\MSSQL\DATA\OrchestratorReporting_log.ldf'
--,REPLACE ,STATS=10
--GO

--RESTORE DATABASE RequestCenter
--FROM 
--DISK='\\ftlpfs08\SQLDUMPS03\PROD\FTLPSQLCL02_INSTA\CloudMigration\RequestCenterMigration.bak'
--WITH 
--MOVE 'RequestCenter' TO 'S:\Program Files\Microsoft SQL Server\MSSQL11.INSTA\MSSQL\DATA\RequestCenter.mdf',
--MOVE 'RequestCenter_log' TO  'S:\Program Files\Microsoft SQL Server\MSSQL11.INSTA\MSSQL\DATA\RequestCenter_log.ldf'
--,REPLACE ,STATS=10
--GO

--Step 2: Set databases to Read/Write

--ALTER DATABASE [OrchestratorProcess] SET READ_WRITE WITH NO_WAIT
--GO

--ALTER DATABASE OrchestratorReporting SET READ_WRITE WITH NO_WAIT
--GO

--ALTER DATABASE RequestCenter SET READ_WRITE WITH NO_WAIT
--GO

--Step 3: Have application owner repoint the application to new server
