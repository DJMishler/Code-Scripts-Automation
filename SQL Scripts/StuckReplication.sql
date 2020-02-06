Use distribution
go
Select * from MSrepl_errors
Order by time desc
go

exec sp_browsereplcmds '0x00039682000299B801A100000000', '0x00039682000299B801A100000000'
Go

Select * from distribution.dbo.MSarticles Where article_id in (Select article_id From MSrepl_commands where xact_seqno = 0x00039682000299B801A1)


