SELECT d.name AS database_name
      ,mf.name as logical_name
      ,mf.physical_name
      ,diovfs.num_of_bytes_read / 1024 / 1024 AS num_of_mb_read
      ,diovfs.num_of_bytes_written / 1024 / 1024 AS num_of_mb_written
      ,diovfs.size_on_disk_bytes / 1024 / 1024 AS size_on_disk_mb
      ,mf.size / 128 AS max_size_mb
FROM   sys.databases AS d
       INNER JOIN sys.master_files AS mf
               ON d.database_id = mf.database_id
       INNER JOIN sys.dm_io_virtual_file_stats(NULL, NULL) AS diovfs
               ON mf.database_id = diovfs.database_id
                  AND mf.file_id = diovfs.file_id       
WHERE  mf.is_sparse = 1;