-- Dropping the transactional subscriptions
use [VantiveData]
exec sp_dropsubscription @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPLMSQLCL01', @destination_db = N'ReplicaCRMDB', @article = N'all'
GO
use [VantiveData]
exec sp_dropsubscription @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaCRMDB', @article = N'all'
GO
use [VantiveData]
exec sp_dropsubscription @publication = N'VantiveData__SW_ADDRESS', @subscriber = N'FTLPSQLCL07', @destination_db = N'ReplVantiveSFDC', @article = N'all'
GO

-- Dropping the transactional articles
use [VantiveData]
exec sp_dropsubscription @publication = N'VantiveData__SW_ADDRESS', @article = N'SW_ADDRESS', @subscriber = N'all', @destination_db = N'all'
GO
use [VantiveData]
exec sp_droparticle @publication = N'VantiveData__SW_ADDRESS', @article = N'SW_ADDRESS', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [VantiveData]
exec sp_droppublication @publication = N'VantiveData__SW_ADDRESS'
GO

