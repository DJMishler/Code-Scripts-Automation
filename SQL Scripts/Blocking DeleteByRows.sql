--Sample Delete By Rows at a time to reduce blocking

SET ROWCOUNT 500
delete_more:
     DELETE FROM LogMessages WHERE LogDate < '2/1/2002'
IF @@ROWCOUNT > 0 GOTO delete_more
SET ROWCOUNT 0