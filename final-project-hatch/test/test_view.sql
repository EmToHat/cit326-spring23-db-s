USE HR_db;
GO

CREATE VIEW test_view AS

SELECT 
	CONCAT(emp.first_name, ' ', emp.last_name) AS 'Employee Name'
	, CONCAT(depn.first_name, ' ', depn.last_name) AS 'Employee Dependent'
	, depn.relationship AS 'Relationship'
	--, j.job_title AS 'Job'
FROM
	test_office.departments d
INNER JOIN
	test_hr.employees emp
ON
	d.department_id = emp.department_id
INNER JOIN
	test_hr.dependents depn 
ON 
	emp.employee_id = depn.employee_id
WHERE 
	emp.last_name LIKE '%r'
OR
	emp.last_name LIKE '%a';
