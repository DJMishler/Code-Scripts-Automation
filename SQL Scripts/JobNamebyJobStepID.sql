--Select * from msdb...sysjobs where job_id = 0xBA2CEB9CB7AC564A911A19EF500E5846
--Gives you the Job Agent Name based on the Job Step ID that you would get from Spotlight or other locations

select * from msdb.dbo.sysjobs where CONVERT(binary(16), job_id)=0xC88471E7549E9042A5677FC6C1672CAB