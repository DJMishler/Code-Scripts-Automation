SELECT instance_name as [DBName],

cntr_value as "LogFullPercentage"

FROM sys.dm_os_performance_counters

WHERE counter_name LIKE 'Percent Log Used%'

AND instance_name not in ('_Total', 'mssqlsystemresource')
order by cntr_value desc


