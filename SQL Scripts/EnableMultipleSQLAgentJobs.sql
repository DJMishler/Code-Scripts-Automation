USE MSDB;
GO
UPDATE MSDB.dbo.sysjobs
SET Enabled = 1
WHERE [Name] LIKE 'Refresh -%'
and enabled = 0
--and [name] <> 'Refresh - FieldPermissions'
GO

