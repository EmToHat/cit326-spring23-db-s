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


/*
Scenario 1 Description:

The owner of the bowling league, Karl, recently had a scare when a Chicago ice storm 
knocked the power out and the database server went down. 
Luckily, everything powered back on and came online. 
This was enough for him to ask you, "What could we have done if the server was corrupted and the data was no longer readable?"

You ask a few more questions and find out that he would be totally satisfied
if he knew he could at least get back to the information at the end of each night, 
after all of the leagues and players are finished. 
He isn't worried about up to the minute changes or data loss during the day. 
Though he would like to have peace of mind, 
he is also worried about incurring extra server and disk space costs for his bowling 
alley that is barely turning a profit (even with insane margins on cheap food). 
In other words, he wants to have a nightly recovery plan with the lowest possible amount of disk space usage.
*/


/*
SHOW 1: 
Tell what recovery model you chose and explain why.
Your suggested implementation for this scenario. 
Demonstrate your implementation plan by making various backup(s), transaction(s) (inserts, updates, or deletes) 
and a restore (or restores) for Karl using your plan.
*/

-- Full Backups and Differential Backups

-- One Maintenance Plan
-- Two Separate Jobs

-- Full backup occurs on sunday @8:00pm
-- Differential Backup occurs daily @6:00pm









-------------------------------------

-- Scenario 2

/*
Scenario 2 Description:

	The CIO (Chief Information Officer) of Wide World Importers is concerned about data loss. 

	The company is growing fast and has extra budget to spare to cover needs. 

	He says he can't afford to lose sleep worrying about whether the company's IT needs are keeping up with the growth. 

	He asks you to do whatever it takes to come up with the most complete and constant coverage possible.
*/

/*
- SHOW 2: 
	Tell what recovery model you chose and explain why.

	Your suggested implementation for this scenario. 

	Demonstrate your implementation plan by making various backup(s), transaction(s) 
	(inserts, updates, or deletes) and a restore (or restores) for the CIO using your plan.

- HINTS:
	This video from the weekly preparation post (please remember to go through the preparation material each week) 
	could help you with your plan and demonstration.

	Check Chapter 16 on how to display and change database recovery models.

	Would the executive feel comfortable with your recovery solution? 
	If you are not giving the executive thorough examples of data being deleted and then 
	recovered, how can he/she feel good about it? (This should be a longer video than average.)

	If you are looking to do some havoc with DELETES, you will need to find tables that do not 
	have other tables depending on them that prevent DELETES. You can run this data dictionary 
	query in each database to find such tables:

		Be sure to ‘USE’ the database you want first:
			SELECT t.NAME AS TableName
			FROM sys.Tables t
			LEFT JOIN sys.sql_expression_dependencies d ON d.referenced_id = t.object_id
			WHERE d.referenced_id IS NULL;
*/