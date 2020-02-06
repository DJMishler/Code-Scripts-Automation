DECLARE @dml nvarchar(max) = N''        
IF OBJECT_ID('tempdb.dbo.#Results') IS NOT NULL DROP TABLE dbo.#Results
CREATE TABLE dbo.#Results
 ([tablename] nvarchar(100), 
  [ColumnName] nvarchar(100), 
  [Value] nvarchar(max))  
SELECT @dml += ' SELECT ''' + s.name + '.' + t.name + ''' AS [tablename], ''' + 
                c.name + ''' AS [ColumnName], CAST(' + QUOTENAME(c.name) + 
               ' AS nvarchar(max)) AS [Value] FROM ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) +
               ' (NOLOCK) WHERE CAST(' + QUOTENAME(c.name) + ' AS nvarchar(max)) LIKE ' + '''%' + 'SJCPSQLCL01' + '%'''
FROM sys.schemas s JOIN sys.tables t ON s.schema_id = t.schema_id
                   JOIN sys.columns c ON t.object_id = c.object_id
                   JOIN sys.types ty ON c.system_type_id = ty.system_type_id AND c .user_type_id = ty .user_type_id
WHERE t.is_ms_shipped = 0 AND ty.name NOT IN ('timestamp', 'image', 'sql_variant')

INSERT dbo.#Results
EXEC sp_executesql @dml

SELECT *
FROM dbo.#Results