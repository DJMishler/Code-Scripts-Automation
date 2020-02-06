use CorruptionTest
Go
Select Objectname, [name], index_id, type_desc
from
(SELECT OBJECT_NAME(object_id)Objectname, name, index_id, type_desc 
 FROM sys.indexes
)x
where Objectname = 'FamilyBonus'

DBCC IND (CorruptionTest, 'FamilyBonus', 1)

--We are going to use the page type of 1, which mimicks a data file, passing also the PagePID of 320
DBCC TRACEON(3604)
DBCC PAGE(CorruptionTest, 1, 320, 1)

--To corrupt the data, we're going to use Slot 0, offset 0x60, which you need to translate from hex to decimal
--The hex to decimal result of 0x60 = 96

/* To get to the page that holds your data open up your tool, and open up the mdf file.
Step 1: Goto Address and type the value from the following equation page x 8192 + Offset; so it's 320 x 8192 + 96 = 2621536
Step 2: Select Edit-Block <n> chars... Click ok, which should turn those values in red, and just corrupt the data by ovewriting the values in red to 00
Step 3: Save the file, and bring database backonline.
*/