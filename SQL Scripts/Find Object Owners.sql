select 
	name as [Database],	
	suser_sname(owner_sid) [Owner]
from sys.databases with (nolock)
where
	suser_sname(owner_sid) = 'sa'
	and state_desc = 'ONLINE'

order by
	name



	SELECT J.name AS Job_Name
, L.name AS Job_Owner
FROM msdb.dbo.sysjobs_view J
INNER JOIN
master.dbo.syslogins L
ON J.owner_sid = L.sid