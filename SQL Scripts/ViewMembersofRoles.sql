SELECT DP1.name AS DatabaseRoleName,   
    isnull (DP2.name, 'No members') AS DatabaseUserName   
FROM sys.database_role_members AS DRM  
RIGHT OUTER JOIN sys.database_principals AS DP1  
    ON DRM.role_principal_id = DP1.principal_id  
LEFT OUTER JOIN sys.database_principals AS DP2  
    ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name;

SELECT pr.principal_id, pr.name, pr.type_desc, 
    pr.authentication_type_desc, pe.state_desc, pe.permission_name, OBJECT_NAME(major_id) objectName
FROM sys.database_principals AS pr
JOIN sys.database_permissions AS pe ON pe.grantee_principal_id = pr.principal_id
--INNER JOIN sys.schemas AS s ON s.principal_id =  sys.database_role_members.role_principal_id 
     where pr.name in ('octopusdb') 



