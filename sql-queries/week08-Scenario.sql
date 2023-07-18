-- Week 08 Scenario
-- Emilee Hatch

-- Notes
/*
	-	What is a recovery model?
		-	A recovery model is a database property that controls how transactions are logged, whether the transaction log requires
			(and allows) backing up, and what kinds of restore operations are available. 

	-	3 Recovery Models exists: 
			1.	Simple
			2.	Full
			3.	Bulk-Logged

		-	Typically a db will use the full or simple recovery model.

		-	A db can be switched to another recovery model at any time.

	-	It is recommended that log backups are taken frequently, both to minimize work loss exposure and to truncate the transaction log.

	-	A db admin typically creates a full db backup on occasion (i.e., weekly) and optionally creates a series of differential
		backups at shorter intervals (i.e., daily)
	
	-----------------

	-	SIMPLE
		-	Description
			-	No log backups.
			-	Automatically reclaims log space to keep space requirement small, essentially eliminating the need 
				to manage the transaction log space. 
			-	Operations that require transaction log backups are not supported by the simple recovery model.
			-	Features not supported: log shipping, Always On or database mirroring, media recovery w/o data loss, point in time restoration.

		-	Work Loss Exposure
			-	Changes since the most recent backup are not protected. If a disaster occurs, the changes need to be redone.

		-	Recover to point in time?
			-	Recovery can be made up until the end of a backup.

	-----------------

	-	FULL
		-	Description
			-	Requires log backups.
			-	Work is not lost due to lost or damamged files.
			-	Can recover to an arbitrary point in time.

		-	Work Loss Exposure
			-	Normally none.
			-	If the tail of the log is damamged, changes since the most recent log backup must be redone.

		-	Recover to point in time?
			-	Can recover to a specific point in time, that is assuming your backups are complete up to that point in time. 

	-----------------

	-	Bulk-Logged
		-	Description
			-	Requires log backups.
			-	An adjunct of the FULL recovery model that permits high-performance bulk copy operations. 
			-	Reduces log space usage by using minimal logging for most bulk operations. 
			-	Log backups may be of a significant size because the minimally-logged operations are captured in the log backup. 

		-	Work Loss Exposure
			-	If the log is damaged or bulk-logged operations occurred since the most recent log backup, changes since that last backup
				must be redone.
			-	Otherwise no work is lost.

		-	Recover to point in time?
			-	Can recover to the end of any backup. 
			-	Point-in-time recovery is not supported.
*/

-- Maintenance Plan: W08-Maintenance-Plan_School-db

/*
	SHOW 1: 
	That the following tasks are present in your maintenance plan and prove they are successful: 
	Check Database Integrity
	Rebuild Index
	Reorganize Indexes and Update Statistics
	Backup Database (Full)
	Cleanup History (optional)
	A schedule for each task to run (even if it is only a combined one-time schedule)

*/



/*
	SHOW 2: 
	The concept you are implementing and explain why it will help the company. 
	The job that will help your implementation and the code inside of each step in the job.
	The results after the job runs successfully.
*/

USE SalesOrdersExample;
GO
SELECT DISTINCT
	CONCAT(c.CustFirstName, ' ', c.CustLastName) AS 'Customer'
	, CONCAT(c.CustStreetAddress, ', ', c.CustCity, ', ', c.CustState, ', ', c.CustZipCode) AS 'Customer''s Address'
	, CONCAT(c.CustAreaCode, '-', c.CustPhoneNumber) AS 'Customer''s Phone Number'
	, p.ProductName AS 'Product Ordered'
	, cd.CategoryDescription As 'Category'
FROM Customers c
	INNER JOIN Orders o
	ON c.CustomerID = o.CustomerID
	INNER JOIN Order_Details o_d
	ON o.OrderNumber = o_d.OrderNumber
	INNER JOIN Products p
	ON o_d.ProductNumber = p.ProductNumber
	INNER JOIN Categories cd
	ON p.CategoryID = cd.CategoryID
WHERE cd.CategoryID = 3;

INSERT INTO Customers
VALUES ('1029', 'Jane', 'Doe', '798 Shady St.', 'Auburn', 'NY', '13021', '000', '000-0000');

DELETE FROM Customers
WHERE CustFirstName = 'Jane' AND CustLastName = 'Doe';