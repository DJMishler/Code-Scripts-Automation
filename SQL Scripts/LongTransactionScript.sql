DECLARE @spid INT
DECLARE spids CURSOR
    FAST_FORWARD FOR
    SELECT SPID
    FROM master..sysprocesses (NOLOCK)
    WHERE spid>50 
    AND status='sleeping' 
    AND program_name = 'Report Server'
    AND open_tran > 0
    AND last_batch < DateAdd(hour, -12, GETDATE())

OPEN spids
FETCH NEXT FROM spids INTO @spid
WHILE (@@FETCH_STATUS=0)
BEGIN
   --PRINT 'Killing orphaned Report Server SPID: '+CONVERT(VARCHAR,@spid)
   EXEC('KILL '+@spid)
   FETCH NEXT FROM spids INTO @spid
END

CLOSE spids
DEALLOCATE spids