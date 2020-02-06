Select object_name(i.object_id) as Object, i.name, us.*
from sys.dm_db_index_usage_stats us
Join sys.indexes i
ON us.object_id = i.object_id
and us.index_id = i.index_id
--where us.database_id = 40
order by us.user_scans desc
