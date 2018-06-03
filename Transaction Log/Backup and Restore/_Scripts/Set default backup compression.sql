/*
    SELECT *
    FROM   sys.configurations
    WHERE  name = 'backup compression default';
*/

EXEC sp_configure 'backup compression default', 1;
GO

RECONFIGURE;
GO