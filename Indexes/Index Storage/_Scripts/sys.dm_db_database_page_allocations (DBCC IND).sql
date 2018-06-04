/*
    sys.dm_db_database_page_allocations ( {database_id}, {table_id | NULL}, {index_id | NULL}, {partition_id | NULL}, {DETAILED | LIMITED} )

    database_id
        Идентификатор базы данных.
    table_id | NULL
        Идентификатор таблицы. NULL использоваться для возврата всех таблиц.
    index_id | NULL
        Идентификатор индекса. NULL использоваться для возврата информации для всех индексов.
    partition_id | NULL
        Идентификатор раздела. NULL использоваться для возврата информации для всех разделов.
    DETAILED | LIMITED
        LIMITED
            Информация ограничена метаданными страницы, такими как распределение страниц и информация о взаимоотношениях.
        DETAILED
            Предоставляется дополнительная информация, такая как типы страниц и цепи отношений между страницами. 
    
    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch02.xhtml#Sec23
*/

SELECT *
FROM   sys.dm_db_database_page_allocations(DB_ID('AdventureWorks2014'), OBJECT_ID('Person.Address'), 1, NULL, 'DETAILED');