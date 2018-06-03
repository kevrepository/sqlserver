sp_configure 'show advanced options', 1;

GO

RECONFIGURE;

GO

sp_configure 'blocked process threshold', 10;

GO

RECONFIGURE;

GO

sp_configure 'show advanced options', 0;

GO

RECONFIGURE;

GO