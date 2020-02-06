USE master
GO
ALTER DATABASE CTAdmin MODIFY FILE ( NAME = CTAdmin_log, FILENAME = 'E:\Program Files\Microsoft SQL Server\MSSQL\Logs\CTAdmin1_log.ldf');
GO
ALTER DATABASE model MODIFY FILE ( NAME = modellog, FILENAME = 'E:\Program Files\Microsoft SQL Server\MSSQL\Logs\modellog.ldf');
GO
ALTER DATABASE msdb MODIFY FILE ( NAME = MSDBLog, FILENAME = 'E:\Program Files\Microsoft SQL Server\MSSQL\Logs\MSDBLog.ldf');
GO