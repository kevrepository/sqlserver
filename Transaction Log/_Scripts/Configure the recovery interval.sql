USE database_name;
GO

EXEC sp_configure 'show advanced options', 1;
GO

RECONFIGURE;
GO

EXEC sp_configure 'recovery interval', 3;
GO
  
RECONFIGURE;
GO