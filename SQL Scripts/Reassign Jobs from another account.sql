

Exec msdb.dbo.sp_manage_jobs_by_login
	@action = 'Reassign',
	@current_owner_login_name = 'Citrite\diegomi',
	@new_owner_login_name = 'sa'