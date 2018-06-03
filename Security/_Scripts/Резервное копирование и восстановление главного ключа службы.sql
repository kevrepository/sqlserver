-- Резервное копирование главного ключа службы.
BACKUP SERVICE MASTER KEY
    TO FILE = 'С:\Keys\service_master_key'
    ENCRYPTION BY PASSWORD = 'Pa$$w0rd';
GO

-- Резервное восстановление главного ключа службы.
RESTORE SERVICE MASTER KEY
    FROM FILE = 'C:\Keys\service_master_key'
    DECRYPTION BY PASSWORD = 'Pa$$w0rd';
GO