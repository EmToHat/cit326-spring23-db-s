-- SELECT statements
-- Testing the accessibility of user final_test_login/final_test_user

USE HR_db;
GO

-- Has access to the hr schema.
SELECT 
	*
FROM
	hr.dependents;
GO

-- Doesn't have access to the office schema.
SELECT
	*
FROM
	office.countries;
GO

SELECT 
	*
FROM
	office.departments;
GO

SELECT 
	*
FROM
	office.jobs;
GO

SELECT 
	*
FROM
	office.locations;
GO

SELECT 
	*
FROM
	office.regions;
GO


-- View
SELECT
	*
FROM final_view;
GO
