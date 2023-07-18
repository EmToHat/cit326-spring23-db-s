ALTER SCHEMA final_schema1
TRANSFER dbo.jobs;
GO

ALTER SCHEMA final_schema1
TRANSFER dbo.locations;
GO

ALTER SCHEMA final_schema1
TRANSFER dbo.departments;
GO

ALTER SCHEMA final_schema2
TRANSFER dbo.employees;
GO

ALTER SCHEMA final_schema2
TRANSFER dbo.dependents;
GO

ALTER SCHEMA final_schema3
TRANSFER dbo.countries;
GO

ALTER SCHEMA final_schema3
TRANSFER dbo.regions;
GO