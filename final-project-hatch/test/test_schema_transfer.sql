USE HR_db;
GO

-- test_hr schema
ALTER SCHEMA test_hr
TRANSFER dbo.dependents;
GO

ALTER SCHEMA test_hr
TRANSFER dbo.employees;
GO

-- test_office schema
ALTER SCHEMA test_office
TRANSFER dbo.countries;
GO

ALTER SCHEMA test_office
TRANSFER dbo.departments;
GO

ALTER SCHEMA test_office
TRANSFER dbo.jobs;
GO

ALTER SCHEMA test_office
TRANSFER dbo.locations;
GO

ALTER SCHEMA test_office
TRANSFER dbo.regions;
GO
