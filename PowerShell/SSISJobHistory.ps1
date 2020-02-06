# will get the last 100 agent job history 
Import-Module SQLPS -DisableNameChecking

$Servers = ("FTLPEISSIS02","FTLPEISSIS01")

$Truncate = "Truncate Table SSISAgentHistory"
Invoke-Sqlcmd -ServerInstance "FTLDDBASQL01" -Database CTAdmin -Query $Truncate

ForEach($Server IN $Servers)
{
    $Query =
    "SELECT distinct Top 100
     h.[server], j.[name] AS [JobName],  
     run_status = CASE h.run_status  
     WHEN 0 THEN 'Failed' 
     WHEN 1 THEN 'Succeeded' 
     WHEN 2 THEN 'Retry' 
     WHEN 3 THEN 'Canceled' 
     WHEN 4 THEN 'In progress' 
      END, 
     h.run_date AS LastRunDate,   
     h.run_time AS LastRunTime 
    FROM sysjobhistory (Nolock) h  
     INNER JOIN sysjobs (Nolock) j ON h.job_id = j.job_id  
       WHERE j.enabled = 1   
	   and h.run_date = (convert(nchar(10), current_timestamp, 112))
       --AND h.instance_id IN  
       --(SELECT MAX(h.instance_id)  
       --    FROM sysjobhistory (Nolock) h GROUP BY (h.job_id))
	   order by LastRunTime desc"

$Results = Invoke-Sqlcmd -ServerInstance $Server -Database msdb -Query $Query


ForEach($Result IN $Results)
{
    $var1 = $Result.server
    $var2 = $Result.JobName
    $var3 = $Result.Run_Status
    $var4 = $Result.LastRunDate
    $var5 = $Result.LastRunTime

    $InsertQuery = "
    Insert INTO SSISAgentHistory(Server, JobName, RunStatus, LastRunDate, LastRunTime) Values ('$var1', '$var2', '$var3', '$var4', '$var5')"

    Invoke-SQlcmd -ServerInstance "FTLDDBASQL01" -Database CTAdmin -Query $InsertQuery
    }
}