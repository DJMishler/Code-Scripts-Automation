--Resize TempDB
USE master;
GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'tempdev', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'temp2', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'temp3', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'temp4', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'temp5', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'temp6', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'temp7', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'temp8', SIZE = 20480MB)
	GO
	ALTER DATABASE [TempDB] MODIFY FILE (NAME = N'templog', SIZE = 10240MB)
	GO