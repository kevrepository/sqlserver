/*
    sys.dm_db_index_operational_stats ( {database_id | NULL | 0 | DEFAULT}, {object_id | NULL | 0 | DEFAULT}, {index_id | 0 | NULL | -1 | DEFAULT}, {partition_number | NULL | 0 | DEFAULT} )

    database_id | NULL | 0 | DEFAULT
        Идентификатор базы данных. 0, NULL или DEFAULT возвращает информацию для всех баз данных.
    object_id | NULL | 0 | DEFAULT
        Идентификатор таблицы или представления. 0, NULL или DEFAULT возвращает информацию для всех таблиц или представлений в базе данных.
    index_id | 0 | NULL | -1 | DEFAULT
        Идентификатор индекса. -1, NULL или DEFAULT возвращает статистику для всех индексов в таблице или представлении.
    partition_number | NULL | 0 | DEFAULT
        Номер раздела. 0, NULL или DEFAULT возвращает статистическую информацию для всех разделов индекса.

    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch03.xhtml#sec18
*/

SELECT OBJECT_SCHEMA_NAME(i.[object_id]) + N'.' + OBJECT_NAME(i.[object_id]) AS [object_name]
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
       /*
           DML Activity.

           Если некластеризованный индекс часто обновляется, может оказаться полезным посмотреть на столбцы в индексе, 
           чтобы определить, соответствует ли волатильность столбцов преимуществам индекса.
       */
      ,ddios.leaf_insert_count
      ,ddios.leaf_delete_count
      ,ddios.leaf_update_count
      ,ddios.leaf_ghost_count
      ,ddios.nonleaf_insert_count
      ,ddios.nonleaf_delete_count
      ,ddios.nonleaf_update_count    
       -- SELECT Activity.      
      ,ddios.range_scan_count
      ,ddios.singleton_lookup_count -- Для каждой строки, использующей операцию поиска ключа, значение в этом столбце будет увеличиваться на единицу.
       /*
           Этот столбец полезен при просмотре счетчика производительности Forwarded Records/sec. 
           Этот столбец поможет определить, какая куча ведет к активности счетчика, обеспечивая фокусировку на точной таблице для исследования.
       */
      ,ddios.forwarded_fetch_count  
       -- Lock.
      ,ddios.row_lock_count
      ,ddios.row_lock_wait_count
      ,ddios.row_lock_wait_in_ms
      ,ddios.page_lock_count
      ,ddios.page_lock_wait_count
      ,ddios.page_lock_wait_in_ms
       -- Lock Escalation.
      ,ddios.index_lock_promotion_attempt_count
      ,ddios.index_lock_promotion_count
       -- Latch Contention.
      ,ddios.page_latch_wait_count
      ,ddios.page_latch_wait_in_ms
      ,ddios.page_io_latch_wait_count
      ,ddios.page_io_latch_wait_in_ms
      ,ddios.tree_page_latch_wait_count
      ,ddios.tree_page_latch_wait_in_ms
      ,ddios.tree_page_io_latch_wait_count
      ,ddios.tree_page_io_latch_wait_in_ms
       -- Page Allocation
      ,ddios.leaf_allocation_count
      ,ddios.nonleaf_allocation_count
      ,ddios.leaf_page_merge_count
      ,ddios.nonleaf_page_merge_count
       -- Compression.
      ,ddios.page_compression_attempt_count
      ,ddios.page_compression_success_count
       -- LOB Access.
      ,ddios.lob_fetch_in_pages
      ,ddios.lob_fetch_in_bytes
      ,ddios.lob_orphan_create_count
      ,ddios.lob_orphan_insert_count
      ,ddios.row_overflow_fetch_in_pages
      ,ddios.row_overflow_fetch_in_bytes
      ,ddios.column_value_push_off_row_count
      ,ddios.column_value_pull_in_row_count
FROM   sys.indexes AS i
       CROSS APPLY sys.dm_db_index_operational_stats(DB_ID(), i.object_id, i.index_id, NULL) AS ddios
WHERE  i.object_id = OBJECT_ID('Person.Address')
ORDER  BY [object_name], index_name;