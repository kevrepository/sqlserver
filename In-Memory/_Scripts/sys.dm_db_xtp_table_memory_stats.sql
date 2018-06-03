SELECT s.name + '.' + o.name AS table_name 
      ,CONVERT(decimal(7, 2), ddxtms.memory_allocated_for_table_kb / 1024.) AS memory_allocated_for_table_mb
      ,CONVERT(decimal(7, 2), ddxtms.memory_used_by_table_kb / 1024.) AS memory_used_by_table_mb
      ,CONVERT(decimal(7, 2), ddxtms.memory_allocated_for_indexes_kb / 1024.) AS memory_allocated_for_indexes_mb
      ,CONVERT(decimal(7, 2), ddxtms.memory_used_by_indexes_kb / 1024.) AS memory_used_by_indexes_mb
from   sys.dm_db_xtp_table_memory_stats AS ddxtms
       INNER JOIN sys.objects AS o
               ON ddxtms.object_id = o.object_id
       INNER JOIN sys.schemas AS s
               ON o.schema_id = s.schema_id;