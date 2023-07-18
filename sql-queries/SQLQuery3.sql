-- Emilee Hatch
-- I followed the video and ran the steps!

USE [master]
GO
CREATE LOGIN [sam_the_clerk] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [SalesOrdersExample]
GO
CREATE USER [sam_the_clerk] FOR LOGIN [sam_the_clerk]
GO
USE [SalesOrdersExample]
GO
ALTER ROLE [db_datareader] ADD MEMBER [sam_the_clerk]
GO
