/*
    ALTER DATABASE SET Options (Transact-SQL)
        https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql-set-options?view=sql-server-2017

    Recovery Models (SQL Server)
        https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/recovery-models-sql-server?view=sql-server-2017
*/

ALTER DATABASE database_name SET RECOVERY [ FULL | BULK_LOGGED | SIMPLE ];