SELECT d.name AS database_name
      ,mf.name AS logical_name
      ,mf.physical_name
      ,mf.type_desc AS file_type
      ,divfs.io_stall
      ,divfs.io_stall_read_ms
      ,divfs.io_stall_write_ms
      ,divfs.num_of_reads
      ,divfs.num_of_bytes_read
      ,divfs.num_of_writes
      ,divfs.num_of_bytes_written
      ,divfs.size_on_disk_bytes
      ,divfs.io_stall_queued_read_ms
      ,divfs.io_stall_queued_write_ms
FROM   sys.dm_io_virtual_file_stats(NULL, NULL) AS divfs
       INNER JOIN sys.databases AS d
               ON divfs.database_id = d.database_id
       INNER JOIN sys.master_files AS mf
               ON divfs.database_id = mf.database_id
                  AND divfs.file_id = mf.file_id
ORDER BY io_stall DESC;