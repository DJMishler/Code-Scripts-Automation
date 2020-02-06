Use AdventureWorks2017;
Go

SELECT OrderQty,[Name],ListPrice, CustomerID
FROM sales.SalesOrderHeader JOIN sales.SalesOrderDetail
ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN Production.Product
ON SalesOrderDetail.ProductID=Product.ProductID
WHERE CustomerID=29825
