USE master;
GO

EXEC sp_configure 'show advanced options', 1;
GO

RECONFIGURE;
GO

EXEC sp_configure 'contained database authentication', '1';
GO

RECONFIGURE WITH OVERRIDE;
GO

ALTER DATABASE database_name
    SET CONTAINMENT = PARTIAL
    WITH NO_WAIT;
GO

USE database_name;
GO

CREATE USER user_name
    WITH PASSWORD = 'Pa$$w0rd';
GO