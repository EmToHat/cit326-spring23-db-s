SELECT
	*
FROM
	BLE.Bowlers;

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


SELECT
	*
FROM
	BLE.bowlers_list