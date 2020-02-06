use testdb;
go

Declare @SchemaTableName nvarchar(250);

--select s.name as [Schema Name],object_name(t.object_id) as tablename, * from sys.indexes i 
--left join sys.tables t on i.object_id = t.object_id 
--left join sys.schemas s on t.schema_id = s.schema_id
--where i.type_desc = 'CLUSTERED' 
--and t.type_desc = 'USER_TABLE'

Set @SchemaTableName = 

(select  COALESCE(s.name,'')+ '.'+   COALESCE(object_name(t.object_id), '') from sys.indexes i 
left join sys.tables t on i.object_id = t.object_id 
left join sys.schemas s on t.schema_id = s.schema_id
where i.type_desc = 'CLUSTERED' 
and t.type_desc = 'USER_TABLE')

Print @SchemaTableName

--select * from sys.tables 

--SELECT COALESCE(field1, '') || COALESCE(field2, '') || COALESCE(field3, '') FROM table1
