Use master;
Go

DBCC SQLPERF(Logspace)
Go

Select log_reuse_wait, log_reuse_wait_desc from sys.databases
where name = 'EFTAudit';
Go

DBCC OpenTran('EFTAudit');
Go

sp_who2 'active'