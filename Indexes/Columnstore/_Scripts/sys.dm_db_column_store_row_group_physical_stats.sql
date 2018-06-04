/*
    partition_number
        Номер раздела в таблице.
    row_group_id
        Идентификатор группы строк внутри раздела.
    delta_store_hobt_id
        hobt_id открытого хранилища дельта.    
    state и state_description
        Показывают состояние группы строк.    
    total_rows
        Общее число строк, которые физически хранятся в группе строк.
    deleted_rows 
        Общее число строк в группе строк, которые отмечены как удаленные.    
    size_in_bytes 
        Размер группы строк на диске.
    transition_to_compressed_state и transition_to_compressed_state_desc
        Причина сжатия группы строк.
    trim_reason и trim_reason_desc
        Указывает, почему группа строк имеет менее 1 048 576 строк.
    generation 
        Показывает порядковый номер, в котором была создана группа строк.

     Столбцы transition_to_compressed_state и trim_reason_desc можно использовать, 
     для устранения ситуации, когда индекс столбцов содержит большое количество частично заполненных групп строк в системе.
*/

SELECT OBJECT_SCHEMA_NAME(ddcsrgps.object_id) + N'.' + OBJECT_NAME(ddcsrgps.object_id) AS object_name      
      ,i.name AS index_name
      ,i.type_desc AS index_type
      ,ddcsrgps.partition_number
      ,ddcsrgps.row_group_id
      ,ddcsrgps.delta_store_hobt_id
      ,ddcsrgps.state_desc AS state
      ,ddcsrgps.total_rows
      ,ddcsrgps.deleted_rows
      ,ddcsrgps.size_in_bytes
      ,ddcsrgps.transition_to_compressed_state_desc AS transition_to_compressed_state
      ,ddcsrgps.trim_reason_desc AS trim_reason
      ,ddcsrgps.generation
      ,ddcsrgps.has_vertipaq_optimization
      ,ddcsrgps.created_time
      ,ddcsrgps.closed_time
FROM   sys.dm_db_column_store_row_group_physical_stats AS ddcsrgps
       INNER JOIN sys.indexes AS i
               ON ddcsrgps.object_id = i.object_id
                  AND ddcsrgps.index_id = i.index_id
ORDER  BY object_name, index_name;