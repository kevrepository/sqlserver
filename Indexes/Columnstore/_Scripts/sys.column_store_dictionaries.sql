/*
    —одержит по одной строке дл€ каждого словар€, используемого в индексах columnstore.

    dictionary_id
        ¬ид словар€. 
        0 - глобальный словарь.
    type
        “ип словар€. 
        1 Ч хэш-словарь, содержащий int значени€.
        2 Ч не используетс€.
        3 Ч хэш-словарь, содержащий строковые значени€.
        4 Ч хэш-словарь, содержащий float значени€.
    last_id
        ѕоследний идентификатор данных в словаре.
    entry_count
         оличество записей в словаре.
    on_disk_size
        –азмер словар€ в байтах.

    https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-column-store-dictionaries-transact-sql
*/
SELECT OBJECT_SCHEMA_NAME(i.object_id) + '.' + OBJECT_NAME(i.object_id) AS object_name
      ,i.name AS index_name
      ,p.partition_number
      ,csd.column_id
      ,c.name AS column_name
      ,csd.dictionary_id
      ,csd.version
      ,csd.type
      ,csd.last_id
      ,csd.entry_count
      ,CONVERT(decimal(12, 3), csd.on_disk_size / 1024.0 / 1024.0) AS disk_size_mb
FROM   sys.column_store_dictionaries AS csd
       INNER JOIN sys.partitions p 
               ON p.partition_id = csd.partition_id
       INNER JOIN sys.indexes AS i 
               ON p.object_id = i.object_id 
                  AND p.index_id = i.index_id
       LEFT  JOIN sys.index_columns AS ic 
               ON i.index_id = ic.index_id 
                  AND i.object_id = ic.object_id 
                  AND csd.column_id = ic.index_column_id
       LEFT  JOIN sys.columns AS c 
               ON ic.column_id = c.column_id 
                  AND ic.object_id = c.object_id
ORDER  BY object_name, index_name, partition_number, column_id;
GO
