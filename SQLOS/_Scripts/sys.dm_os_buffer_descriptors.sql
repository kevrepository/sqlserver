SELECT COUNT(*) * 8 / 1024 AS 'Cached Size (MB)'
      ,CASE database_id
       WHEN 32767 THEN 'ResourceDb'
       ELSE DB_NAME(database_id)
       END AS 'Database'
FROM   sys.dm_os_buffer_descriptors
GROUP  BY DB_NAME(database_id), database_id
ORDER  BY 'Cached Size (MB)' DESC
GO

SELECT DB_NAME(database_id) AS database_name
      ,file_id
      ,page_id
      ,page_level
      ,allocation_unit_id
      ,page_type
      ,row_count
      ,free_space_in_bytes
      ,is_modified
      ,numa_node
      ,read_microsec
      ,is_in_bpool_extension
FROM   sys.dm_os_buffer_descriptors
ORDER  BY DB_NAME(database_id);
GO