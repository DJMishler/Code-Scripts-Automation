--Free the Storedprocedure cache for one database

--DECLARE @intDBID INT;
--SET @intDBID = (SELECT [dbid] 
--                FROM master.dbo.sysdatabases 
--                WHERE name = 'MDMCustomer');

---- Flush the procedure cache for one database only
--DBCC FLUSHPROCINDB (@intDBID);