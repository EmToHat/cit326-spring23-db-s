USE [master]
GO
CREATE LOGIN [final_running_buddy_login] WITH PASSWORD=N'0(Mc#32@!xD*', DEFAULT_DATABASE=[HR_db], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
use [master];
GO
USE [HR_db]
GO
CREATE USER [final_running_buddy] FOR LOGIN [final_running_buddy_login]
GO
USE [HR_db]
GO
ALTER ROLE [db_datareader] ADD MEMBER [final_running_buddy]
GO
