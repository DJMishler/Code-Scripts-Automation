declare @i int = 1

Create Table #Temp
(
	ID int
)

While @i <= 52
Begin
	Insert Into #Temp Values(@i)
	Set @i = @i + 1
End

Select ID Num, SalesForTheWeek
From #Temp tmp
Left JOIN 
(Select SUM(TotalSalePrice) as SalesForTheWeek, DATEPART(wk, SaleDate) WeekNo
from Data.Sales
Where Year(SaleDate) = 2016
Group by DATEPART(wk, SaleDate)
) sls ON tmp.ID = sls.WeekNo

Drop Table #Temp