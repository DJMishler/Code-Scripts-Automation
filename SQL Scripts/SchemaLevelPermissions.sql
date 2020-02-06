use [GSO]
GO
GRANT DELETE ON SCHEMA::[Opensource] TO [citrite\svcacct_dbopensrc]
GO
use [GSO]
GO
GRANT EXECUTE ON SCHEMA::[Opensource] TO [citrite\svcacct_dbopensrc]
GO
use [GSO]
GO
GRANT INSERT ON SCHEMA::[Opensource] TO [citrite\svcacct_dbopensrc]
GO
use [GSO]
GO
GRANT SELECT ON SCHEMA::[Opensource] TO [citrite\svcacct_dbopensrc]
GO
use [GSO]
GO
GRANT UPDATE ON SCHEMA::[Opensource] TO [citrite\svcacct_dbopensrc]
GO
--The following two commands are linked together in order to create tables on a particular schema
Use [GSO]
GRANT CREATE TABLE TO [citrite\svcacct_dbopensrc]
GO
Use [GSO]
GRANT ALTER ON SCHEMA::[Opensource] TO [citrite\svcacct_dbopensrc]
GO