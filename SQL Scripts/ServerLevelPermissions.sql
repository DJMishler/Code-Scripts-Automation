use master
GO
--Server Roles
SELECT 'EXEC master..sp_addsrvrolemember @loginame = N''' + SL.NAME + ''', @rolename = N''' + SR.NAME + '''
' AS [-- Server Roles the Logins Need to be Added --]
FROM master.sys.server_role_members SRM
INNER JOIN master.sys.server_principals SR ON SR.principal_id = SRM.role_principal_id
INNER JOIN master.sys.server_principals SL ON SL.principal_id = SRM.member_principal_id
WHERE SL.type IN (
              'S'
              ,'G'
              ,'U'
              )
       AND SL.NAME NOT LIKE '##%##'
       AND SL.NAME NOT LIKE 'NT AUTHORITY%'
       AND SL.NAME NOT LIKE 'NT SERVICE%'
       AND SL.NAME <> ('sa');

 

--Server Permissions
SELECT CASE 
              WHEN SrvPerm.state_desc <> 'GRANT_WITH_GRANT_OPTION'
                      THEN SrvPerm.state_desc
              ELSE 'GRANT'
              END + ' ' + SrvPerm.permission_name + ' TO [' + SP.NAME + ']' + CASE 
              WHEN SrvPerm.state_desc <> 'GRANT_WITH_GRANT_OPTION'
                      THEN ''
              ELSE ' WITH GRANT OPTION'
              END collate database_default AS [-- Server Level Permissions to Be Granted --]
FROM sys.server_permissions AS SrvPerm
INNER JOIN sys.server_principals AS SP ON SrvPerm.grantee_principal_id = SP.principal_id
WHERE SP.type IN (
              'S'
              ,'U'
              ,'G'
              )
       AND SP.NAME NOT LIKE '##%##'
       AND SP.NAME NOT LIKE 'NT AUTHORITY%'
       AND SP.NAME NOT LIKE 'NT SERVICE%'
       AND SP.NAME <> ('sa');