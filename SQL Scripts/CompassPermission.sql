EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'US1\_octopusd';
EXEC sp_addrolemember @rolename = 'db_datawriter', @membername = 'US1\_octopusd';
EXEC sp_addrolemember @rolename = 'db_ddladmin', @membername = 'US1\_octopusd';
EXEC sp_addrolemember @rolename = 'db_securityadmin', @membername = 'US1\_octopusd';

GRANT CONNECT TO [US1\_octopusd]
GRANT EXECUTE TO [US1\_octopusd]
GRANT VIEW DEFINITION TO [US1\_octopusd]
GRANT CONTROL ON SCHEMA::[dbo]  TO [US1\_octopusd]
GRANT ALTER ON SCHEMA::[Deprecated]  TO [US1\_octopusd] 