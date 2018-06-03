-- Представление sys.dm_db_xtp_hash_index_stats просматривает всю таблицу, которая занимает много времени, когда таблицы большие.

select s.name + '.' + t.name AS table_name
      ,i.name AS index_name
      ,ddxhis.total_bucket_count
      ,ddxhis.empty_bucket_count
      ,FLOOR(100. * ddxhis.empty_bucket_count / ddxhis.total_bucket_count) AS еmpty_bucket_percent
      ,ddxhis.avg_chain_length
      ,ddxhis.max_chain_length
from   sys.dm_db_xtp_hash_index_stats AS ddxhis
       INNER JOIN sys.tables AS t
               ON ddxhis.object_id = t.object_id
       INNER JOIN sys.indexes AS i
               ON ddxhis.object_id = i.object_id 
                  AND ddxhis.index_id = i.index_id
       INNER JOIN sys.schemas AS s
               ON t.schema_id = s.schema_id;