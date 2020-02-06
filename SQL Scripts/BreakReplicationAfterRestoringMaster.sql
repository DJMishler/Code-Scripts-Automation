/* These is a script that breaks replication from a system which we restored a master backup from a Production Instance or other instance all together.
If you don't, the server still thinks it's the Prod Server. */



--Steps to clean Replication on ATLPSQLCL11 

--I. Check the name of the instance 

SELECT @@SERVERNAME 


--II. Change the Instance Name 

Use Master; 

Go 

sp_DropServer @@Servername; 

GO  

sp_addserver 'ATLPSQLCL11', Local;  

GO 

-- Restart SQL Server Service 


--III. Regenerate Master KEY 

ALTER SERVICE MASTER KEY FORCE REGENERATE 



--IV. Check Vantive Data is published 

select name,is_published,is_subscribed,is_distributor from sys.databases 

where is_published = 1 or is_subscribed =1 or is_distributor = 1 

GO 


--V. Remove Repliation from VantiveData  

Use VantiveData 

sp_removedbreplication  


EXEC sp_dropdistributor @no_checks = 1, @ignore_distributor = 1 

GO 



-- The following will remove replication from ATLPSQLCL11\INSTA01 

Use 

fnpops 

Go 

sp_removedbreplication 

Go 

EXEC 

sp_dropdistributor @no_checks = 1, @ignore_distributor = 1  

GO 


--Now you can rename the Instance to ATLPSQLCL11\INSTA01 


-- On SMS Right click replication - Disable Publishing and Distribution 

-- ON ATLPREPLSQL01 righ click replication - Ditributor Properties - Publishers - Add ATLPSQLCL11 

-- ON ATLPSQLCL11 right click replicaton Enable Distributor ---  
