-- Author: Emilee Hatch
-- Date: Thur May 18, 2023
-- Assignment: Week 04 Scenario 

/*
	Question 1.
		Use the data dictionary to write a query to find out 
		when the last time all of your databases were backed up.
*/
-- Show 1. 
SELECT 
	-- *
	baks.database_name AS 'Database Backup Name'
	, CASE
		WHEN 
			baks.type = 'D' 
			AND 
			baks.is_copy_only = 0 
		THEN 'Full Database Backup'

		WHEN
			 baks.type = 'D' 
			 AND 
			 baks.is_copy_only = 1 
		THEN 'Full Copy-Only Database Backup'
		
		WHEN
			baks.type = 'I' 
		THEN 'Differential Database Backup'

		WHEN 
			baks.type = 'L' 
		THEN 'Transaction Log Backup'

		WHEN 
			baks.type = 'F' 
		THEN 'File or Filegroup Backup'

		WHEN 
			baks.type = 'G' 
		THEN 'Differential File Backup'

		WHEN 
			baks.type = 'P' 
		THEN 'Partial Backup'

		WHEN 
			baks.type = 'Q' 
		THEN 'Differential Partial Backup'

		END AS 'Backup Type'
	, CASE bakmf.device_type
		 WHEN 
			2 
		 THEN 'Disk'

		 WHEN 
			5 
		THEN 'Tape'

		WHEN 
			7 
		THEN 'Virtual device'

		WHEN 
			9 
		THEN 'Azure Storage'
		
		WHEN 
			105 
		THEN 'A permanent backup device'

		ELSE 'Other Device'

	END AS 'Device Type'
	, bakms.software_name																				AS 'Backup Software'
	--, baks.recovery_model																				AS 'Recovery Model'
	--, baks.compatibility_level																			AS 'Compatibility Level'
	, baks.Backup_Start_Date																			AS 'Backup Start Date'
	, baks.Backup_Finish_Date																			AS 'Backup End Date'
	, bakmf.physical_device_name																		AS 'Latest Backup Location'
	--, CONVERT(DECIMAL(10, 2), baks.backup_size / 1024. / 1024.)											AS 'Backup Size MB'
    --, CONVERT(DECIMAL(10, 2), baks.compressed_backup_size / 1024. / 1024.)								AS 'Compressed Backup Size MB'
		-- For tlog and differential backups, this is the checkpoint_lsn of the FULL backup it is based on.
    --, database_backup_lsn																				AS 'Database Backup lsn'
    --, checkpoint_lsn																					AS 'Checkpoint lsn'
    --, begins_log_chain																					AS 'Begins Log Chain'
    --, bakms.is_password_protected																		AS 'Password Protected'
FROM 
	msdb.dbo.backupset baks
LEFT JOIN 
	msdb.dbo.backupmediafamily bakmf
ON 
	baks.[media_set_id] = bakmf.[media_set_id]
INNER JOIN 
	msdb.dbo.backupmediaset bakms
ON 
	baks.[media_set_id] = bakms.[media_set_id]
-- WHERE 
	-- baks.backup_start_date > DATEADD(MONTH, - 2, sysdatetime()) --only look at last two months
ORDER BY 
	baks.database_name ASC
    , baks.Backup_Start_Date DESC;


/*
	Question 2.
		Make new backups for ALL of your user databases 
		(not system databases).
*/
-- Show 2.
BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample.bak' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
BACKUP DATABASE [EntertainmentAgencyExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\EntertainmentAgencyExample.bak' WITH NOFORMAT, NOINIT,  NAME = N'EntertainmentAgencyExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
BACKUP DATABASE [RecipesExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\RecipesExample.bak' WITH NOFORMAT, NOINIT,  NAME = N'RecipesExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
BACKUP DATABASE [SalesOrdersExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\SalesOrdersExample.bak' WITH NOFORMAT, NOINIT,  NAME = N'SalesOrdersExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
BACKUP DATABASE [sample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\sample_LogBackup_2023-05-18_09-26-43.bak' WITH NOFORMAT, NOINIT,  NAME = N'sample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
BACKUP DATABASE [SchoolSchedulingExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\SchoolSchedulingExample.bak' WITH NOFORMAT, NOINIT,  NAME = N'SchoolSchedulingExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
BACKUP DATABASE [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\WideWorldImporters.bak' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


/*
	Question 3.
		You decide to make copies of the bowling 
		database for test purposes:
			
			a.	Restore the bowling database using your backup from step 2.
				However, you should restore it within your instance with 
				the new name, "bowling_TEST." Be sure the internal database 
				file names are also changed as part of the restore.

			b.	Use the videos this week to login to the class server 
				in the cloud and restore it there also. 
				You will consider this copy to be a development version. 
				Change the name of the bowling database to start 
				with your last name such as "jones_bowling_development." 
				Again be sure to change your file names.

				
*/
-- Show 3.
USE [master]
BACKUP LOG [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample_LogBackup_2023-05-18_20-23-29.bak' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample_LogBackup_2023-05-18_20-23-29', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [bowling_TEST] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample.bak' WITH  FILE = 3,  MOVE N'BowlingLeagueExample' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\bowling_TEST.mdf',  MOVE N'BowlingLeagueExample_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\bowling_TEST_log.ldf',  NOUNLOAD,  STATS = 5

GO

-- hatch_bowling_development in the class server




/*
	Question 4.
		Now that you have a local test database, we need to be prepared to 
		refresh certain tables after the live data changes in production 
		(we will say production is your local laptop). You will need to 
		practice backing up and reloading individual tables (instead of whole databases). 
		For this, we will not use backup/restore. We will use the BCP utility outlined 
		in this week's preparation page (and chapter 15 of the book) or in the video in step 2 below.

			a.	Make sure you have a recent backup of your bowling database (you should have this 
				from the above steps).

			b.	Use this student example to run a bcp export on the Bowler_scores and Bowlers tables 
				from your original (production) bowling database on your laptop. 
				
				HINT: Be sure to change your bcp commands to match your own schema names and 
				folder path on your laptop, as they will likely differ from what the video uses 
				(you will probably have something other than the bowlingadmin schema).

			c.	Validate your export files from step b exist. Run two deletes to wipe out all 
				data in the Bowler_scores and Bowlers tables on your laptop. 
				
				NOTE: You will need to delete the rows from the Bowler_scores table first due 
				to foreign key dependencies.

			d.	Run a bcp import to reload both tables using your export files created in step b.
*/

-- Show 4.