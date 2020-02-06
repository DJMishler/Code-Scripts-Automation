
Use sfrstcrDB
;
Select * from sys.partition_functions
Select * from sys.partition_range_values
Select * from sys.partition_schemes



Select t.name as TableName,
ps.name as PartitionSchemeName,
dds.destination_id as partitionnumber,
fg.name as filegroupname

FROM sys.tables t
JOIN sys.indexes i
ON t.object_id = i.object_id

JOIN sys.partition_schemes ps
ON i.data_space_id = ps.data_space_id

JOIN sys.destination_data_spaces dds
ON ps.data_space_id = dds.partition_scheme_id

JOIN sys.filegroups fg
ON dds.data_space_id = fg.data_space_id

Where i.index_id IN (0,1)
and t.name = 'as_nsu_sfrstcr_archive'

Order by t.name, ps.name
GO

SELECT * FROM sys.partitions
WHERE object_id = object_id('dbo.as_nsu_sfrstcr_archive');