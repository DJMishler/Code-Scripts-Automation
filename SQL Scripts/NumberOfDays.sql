declare @i int = 0

Create table #Temp
(
	id int
)


While @i < 366
Begin
	Insert INTO #Temp Values(@i)
	Set @i = @i +1
End

--Select * from #Temp
Select count(1) WeekendDays
From
(
Select ID, DATEPART(dw, dateadd(dd, ID, '20180301')) [DayofWeek]
from #Temp
Where ID <= datediff(dd, '20180301', '20180430')
and DATEPART(dw, dateadd(dd, ID, '20180301')) IN (1,7)
)x

Drop Table #Temp