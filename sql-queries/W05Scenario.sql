-- SHOW 1
/*
Show the updated table with the new email column and data that was added. 
(If you already encrypted the value in a future step, you can simply show the 
commands you used in this step along with the encrypted contents.)
*/

SELECT *
FROM BLE.Bowlers;

ALTER TABLE BLE.Bowlers
ADD BowlerEmailAddress NVARCHAR (50) NULL;

SELECT
	b.BowlerFirstName
	, b.BowlerLastName
	, LOWER(CONCAT(TRIM(b.BowlerFirstName),TRIM(b.BowlerLastName), '@gmail.com')) AS BowlerEmailAddress
FROM BLE.Bowlers AS b
WHERE 1=1;

UPDATE b SET   
	b.BowlerEmailAddress = LOWER(CONCAT(TRIM(b.BowlerFirstName),TRIM(b.BowlerLastName), '@gmail.com'))
FROM BLE.Bowlers AS b
WHERE 1=1;

-- --------------------------------------------------------------------------------

-- SHOW 2
/*
Login to the accounts - show that the view for Bob works, and the view for Carol works.
Provide a screenshot that shows that the personal information (other than first and last name) is not displayed in the results.
*/

-- Create a new Login/User for bob_the_scorekeeper
USE [master]
GO
CREATE LOGIN [bob_the_scorekeeper] WITH PASSWORD=N'135@!*nIMp02' MUST_CHANGE, DEFAULT_DATABASE=[BowlingLeagueExample], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO


-- Create a view for the new login/user
CREATE VIEW BLE.bowlers_list
AS
SELECT
    BowlerFirstName AS first_name
	, BowlerMiddleInit AS middle_init
    , BowlerLastName AS last_name
	, BowlerCity AS city
	, BowlerState AS state
	, BowlerZip AS zip
FROM
    BLE.Bowlers;

-- Grant access to this view
SELECT 
	*
FROM
	BLE.bowlers_list;


-- --------------------------------------------------------------------------------
-- SHOW 3
/*
Login as Carol and show that she sees encrypted values for the address, phone and email columns.
Show the tables and views they are able to see.
*/


-- Create a view for the new login/user for carol_the_programmer

USE [BowlingLeagueExample]
GO
CREATE USER [carol_the_programmer] FOR LOGIN [carol_the_programmer] WITH DEFAULT_SCHEMA=[BLE]
GO
use [BowlingLeagueExample]
GO
GRANT INSERT ON [BLE].[Bowlers] TO [carol_the_programmer]
GO
use [BowlingLeagueExample]
GO
GRANT SELECT ON [BLE].[Bowlers] TO [carol_the_programmer]
GO



-- --------------------------------------------------------------------------------
-- SHOW 4
/*
Your connections to your classmate’s database (one as Bob, one as Carol).
What you were able to see and do when logged in as each account. 
NOTE: You are not required to submit anything regarding what they found in your database
(only what you saw in theirs).
*/