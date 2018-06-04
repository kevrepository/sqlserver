SELECT OBJECT_SCHEMA_NAME(i.[object_id]) + N'.' + OBJECT_NAME(i.[object_id]) AS [object_name]
      ,i.[name] AS index_name
      ,ddps.partition_number
      ,ddps.in_row_data_page_count
      ,ddps.in_row_used_page_count
      ,ddps.in_row_reserved_page_count
      ,ddps.lob_used_page_count
      ,ddps.lob_reserved_page_count
      ,ddps.row_overflow_used_page_count
      ,ddps.row_overflow_reserved_page_count
      ,ddps.used_page_count
      ,ddps.reserved_page_count
      ,ddps.row_count
FROM   sys.indexes AS i
       INNER JOIN sys.dm_db_partition_stats AS ddps
               ON i.index_id = ddps.index_id
                  AND i.[object_id] = ddps.[object_id]
WHERE  i.[object_id] = OBJECT_ID('Person.Address');