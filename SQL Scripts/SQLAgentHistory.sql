use msdb
GO

select j.name, s.step_name, h.instance_id
       --,h.run_date
       --,h.run_time ,run_time  = (h.run_time/10000) * 3600 + (h.run_time % 10000) / 100 * 60 + h.run_time % 100
       ,rundatetime = dateadd(second,(h.run_time/100)*36+ (h.run_time % 10000)/10*6+ h.run_time%100,
                                         cast(cast(h.run_date as varchar) as datetime))
       --,h.run_duration
       ,run_duration  = cast(dateadd(hour,h.run_duration/10000,dateadd(minute,(h.run_duration%10000) / 100,dateadd(second,h.run_duration% 100,0))) as time)
       ,run_status = case h.run_status when 0 then 'Fail' when 1 then 'Success' when 2 then 'Retry' when 3 then 'Cancelled' when 4 then 'InProgress' end
       ,h.retries_attempted
       ,s.command
          , h.run_status
          , h.[message]
from 
       sysjobs j
       inner join sysjobsteps s on 
              j.job_id = s.job_id
       inner join sysjobstepslogs l on 
              l.step_uid = s.step_uid
       inner join sysjobhistory h on 
              h.job_id = j.job_id
              and h.step_id = s.step_id
where  
              j.name = 'BI Generic ELT'
       -- and h.run_status <> 4   
       --and h.run_status in (0,1,3) -- Comment this line to see status when retying or in progress
       and cast(cast(h.run_date as varchar) as datetime) >= cast(dateadd(day,0,getdate()) as date)
order by 
       --j.name,
       h.instance_id desc
