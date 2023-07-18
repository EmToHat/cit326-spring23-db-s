-- Emilee Hatch
-- I followed along the video. 

ALTER SCHEMA office TRANSFER customers;
GO

SELECT 'ALTER SCHEMA office TRANSFER ' + name + ';' FROM sys.tables;

ALTER SCHEMA office TRANSFER Employees;
ALTER SCHEMA office TRANSFER Order_Details;
ALTER SCHEMA office TRANSFER Orders;