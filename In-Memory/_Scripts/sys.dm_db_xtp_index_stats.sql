-- Большое количество rows_per_scan может означать сканирование больших индексов, что может быть признаком субоптимальной стратегии индексирования и/или плохо написанных запросов.

select s.[name] + '.' + t.[name] AS table_name
      ,i.index_id
      ,i.[name] AS index_name
      ,i.[type_desc]
      ,ddxis.scans_started
      ,ddxis.rows_returned
      ,CASE
       WHEN ddxis.scans_started = 0 THEN 0
       ELSE FLOOR(ddxis.rows_returned / ddxis.scans_started)
       END AS rows_per_scan
from   sys.dm_db_xtp_index_stats AS ddxis 
       INNER JOIN sys.tables AS t 
               ON ddxis.object_id = t.object_id
       INNER JOIN sys.indexes AS i 
               ON ddxis.object_id = i.object_id 
                  and ddxis.index_id = i.index_id
       INNER JOIN sys.schemas AS s 
               ON s.schema_id = t.schema_id
--WHERE  s.name = 'schema_name'
--       AND t.name = 'table_name';