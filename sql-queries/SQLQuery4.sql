-- Author: Emilee Hatch
-- Date: May 18th, 2023
-- Assignment: Week 05 Stepping Stone
CREATE VIEW 
	order_retail_vs_quoted
AS

SELECT 
	OD.OrderNumber		AS 'Order Number' 
	, PR.Productname	AS 'Product Name'
	, PR.RetailPrice	AS 'Retail Price'
	, OD.QuotedPrice	AS 'Quoted Price'
FROM
	Order_Details OD
INNER JOIN
	Products PR
ON 
	OD.ProductNumber = PR.ProductNumber;

-- -------------------------
SELECT 
      *
FROM 
	order_retail_vs_quoted;