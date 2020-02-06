SELECT db_name(dbid) as DatabaseName, count(dbid) as NoOfConnections,
loginame as LoginName
--,hostname
FROM sys.sysprocesses
WHERE dbid = 6
--Where dbid > 0
GROUP BY dbid, loginame
--,hostname

--Select * from sys.databases

--Select * from sys.sysprocesses