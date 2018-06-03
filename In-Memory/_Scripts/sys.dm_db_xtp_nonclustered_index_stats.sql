SELECT s.[name] + '.' + t.[name] AS table_name
      ,i.index_id
      ,i.[name] AS index_name
      ,i.[type_desc]
      ,ddxnis.delta_pages AS data_pages
      ,ddxnis.leaf_pages
      ,ddxnis.internal_pages
      ,ddxnis.delta_pages + ddxnis.leaf_pages + ddxnis.internal_pages AS total_pages
FROM   sys.dm_db_xtp_nonclustered_index_stats AS ddxnis
       INNER JOIN sys.tables AS t
               ON ddxnis.object_id = t.object_id
       INNER JOIN sys.indexes AS i
               ON ddxnis.object_id = i.object_id 
                  and ddxnis.index_id = i.index_id
       INNER JOIN sys.schemas AS s
               ON s.schema_id = t.schema_id
--WHERE  s.name = 'schema_name' 
--       AND t.name = 'table_name';