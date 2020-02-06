Use ReportServer;
Go

SELECT 
ex.UserName, ex.Format, ex.TimeStart, cat.Name, ex.Parameters, CONVERT(nvarchar(10), ex.TimeStart, 101) AS rundate
FROM ExecutionLog AS ex INNER JOIN
Catalog AS cat ON ex.ReportID = cat.ItemID
Where name = 'License Report'
ORDER BY ex.TimeStart DESC