Use MDS
Go

SELECT Us.name AS username, Obj.name AS object, dp.permission_name AS permission  
FROM sys.database_permissions dp 
JOIN sys.sysusers Us  
ON dp.grantee_principal_id = Us.uid  
JOIN sys.sysobjects Obj 
ON dp.major_id = Obj.id 
--Where US.Name = 'CITRITE\svcacct_ELT_ProxDev'
