--drop users from a database

SELECT 'EXEC dbo.sp_revokedbaccess N'''+name+'''' FROM dbo.sysusers 