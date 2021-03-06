--Steps to be performed on FTLDCTCIACSQL01

USE [master]
GO

--Step 1: Have the application owner stop the application
--Step 2: Set database to Read Only Mode:


--ALTER DATABASE [OrchestratorProcess] SET  READ_ONLY WITH Rollback Immediate;
--GO

--ALTER DATABASE [OrchestratorReporting] SET  READ_ONLY WITH Rollback immediate;
--GO

--ALTER DATABASE [RequestCenter] SET  READ_ONLY WITH Rollback immediate;
--GO

--Step 3: Backup The databases to Fileshare

BACKUP DATABASE [OrchestratorProcess] 
TO  DISK = N'\\ftlpfs08\SQLDUMPS03\PROD\FTLPSQLCL02_INSTA\CloudMigration\OrchestratorProcessMigration.bak' 
WITH  COPY_ONLY, NOFORMAT, NOINIT,  
NAME = N'OrchestratorProcess-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO

BACKUP DATABASE [OrchestratorReporting] 
TO  DISK = N'\\ftlpfs08\SQLDUMPS03\PROD\FTLPSQLCL02_INSTA\CloudMigration\OrchestratorReportingMigration.bak' 
WITH  COPY_ONLY, NOFORMAT, NOINIT,  
NAME = N'OrchestratorReporting-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO

BACKUP DATABASE [RequestCenter] 
TO  DISK = N'\\ftlpfs08\SQLDUMPS03\PROD\FTLPSQLCL02_INSTA\CloudMigration\RequestCenterMigration.bak' 
WITH  COPY_ONLY, NOFORMAT, NOINIT,  
NAME = N'RequestCenter-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO


--Step 4: Set Database status to offline

--Alter Database [OrchestratorProcess] 
--Set offline with rollback immediate
--GO

--Alter Database [OrchestratorReporting] 
--Set offline with rollback immediate
--GO

--Alter Database [RequestCenter] 
--Set offline with rollback immediate
--GO