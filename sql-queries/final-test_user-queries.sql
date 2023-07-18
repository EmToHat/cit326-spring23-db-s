/* Final Test User Queries */

-- Select Statements

SELECT 
	*
FROM 
	final_schema1.departments;

SELECT 
	*
FROM 
	final_schema2.dependents;


-- Views

-- CREATE VIEW view_name AS
-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE condition;

/*
Departments
---
department_id
location_id

Jobs
---
job_id

Locations
---
location_id
country_id

Dependents
---
dependent_id
employee_id

Employees
---
employee_id
manager_id
department_id

Countries
---
country_id
region_id

Regions
---
region_id

*/
CREATE VIEW final_schema1.final_view_schema1 AS

SELECT 
	CONCAT(emp.first_name, ' ', emp.last_name) AS 'Employee Name'
	, CONCAT(depn.first_name, ' ', depn.last_name) AS 'Employee Dependent'
	, depn.relationship AS 'Relationship'
	--, j.job_title AS 'Job'
FROM
	final_schema1.departments d
INNER JOIN
	final_schema2.employees emp
ON
	d.department_id = emp.department_id
INNER JOIN
	final_schema2.dependents depn 
ON 
	emp.employee_id = depn.employee_id
WHERE 
	emp.last_name LIKE '%r'
OR
	emp.last_name LIKE '%a';





/* Database Role */
CREATE ROLE [final_test_role] AUTHORIZATION [dbo];
GO
ALTER ROLE [final_test_role] ADD MEMBER [final_test_user];
GO
GRANT SELECT ON SCHEMA::[final_schema1] TO [final_test_role];
GRANT SELECT ON final_schema1.final_view_schema1 TO final_test_role;
GRANT SELECT ON final_schema3.countries TO final_test_role;
GO

