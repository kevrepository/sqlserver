/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/backup-transact-sql?view=sql-server-2017

    BACKUP DATABASE { database_name | @database_name_var }   
      TO <backup_device> [ ,...n ]   
      [ <MIRROR TO clause> ] [ next-mirror-to ]  
      [ WITH { DIFFERENTIAL | <general_WITH_options> [ ,...n ] } ]  
    [;]

    <backup_device>::= 
    {
      { logical_device_name | @logical_device_name_var }   
    | {   DISK
        | TAPE
        | URL } =   
        { 'physical_device_name' | @physical_device_name_var | 'NUL' }  
    }

    <general_WITH_options> [ ,...n ]::=   
        --Backup Set Options  
          COPY_ONLY  
        | { COMPRESSION | NO_COMPRESSION }   
        | DESCRIPTION = { 'text' | @text_variable }   
        | NAME = { backup_set_name | @backup_set_name_var }   
        | CREDENTIAL
        | ENCRYPTION 
        | FILE_SNAPSHOT
        | { EXPIREDATE = { 'date' | @date_var } | RETAINDAYS = { days | @days_var } }   

        --Media Set Options  
          { NOINIT | INIT }   
        | { NOSKIP | SKIP }   
        | { NOFORMAT | FORMAT }   
        | MEDIADESCRIPTION = { 'text' | @text_variable }   
        | MEDIANAME = { media_name | @media_name_variable }   
        | BLOCKSIZE = { blocksize | @blocksize_variable }   

        --Data Transfer Options
          BUFFERCOUNT = { buffercount | @buffercount_variable }   
        | MAXTRANSFERSIZE = { maxtransfersize | @maxtransfersize_variable }  

        --Error Management Options
          { NO_CHECKSUM | CHECKSUM }
        | { STOP_ON_ERROR | CONTINUE_AFTER_ERROR }

        --Monitoring Options  
        STATS [ = percentage ]   

        --Tape Options. These are not supported in SQL Database Managed Instance
          { REWIND | NOREWIND }   
        | { UNLOAD | NOUNLOAD }   

        --Log-specific Options. These are not supported in SQL Database Managed Instance 
          { NORECOVERY | STANDBY = undo_file_name }  
        | NO_TRUNCATE  

        --Encryption Options  
        ENCRYPTION (ALGORITHM = { AES_128 | AES_192 | AES_256 | TRIPLE_DES_3KEY } , encryptor_options ) <encryptor_options> ::=   
            SERVER CERTIFICATE = Encryptor_Name | SERVER ASYMMETRIC KEY = Encryptor_Name   
*/

BACKUP DATABASE databas_name
    TO DISK = 'A:\ServerName_InstanceName_DatabaseName_BackupType_Date_Time_1.bak'
      ,DISK = 'B:\ServerName_InstanceName_DatabaseName_BackupType_Date_Time_2.bak'
    MIRROR TO DISK = 'C:\ServerName_InstanceName_DatabaseName_BackupType_Date_Time_1.bak'
             ,DISK  = 'D:\ServerName_InstanceName_DatabaseName_BackupType_Date_Time_2.bak'
    WITH INIT, FORMAT, CHECKSUM, COMPRESSION;
GO