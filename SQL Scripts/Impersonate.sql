--Impersonate a user in a database
EXECUTE AS USER = 'compass'; 
SELECT  USER_NAME() Impersonated_User; 

Select top 10 * from dbo.InventoryVehicle
--reverts back to regular user
revert