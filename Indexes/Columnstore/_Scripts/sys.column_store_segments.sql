/*
    Возвращает по одной строке для каждого сегмента столбца в индексе columnstore.

    encoding_type 
        Тип кодирования.
            1 - Кодирование на основе значений.
            2 - Словарь кодирования не строковых значение.
            3 - Словарь кодирования строковых значений.
            4 - Кодирование не используется.
    row_count 
        Количество строк в сегменте.
    has_null 
        Указывает, имеют ли данные нулевые значения.
    magnitude
        Величина, используемая для кодирования на основе значений. Для других типов кодирования он возвращает -1.
    min_data_id и max_data_id
        Минимальное и максимальное значения столбца внутри сегмента.
    null_value 
        Значение, используемое для указания NULL.
    on_disk_size
        Размер сегмента в байтах.

    https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-column-store-segments-transact-sql
*/

SELECT OBJECT_SCHEMA_NAME(i.object_id) + '.' + OBJECT_NAME(i.object_id) AS object_name
      ,i.name AS index_name
      ,p.partition_number
      ,p.data_compression_desc AS data_compression
      ,css.hobt_id
      ,css.column_id
      ,c.name AS column_name
      ,css.segment_id
      ,css.version
      ,css.encoding_type
      ,css.row_count
      ,css.has_nulls
      ,css.base_id
      ,css.magnitude
      ,css.primary_dictionary_id
      ,css.secondary_dictionary_id
      ,css.min_data_id
      ,css.max_data_id
      ,css.null_value
      ,CONVERT(decimal(12,3), css.on_disk_size / 1024.0 / 1024.0) AS disk_size_mb
FROM   sys.column_store_segments AS css
       INNER JOIN sys.partitions AS p 
               ON css.partition_id = p.partition_id
       INNER JOIN sys.indexes AS i
               ON p.object_id = i.object_id 
                  AND p.index_id = i.index_id
       LEFT  JOIN sys.index_columns AS ic 
               ON i.index_id = ic.index_id 
                  AND i.object_id = ic.object_id 
                  AND css.column_id = ic.index_column_id
       LEFT  JOIN sys.columns AS c
               ON ic.column_id = c.column_id
                  AND ic.object_id = c.object_id
ORDER  BY object_name, index_name, partition_number, column_id, segment_id;
GO