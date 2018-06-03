-- 1.
BACKUP DATABASE database_name TO DISK = N'physical_device_name'
    WITH FORMAT;

GO

/*
RESTORE FILELISTONLY FROM DISK = N'physical_backup_device_name';

GO

RESTORE DATABASE database_name FROM DISK = 'physical_backup_device_name'
    WITH NORECOVERY
        ,MOVE 'logical_file_name_in_backup' TO 'operating_system_file_name';
GO
*/

-- 2.
BACKUP LOG database_name TO DISK = N'physical_device_name'
    WITH FORMAT;

GO
/*
RESTORE LOG database_name FROM DISK = N'physical_backup_device_name'
   WITH FILE = 1
       ,NORECOVERY;
GO
*/