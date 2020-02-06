use master
Go

Create database CorruptionTest
Go

Use CorruptionTest
Go

Create Table FamilyBonus(
ID int NOT NULL primary key identity,
Name varchar(20) NULL,
Bonus int NULL
)
Go

Insert Into FamilyBonus Values('Diego', 1000)
Insert Into FamilyBonus Values('Colleen', 1000)
Go

BACKUP DATABASE [CorruptionTest] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'CorruptionTest-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10, CHECKSUM
GO


--This record below will not be in the full backup
Insert Into FamilyBonus Values('Mikaela', 1000)
GO
--Log Backup takes place here
BACKUP LOG [CorruptionTest] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest.trn' 
WITH NOFORMAT, NOINIT,  NAME = N'CorruptionTest-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10, CHECKSUM
GO

/*At this point we need to take the Database Offline and Run the Corrutpion Tool using the instruction from CorruptionTest_FileCorruptionSteps.sql
Step 1: Take Database offline
Step 2: Corrupt the database using the corruption tool
Step 3: Bring Database backonline

*/

--A full backup gets taken right after this to mimick the next day full backup before the issue has been encountered.
BACKUP DATABASE [CorruptionTest] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest_01.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'CorruptionTest-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10, CHECKSUM
GO

--At this point the database table has been corrupted and we found out because the a user hit a logical section of the file by querying it, and the full daily backup job has failed and we have been notified.

--Right after, a user created a table and entered new data.

Create table JustaTest (
ID int NOT NULL primary key identity,
MessageText varchar(100)
)
GO
Insert into JustaTest Values('This is a message')
GO
Insert into JustaTest Values('This is another message')
Go



-- We have been informed that there is corruption in the database and we need to act on this.
/* Steps that need to be taken are as follow:
Step 1: Find when the last good DBCC CheckDB was and correlate that to the Full Backup before this
Step 2: Verify the validity of the next full backup; by using the verify only WITH CHECKSUM.
Step 3: Run DBCC CheckDB if you don't have the info for it, you'll need to see what the issue might be, it could be just an index.
Step 4: You need to inform the business that this needs to be taken offline and a recovery process needs to begin
Step 4: Once you're ready to restore, make sure you take a tail log backup.

Note: Make sure your backups have CHECKSUM option included.

*/

--Check the validity of the last full backup before the error
RESTORE VERIFYONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest.bak' 
WITH CHECKSUM



--Take the tail log backup; this leaves the database is restoring mode

Use master
Go
BACKUP LOG [CorruptionTest] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest_TailLog_20190102.trn' 
WITH  NO_TRUNCATE , NOFORMAT, NOINIT,  NAME = N'CorruptionTest-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 10, CHECKSUM
GO

-- The restore process begins here, your latest good full backup and all the trailing log files after that, unless you're using differential backups as well.
USE [master]
RESTORE DATABASE [CorruptionTest] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE LOG [CorruptionTest] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest.trn' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [CorruptionTest] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\CorruptionTest_TailLog_20190102.trn' WITH  FILE = 1,  NOUNLOAD,  STATS = 5

GO



Use CorruptionTest
Go
Select * from FamilyBonus
GO
Select * from JustaTest
GO