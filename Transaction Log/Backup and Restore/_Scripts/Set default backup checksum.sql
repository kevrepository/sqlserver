/*
    SELECT *
    FROM   sys.configurations
    WHERE  name = 'backup checksum default';
*/

EXEC sp_configure 'backup checksum default', 1;
GO

RECONFIGURE;
GO