--Script to add new user to Azure DB
--Create Login
CREATE LOGIN leads_user1 WITH PASSWORD = 'tvlCBy3s38QTfhTr85dG';
GO
CREATE LOGIN octopusdb WITH PASSWORD = 'lse6EFyamUdAKc1kyCyc';
GO

--Create User from Login
CREATE USER leads_user1 FROM LOGIN leads_user1; 
Go
CREATE USER octopusdb FROM LOGIN octopusdb; 
Go



--Create Permissions
EXEC sp_addrolemember 'db_datareader','leads_user1'
GO
EXEC sp_addrolemember 'db_datawriter','octopusdb';
GO
EXEC sp_addrolemember 'db_datareader','octopusdb';
GO
EXEC sp_addrolemember 'db_ddladmin', 'octopusdb';
GO
EXEC sp_addrolemember 'db_securityadmin','octopusdb';
GO




GRANT CONNECT TO [octopusdb]
Go
GRANT EXECUTE TO [octopusdb]
GO
GRANT VIEW DEFINITION TO [octopusdb]
GO
GRANT CONTROL ON SCHEMA::[dbo]  TO [octopusdb]
GO
----GRANT ALTER ON SCHEMA::[Deprecated]  TO [US1\_octopusd] 

--EXEC sp_addrolemember 'db_datareader', 'leads_user1';
--GO
--EXEC sp_addrolemember 'db_datawriter', 'leads_user1';
--GO