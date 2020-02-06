SELECT db_name(dbid) as DatabaseName, count(dbid) as NoOfConnections,
loginame as LoginName
--,hostname
FROM sys.sysprocesses
WHERE dbid = 5
--Where dbid > 0
and status <> 'Sleeping'
GROUP BY dbid, loginame
order by NoOfConnections desc

--Select * from sys.databases

Select * from sys.sysprocesses