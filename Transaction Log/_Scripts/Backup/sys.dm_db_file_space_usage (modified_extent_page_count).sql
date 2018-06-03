SELECT d.name AS database_name
      ,mf.name AS logical_name
      ,mf.physical_name AS physical_name
      --,ddfsu.modified_extent_page_count -- SQL Server 2017.
FROM   sys.databases AS d
       INNER JOIN sys.master_files AS mf
               ON d.database_id = mf.database_id
       INNER JOIN sys.dm_db_file_space_usage AS ddfsu
               ON mf.database_id = ddfsu.database_id
                  AND mf.file_id = ddfsu.file_id;