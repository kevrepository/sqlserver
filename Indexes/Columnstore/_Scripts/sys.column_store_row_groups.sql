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
*/

SELECT OBJECT_SCHEMA_NAME(csrg.object_id) + N'.' + OBJECT_NAME(csrg.object_id) AS object_name      
      ,i.name AS index_name
      ,i.type_desc AS index_type
      ,csrg.partition_number
      ,csrg.row_group_id
      ,csrg.delta_store_hobt_id
      ,csrg.state_description AS state
      ,csrg.total_rows
      ,csrg.deleted_rows
      ,csrg.size_in_bytes      
FROM   sys.column_store_row_groups AS csrg
       INNER JOIN sys.indexes AS i
               ON csrg.object_id = i.object_id
                  AND csrg.index_id = i.index_id
ORDER  BY object_name, index_name;