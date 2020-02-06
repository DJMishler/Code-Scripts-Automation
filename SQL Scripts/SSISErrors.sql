USE SSISDB
go

select @@SERVERNAME

--Find all error messages
SELECT     DISTINCT OPR.object_name
                     , SSISProject.name
            , MSG.message_time
            , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CAST(MSG.message AS varchar(MAX)),CHAR(10), ''), CHAR(10) + CHAR(13), ''), CHAR(10) + CHAR(9), ''), CHAR(10) + CHAR(13) + CHAR(9), ''), CHAR(10) + CHAR(9) + CHAR(13), ''), CHAR(13), ''), CHAR(13) + CHAR(10), ''), CHAR(13) + CHAR(9), ''), CHAR(13) + CHAR(10) + CHAR(9), ''), CHAR(13) + CHAR(9) + CHAR(10), ''), CHAR(9), ''), CHAR(9) + CHAR(13), ''), CHAR(9) + CHAR(10), ''), CHAR(9) + CHAR(13) + CHAR(10), ''), CHAR(9) + CHAR(10) + CHAR(13), '') AS [Message]
FROM        catalog.operation_messages  AS MSG (NOLOCK)
INNER JOIN  catalog.operations          AS OPR (NOLOCK) ON      OPR.operation_id            = MSG.operation_id
LEFT JOIN internal.projects AS SSISProject (NOLOCK) ON OPR.object_id = SSISProject.project_id
WHERE       MSG.message_type            = 120
--and OPR.object_name like '%book%'
AND message LIKE '%communication link%'
AND message LIKE '%forcibly closed%'
order by MSG.message_time desc
