SELECT OBJECT_SCHEMA_NAME(i.[object_id]) + N'.' + OBJECT_NAME(i.[object_id]) AS [object_name]
      ,i.[name] AS index_name
      ,i.type_desc AS index_type_desc
      ,ddips.ghost_record_count
      ,ddips.version_ghost_record_count      
FROM   sys.indexes AS i
       CROSS APPLY sys.dm_db_index_physical_stats(DB_ID(), i.object_id, i.index_id, NULL, 'DETAILED') AS ddips
WHERE  i.object_id = OBJECT_ID('Person.Address')
ORDER  BY [object_name], index_name;