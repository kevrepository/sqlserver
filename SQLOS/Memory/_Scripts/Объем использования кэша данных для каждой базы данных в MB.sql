SELECT COUNT(*) * 8 / 1024 AS cached_size_mb
      ,CASE
       WHEN database_id = 32767 THEN 'ResourceDB'
       ELSE DB_NAME(database_id)
       END AS database_name
FROM   sys.dm_os_buffer_descriptors
GROUP  BY DB_NAME(database_id), database_id
ORDER  BY cached_size_mb DESC;