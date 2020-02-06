/*Change Ownership of objects from sa account to new sysadmin account */

--Run this part of the script on FTLPSQCL10\INSTA
Use master;
Go
Alter Authorization ON Database::[ePO4_FTLPSECEPO01] TO [Ronaldinho];
Go



--Run this part of the script on FTLPODSSQLCL01
Use master;
Go
Alter Authorization ON Database::[Playmaker] TO [Ronaldinho];
Go



--Run this part of the script on AMSPSQLCL01
Use master;
Go
Alter Authorization ON Database::[ShowcaseAMSXD71] TO [Ronaldinho];
Go
Alter Authorization ON Database::[ShowcaseAMSXD75] TO [Ronaldinho];
Go


--Run this part of the script on SINPSQLCL01
Use master;
Go
Alter Authorization ON Database::[ShowcaseSINXD71] TO [Ronaldinho];
Go
Alter Authorization ON Database::[ShowcaseSINXD75] TO [Ronaldinho];
Go



/*The following section does not need to be executed, it's just for informational purposes.




--Use msdb;
--Go

--EXEC dbo.sp_manage_jobs_by_login
--	@action = N'Reassign',
--	@current_owner_login_name = N'sa',
--	@new_owner_login_name = N'Ronaldinho';
--Go


*/