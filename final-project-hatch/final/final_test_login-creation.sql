USE [master]
GO
CREATE LOGIN [final_test_login] WITH PASSWORD=N'8&%57@nBg32!', DEFAULT_DATABASE=[HR_db], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
use [master];
GO
USE [HR_db]
GO
CREATE USER [final_test_user] FOR LOGIN [final_test_login]
GO
USE [HR_db]
GO
ALTER ROLE [db_datareader] ADD MEMBER [final_test_login]
GO
