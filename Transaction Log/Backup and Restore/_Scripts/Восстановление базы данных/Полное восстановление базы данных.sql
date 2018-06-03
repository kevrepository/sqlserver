/*
    RESTORE DATABASE { database_name | @database_name_var }   
     [ FROM <backup_device> [ ,...n ] ]  
     [ WITH   
       {  
        [ RECOVERY | NORECOVERY | STANDBY =   
            {standby_file_name | @standby_file_name_var }   
           ]  
       | ,  <general_WITH_options> [ ,...n ]  
       | , <replication_WITH_option>  
       | , <change_data_capture_WITH_option>  
       | , <FILESTREAM_WITH_option>  
       | , <service_broker_WITH options>   
       | , \<point_in_time_WITH_options—RESTORE_DATABASE>   
       } [ ,...n ]  
     ]
    [;]

    <backup_device>::=  
    {   
       { logical_backup_device_name |  
          @logical_backup_device_name_var }  
     | { DISK    -- Does not apply to SQL Database Managed Instance
         | TAPE  -- Does not apply to SQL Database Managed Instance
         | URL   -- Applies to SQL Server and SQL Database Managed Instance
       } = { 'physical_backup_device_name' |  
          @physical_backup_device_name_var }   
    } 

    <general_WITH_options> [ ,...n ]::=   
    --Restore Operation Options  
       MOVE 'logical_file_name_in_backup' TO 'operating_system_file_name'   
              [ ,...n ]   
     | REPLACE   
     | RESTART   
     | RESTRICTED_USER  | CREDENTIAL  

    --Backup Set Options  
     | FILE = { backup_set_file_number | @backup_set_file_number }   
     | PASSWORD = { password | @password_variable }   

    --Media Set Options  
     | MEDIANAME = { media_name | @media_name_variable }   
     | MEDIAPASSWORD = { mediapassword | @mediapassword_variable }   
     | BLOCKSIZE = { blocksize | @blocksize_variable }   

    --Data Transfer Options  
     | BUFFERCOUNT = { buffercount | @buffercount_variable }   
     | MAXTRANSFERSIZE = { maxtransfersize | @maxtransfersize_variable }  

    --Error Management Options  
     | { CHECKSUM | NO_CHECKSUM }   
     | { STOP_ON_ERROR | CONTINUE_AFTER_ERROR }   

    --Monitoring Options  
     | STATS [ = percentage ]   

    --Tape Options. Does not apply to SQL Database Managed Instance
     | { REWIND | NOREWIND }   
     | { UNLOAD | NOUNLOAD }   
*/

RESTORE DATABASE databas_name
FROM DISK = 'A:\ServerName_InstanceName_DatabaseName_BackupType_Date_Time_1.bak'
    ,DISK = 'B:\ServerName_InstanceName_DatabaseName_BackupType_Date_Time_2.bak'
WITH FILE = 1, REPLACE, STATS = 10;
GO
