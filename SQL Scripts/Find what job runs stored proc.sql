use msdb
go
select sj.name as job_name, st.command
from  sysjobs sj
join sysjobsteps st
on sj.job_id = st.job_id
where st.command like '%Ctsp_unlock_activation%'