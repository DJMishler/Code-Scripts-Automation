Use ePO4_FTLPSECEPO01
Go

SELECT  
ds.name as filegroupname
, df.name AS 'FileName' 
, physical_name AS 'PhysicalName'
, size/128 AS 'TotalSizeinMB'
, size/128.0 - CAST(FILEPROPERTY(df.name, 'SpaceUsed') AS int)/128.0 AS 'AvailableSpaceInMB' 
, CAST(FILEPROPERTY(df.name, 'SpaceUsed') AS int)/128.0 AS 'ActualSpaceUsedInMB'
, (CAST(FILEPROPERTY(df.name, 'SpaceUsed') AS int)/128.0)/(size/128)*100. as '%SpaceUsed'
FROM sys.database_files df LEFT OUTER JOIN sys.data_spaces ds  
	ON df.data_space_id = ds.data_space_id;

EXEC xp_fixeddrives
select  t.name as TableName,  
    i.name as IndexName, 
    p.rows as Rows
from sys.filegroups fg (nolock) join sys.database_files df (nolock)
    on fg.data_space_id = df.data_space_id join sys.indexes i (nolock) 
    on df.data_space_id = i.data_space_id join sys.tables t (nolock)
    on i.object_id = t.object_id join sys.partitions p (nolock)
on t.object_id = p.object_id and i.index_id = p.index_id  
where fg.name = 'PRIMARY' and t.type = 'U'  
order by rows desc
select  t.name as TableName,  
    i.name as IndexName, 
    p.rows as Rows
from sys.filegroups fg (nolock) join sys.database_files df (nolock)
    on fg.data_space_id = df.data_space_id join sys.indexes i (nolock) 
    on df.data_space_id = i.data_space_id join sys.tables t (nolock)
    on i.object_id = t.object_id join sys.partitions p (nolock)
on t.object_id = p.object_id and i.index_id = p.index_id  
where fg.name = 'PRIMARY' and t.type = 'U' and i.index_id = 0 
order by rows desc

