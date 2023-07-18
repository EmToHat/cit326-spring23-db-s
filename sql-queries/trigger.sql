CREATE DATABASE DemoDatabase;
GO

DROP TABLE IF EXISTS TestData;
CREATE TABLE TestData
(
	Id int IDENTITY CONSTRAINT Pk_Id PRIMARY KEY
	, ColA INT
	, ColB INT
	, ColC INT
	, LastModifiedDate DATETIME2
	, LastModifiedUser NVARCHAR(30)
);
GO


-- TRIGGER

CREATE TRIGGER AutoLogger ON TestData
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON;

DECLARE
	@CurrentDateTime DATETIME2 = SYSUTCDATETIME()
	, @CurrentUser NCHAR(30) = SYSTEM_USER

UPDATE t
SET
	LastModifiedDate = @CurrentDateTime
	, LastModifiedUser = @CurrentUser
FROM
	TestData t
		INNER JOIN inserted i
			ON t.Id = i.Id;
END



-- Regular Update
INSERT INTO TestData (ColA, ColB, ColC) VALUES (1,2,3);
SELECT * FROM TestData;

-- Regular Update
UPDATE TestData SET ColA = 4 WHERE Id = 1;
SELECT * FROM TestData;


-- Questionable Motive Insert
INSERT INTO TestData (ColA, ColB, ColC, LastModifiedDate, LastModifiedUser)
VALUES(1,2,3, '9999-12-31', 'NotMe');
SELECT * FROM TestData;

-- Questionable Mostive Update
UPDATE TestData SET LastModifiedDate = '9999-12-31', LastModifiedUser = 'NotMe' WHERE Id = 1;
SELECT * FROM TestData;

