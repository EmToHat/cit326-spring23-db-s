/* HR Database */
-- This file creates two schemas, hr and office.
-- After creating the schemas this file then transfers the tables into the new schemas.

USE HR_db;
GO

CREATE SCHEMA hr;
GO
-- ---------------------------------------------------------

USE HR_db;
GO

CREATE SCHEMA office;
GO

-- ---------------------------------------------------------

USE HR_db;
GO

-- hr schema
ALTER SCHEMA hr
TRANSFER dbo.dependents;
GO

ALTER SCHEMA hr
TRANSFER dbo.employees;
GO

-- office schema
ALTER SCHEMA office
TRANSFER dbo.countries;
GO

ALTER SCHEMA office
TRANSFER dbo.departments;
GO

ALTER SCHEMA office
TRANSFER dbo.jobs;
GO

ALTER SCHEMA office
TRANSFER dbo.locations;
GO

ALTER SCHEMA office
TRANSFER dbo.regions;
GO