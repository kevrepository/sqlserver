/*
RESTORE FILELISTONLY 
    FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\AdventureWorks2014.bak'
    WITH FILE = 1;
*/

RESTORE DATABASE AdventureWorks2014Restore
    FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\AdventureWorks2014.bak'
    WITH
        MOVE N'AdventureWorks2014_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014Restore_Data.mdf'
       ,MOVE N'AdventureWorks2014_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014Restore_Log.ldf'
       ,STATS = 5
       ,RECOVERY;
GO