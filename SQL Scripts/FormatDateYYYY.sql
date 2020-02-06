Use SAPORDER;
Go

update t
set t.CONTRACTSTART = REPLACE(CONVERT(VARCHAR,CONVERT(DATETIME, t.CONTRACTSTART, 101), 111),'/','')
from OrderDetails t
where t.CONTRACTSTART is not null
Go
update t
set t.ERDAT = REPLACE(CONVERT(VARCHAR,CONVERT(DATETIME, t.ERDAT, 101), 111),'/','')
from OrderDetails t
Go
update t
set t.CONTRACTEND = REPLACE(CONVERT(VARCHAR,CONVERT(DATETIME, t.CONTRACTEND, 101), 111),'/','')
from OrderDetails t
Go
update t
set t.AUDAT = REPLACE(CONVERT(VARCHAR,CONVERT(DATETIME, t.AUDAT, 101), 111),'/','')
from OrderDetails t
Go
update t
set t.PODATE = REPLACE(CONVERT(VARCHAR,CONVERT(DATETIME, t.PODATE, 101), 111),'/','')
from OrderDetails t
Go

update OrderDetails
Set TSTAMP = '20171215175218.000000'
go

use SAPORDER;
go

--REPLACE(CONVERT(VARCHAR,CONVERT(DATETIME, t.CONTRACTSTART, 101), 111),'/','')

select Replace(convert(varchar, convert(time, erzet, 108), 108), ':', '')
from tempOrderDetails
where SDDOCNUMBER = '0002338666'
go

select erzet
from tempOrderDetails
go

update t
set t.ERZET = Replace(convert(varchar, convert(time, erzet, 108), 108), ':', '')
from tempOrderDetails t
where TSTAMP = '20171215175218.000000'
Go