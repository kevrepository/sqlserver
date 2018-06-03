--EXEC SP_HELPDB database_name;

CREATE DATABASE SNAP_AdventureWorks2014 ON
(
    NAME = AdventureWorks2014_Data
   ,FILENAME  = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\SNAP_AdventureWorks2014_Data.snap'
)
AS SNAPSHOT OF AdventureWorks2014;
GO

/*
    SELECT name
          ,database_id
          ,source_database_id
          ,create_date
          ,snapshot_isolation_state_desc
    FROM   sys.databases;

    SELECT *
    FROM   sys.master_files
    WHERE  is_sparse = 1;
*/