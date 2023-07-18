SELECT 
	s.SalesID
	, CONCAT(c.FirstName, ' ', c.LastName) AS 'Customer Name'
	, CONCAT(e.FirstName, ' ', e.LastName) AS 'Employee Name'
	, p.Name AS 'Product'
	, s.Quantity As 'Product Quantity'
FROM 
	final_a.Sales s
INNER JOIN 
	final_a.Customers c
		ON 
		s.CustomerID = c.CustomerID
INNER JOIN
	final_b.Employees e
		ON 
		s.SalesPersonID = e.EmployeeID
INNER JOIN
	final_b.Products p
		ON 
		s.ProductID = p.ProductID;




SELECT
	*
FROM 
	final_a.Customers;