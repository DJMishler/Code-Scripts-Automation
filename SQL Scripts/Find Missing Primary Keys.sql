Use CADS;
Go

SELECT c.name, b.name  
FROM sys.tables b  
INNER JOIN sys.schemas c ON b.schema_id = c.schema_id  
WHERE b.type = 'U'  
AND NOT EXISTS 
(SELECT a.name  
FROM sys.key_constraints a  
WHERE a.parent_object_id = b.OBJECT_ID  
AND a.schema_id = c.schema_id  
AND a.type = 'PK' )
order by b.name
Go