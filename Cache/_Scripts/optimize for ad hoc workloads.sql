/*
    SELECT *
    FROM   sys.configurations
    WHERE  name = 'optimize for ad hoc workloads';
*/

EXEC sp_configure 'optimize for ad hoc workloads', 1;
GO

RECONFIGURE;
GO