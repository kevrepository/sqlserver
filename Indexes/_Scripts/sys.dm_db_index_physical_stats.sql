/*
    sys.dm_db_index_physical_stats (
        { database_id | NULL | 0 | DEFAULT }
       ,{ object_id | NULL | 0 | DEFAULT }
       ,{ index_id | NULL | 0 | -1 | DEFAULT }
       ,{ partition_number | NULL | 0 | DEFAULT }
       ,{ mode | NULL | DEFAULT }
    )

    database_id | NULL | 0 | DEFAULT
        Идентификатор базы данных. 0, NULL или DEFAULT возвращает информацию для всех баз данных.
    object_id | NULL | 0 | DEFAULT
        Идентификатор таблицы или представления. 0, NULL или DEFAULT возвращает информацию для всех таблиц или представлений в базе данных.
    index_id | 0 | NULL | -1 | DEFAULT
        Идентификатор индекса. -1, NULL или DEFAULT возвращает статистику для всех индексов в таблице или представлении.
    partition_number | NULL | 0 | DEFAULT
        Номер раздела. 0, NULL или DEFAULT возвращает статистическую информацию для всех разделов индекса.
    LIMITED | SAMPLED | DETAILED | NULL | DEFAULT
        LIMITED | NULL | DEFAULT
            Cканирует наименьшее количество страниц. 
            Для индекса проверяются только страницы родительского уровня B-дерева.
            В куче рассматриваются только связанные страницы PFS и IAM.
        SAMPLED
            Возвращает статистику, основанную на 1-процентной выборке всех страниц индекса или кучи. 
            Если индекс или куча имеет меньше чем 10000 страниц, DETAILED режим используется вместо SAMPLED.
        DETAILED
            Этот режим сканирует все страницы, как листовые, так и нелистовые, индекса и возвращает всю статистику.

    Этот DMF может влиять на производственные нагрузки.

    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch03.xhtml#sec36
*/

SELECT OBJECT_SCHEMA_NAME(i.[object_id]) + N'.' + OBJECT_NAME(i.[object_id]) AS [object_name]
      ,i.index_id
      ,i.[name] AS index_name
      ,STUFF((SELECT N', ' + c.name
              FROM   sys.index_columns AS ic
                     INNER JOIN sys.columns AS c
                             ON ic.[object_id] = c.[object_id]
                                AND ic.column_id = c.column_id
              WHERE  ic.[object_id] = i.[object_id]
                     AND ic.index_id = i.index_id
              ORDER  BY ic.index_column_id
              FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS [index_columns]
      ,i.type_desc AS index_type_desc
      ,ddips.partition_number      
      ,ddips.alloc_unit_type_desc
      ,ddips.index_depth
      ,ddips.index_level
       -- Statistics.
      ,ddips.page_count
      ,ddips.record_count
      ,ddips.ghost_record_count
      ,ddips.version_ghost_record_count
      ,ddips.min_record_size_in_bytes
      ,ddips.max_record_size_in_bytes
      ,ddips.avg_record_size_in_bytes
      ,ddips.forwarded_record_count
      ,ddips.compressed_page_count
       -- Fragmentation Statistics.
      ,ddips.avg_fragmentation_in_percent
      ,ddips.fragment_count
      ,ddips.avg_fragment_size_in_pages
      ,ddips.avg_page_space_used_in_percent
FROM   sys.indexes AS i
       CROSS APPLY sys.dm_db_index_physical_stats(DB_ID(), i.object_id, i.index_id, NULL, 'DETAILED') AS ddips
WHERE  i.object_id = OBJECT_ID('Person.Address')
ORDER  BY [object_name], index_name;