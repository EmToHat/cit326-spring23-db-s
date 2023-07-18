-- Author: Emilee Hatch
-- Date: Thur May 18, 2023
-- Assignment: Week 04 Scenario 


SELECT 
	bak.database_name
    , backuptype = CASE
        WHEN bak.type = 'D' AND bak.is_copy_only = 0 THEN 'Full Database'
        WHEN bak.type = 'D' AND bak.is_copy_only = 1 THEN 'Full Copy-Only Database'
        WHEN bak.type = 'I' THEN 'Differential database backup'
        WHEN bak.type = 'L' THEN 'Transaction Log'
        WHEN bak.type = 'F' THEN 'File or filegroup'
        WHEN bak.type = 'G' THEN 'Differential file'
        WHEN bak.type = 'P' THEN 'Partial'
        WHEN bak.type = 'Q' THEN 'Differential partial'
        END + ' Backup'
    , CASE bumf.device_type
        WHEN 2		THEN	'Disk'
        WHEN 5		THEN	'Tape'
        WHEN 7		THEN	'Virtual device'
        WHEN 9		THEN	'Azure Storage'
        WHEN 105	THEN	'A permanent backup device'
        ELSE				'Other Device'
        END							AS 'Device Type'
    , bums.software_name			AS 'Backup Software'
	, bak.recovery_model
	, bak.compatibility_level
	, 'Backup Start Date' = bak.Backup_Start_Date
	, 'Backup Finish Date' = bak.Backup_Finish_Date
	, 'Latest Backup Location' = bumf.physical_device_name
	, 'Backup Size MB' = CONVERT(DECIMAL(10, 2), bak.backup_size / 1024. / 1024.)
	, 'Compressed Backup Size MB' = CONVERT(DECIMAL(10, 2), bak.compressed_backup_size / 1024. / 1024.)
	, 'Database Backup lsn' -- For tlog and differential backups, this is the checkpoint_lsn of the FULL backup it is based on.
    , 'Checkpoint lsn'
	, 'Begins Log Chain'
	, bums.is_password_protected
FROM 
	msdb.dbo.backupset bak
LEFT JOIN 
	msdb.dbo.backupmediafamily bumf
ON 
	bak.[media_set_id] = bumf.[media_set_id]
INNER JOIN 
	msdb.dbo.backupmediaset bums
ON 
	bak.[media_set_id] = bums.[media_set_id]
--WHERE bak.backup_start_date > DATEADD(MONTH, - 2, sysdatetime()) --only look at last two months
ORDER BY 
	bak.database_name ASC
    , bak.Backup_Start_Date DESC;