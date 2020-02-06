Use Salesforce;
Go

Select COLUMN_NAME, DATA_TYPE from INFORMATION_SCHEMA.COLUMNS
Where TABLE_SCHEMA = 'dbo'
and TABLE_NAME = 'User'
and DATA_TYPE = 'ntext'
GO
