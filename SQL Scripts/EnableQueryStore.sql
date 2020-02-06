/* Turn ON Query Store */

ALTER DATABASE AdventureWorks2017 SET QUERY_STORE = ON

/* Review the current Query Store parameters */
Select * FROM sys.database_query_store_options

/* Set new parameter values */
--ALTER DATABASE AdventureWorks2017
--SET QUERY_STORE (
--OPERATION_MODE = READ_WRITE,
--	CLEANUP_POLICY = ( STALE_QUERY_THRESHOLD_DAYS = 30 ),
--	DATA_FLUSH_INTERVAL_SECONDS = 3000,
--MAX_SIZE_MB = 500, INTERVAL_LENGTH_MINUTES = 15);

/* Clear all Query Store data */
ALTER DATABASE AdventureWorks2017 SET QUERY_STORE CLEAR;

/* Turn off Query Store */
ALTER DATABASE AdventureWorks2017 SET QUERY_STORE = OFF;