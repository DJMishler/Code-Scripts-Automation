--Stops active SSIS Jobs/Processes

SELECT * FROM SSISDB.catalog.executions WHERE end_time IS NULL
order by start_time desc

--Opertion ID parameter is the same as Execution_ID field
--EXEC SSISDB.catalog.stop_operation @operation_id =  411467