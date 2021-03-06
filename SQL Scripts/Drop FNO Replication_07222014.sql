
-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @article = N'OPS_ACTIVATABLE_ITEM', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops__OPS_ACTIVATABLE_ITEM', @article = N'OPS_ACTIVATABLE_ITEM', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops__OPS_ACTIVATABLE_ITEM'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @article = N'OPS_ACTIVATION_INSTANCE', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops__OPS_ACTIVATION_INSTANCE', @article = N'OPS_ACTIVATION_INSTANCE', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops__OPS_ACTIVATION_INSTANCE'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @article = N'OPS_ENTITLEMENT_PRODUCT', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT', @article = N'OPS_ENTITLEMENT_PRODUCT', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops__OPS_ENTITLEMENT_PRODUCT'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'fnpops__OPS_HOST_ENTITY', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'fnpops__OPS_HOST_ENTITY', @article = N'OPS_HOST_ENTITY', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'fnpops__OPS_HOST_ENTITY', @article = N'OPS_HOST_ENTITY', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'fnpops__OPS_HOST_ENTITY'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PLT_ORGUNIT', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PLT_ORGUNIT', @article = N'PLT_ORGUNIT', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops__PLT_ORGUNIT', @article = N'PLT_ORGUNIT', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops__PLT_ORGUNIT'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PLT_USER', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PLT_USER', @article = N'PLT_USER', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops__PLT_USER', @article = N'PLT_USER', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops__PLT_USER'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'fnpops__PROD_LICENSE_MODEL', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'fnpops__PROD_LICENSE_MODEL', @article = N'PROD_LICENSE_MODEL', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'fnpops__PROD_LICENSE_MODEL', @article = N'PROD_LICENSE_MODEL', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'fnpops__PROD_LICENSE_MODEL'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'fnpops__PROD_ORDERABLE', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'fnpops__PROD_ORDERABLE', @article = N'PROD_ORDERABLE', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'fnpops__PROD_ORDERABLE', @article = N'PROD_ORDERABLE', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'fnpops__PROD_ORDERABLE'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PROD_ORDERABLE_MODEL', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PROD_ORDERABLE_MODEL', @article = N'PROD_ORDERABLE_MODEL', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops__PROD_ORDERABLE_MODEL', @article = N'PROD_ORDERABLE_MODEL', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops__PROD_ORDERABLE_MODEL'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PROD_SKU', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops__PROD_SKU', @article = N'PROD_SKU', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops__PROD_SKU', @article = N'PROD_SKU', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops__PROD_SKU'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops_OPS_ENT_PARTNER_TIER', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops_OPS_ENT_PARTNER_TIER', @article = N'OPS_ENT_PARTNER_TIER', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops_OPS_ENT_PARTNER_TIER', @article = N'OPS_ENT_PARTNER_TIER', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops_OPS_ENT_PARTNER_TIER'
GO

-- Dropping the transactional subscriptions
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops_OPS_ENTITLEMENT_ORDER', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFnpops', @article = N'all'
GO

-- Dropping the transactional articles
use [fnpops]
exec sp_dropsubscription @publication = N'FNpops_OPS_ENTITLEMENT_ORDER', @article = N'OPS_ENTITLEMENT_ORDER', @subscriber = N'all', @destination_db = N'all'
GO
use [fnpops]
exec sp_droparticle @publication = N'FNpops_OPS_ENTITLEMENT_ORDER', @article = N'OPS_ENTITLEMENT_ORDER', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [fnpops]
exec sp_droppublication @publication = N'FNpops_OPS_ENTITLEMENT_ORDER'
GO



-- Dropping the transactional subscriptions
use [FNOShell]
exec sp_dropsubscription @publication = N'FNOShell_ODS2', @subscriber = N'FTLPODSSQLCL01', @destination_db = N'ReplicaFNOShell', @article = N'all'
GO

-- Dropping the transactional articles
use [FNOShell]
exec sp_dropsubscription @publication = N'FNOShell_ODS2', @article = N'AUDIT_ITEMS', @subscriber = N'all', @destination_db = N'all'
GO
use [FNOShell]
exec sp_droparticle @publication = N'FNOShell_ODS2', @article = N'AUDIT_ITEMS', @force_invalidate_snapshot = 1
GO
use [FNOShell]
exec sp_dropsubscription @publication = N'FNOShell_ODS2', @article = N'AUDIT_TRAIL', @subscriber = N'all', @destination_db = N'all'
GO
use [FNOShell]
exec sp_droparticle @publication = N'FNOShell_ODS2', @article = N'AUDIT_TRAIL', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [FNOShell]
exec sp_droppublication @publication = N'FNOShell_ODS2'
GO



/****** Scripting removing replication objects. Script Date: 7/22/2014 10:51:36 AM ******/
/****** Please Note: For security reasons, all password parameters were scripted with either NULL or an empty string. ******/

-- Disabling the replication database
use master
exec sp_replicationdboption @dbname = N'FNOShell', @optname = N'publish', @value = N'false'
GO

-- Disabling the replication database
use master
exec sp_replicationdboption @dbname = N'fnpops', @optname = N'publish', @value = N'false'
GO


-- Dropping the registered subscriber
exec sp_dropsubscriber @subscriber = N'FTLPODSSQLCL01'
GO

/****** Uninstalling the server as a Distributor. Script Date: 7/22/2014 10:51:36 AM ******/
use master
exec sp_dropdistributor @no_checks = 1, @ignore_distributor = 1
GO
