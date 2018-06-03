/*
    committed_target_kb
         Объем памяти, который буферный кэш хочет использовать.
         Если значение committed_target_kb больше, чем committed_kb, диспетчер памяти попытается получить дополнительную память. 
         Если значение committed_target_kb меньше, чем committed_kb, диспетчер памяти попытается уменьшить количество зафиксированной памяти.       
    committed_kb
        Объем памяти, который в настоящее время выделяется буферным кешем для использования страницами базы данных.
*/

SELECT dosm.total_physical_memory_kb / 1024 AS 'Physical Memory (MB)'
      ,dosm.available_physical_memory_kb / 1024 AS 'Available Physical Memory (MB)'
      ,CONVERT(decimal(3, 1), (CONVERT(decimal(10,1 ), dosm.available_physical_memory_kb / 1024) / CONVERT(decimal(10, 1), dosm.total_physical_memory_kb / 1024)) * 100) AS 'Available Memory as % of Physical Memory'
      ,CONVERT(decimal(10,1), dosi.committed_target_kb / 1024) AS 'Committed Target (MB)'
      ,CONVERT(decimal(10, 1), (CONVERT(decimal(10,1), dosi.committed_target_kb / 1024) / CONVERT(decimal(10, 1), dosm.total_physical_memory_kb / 1024)) * 100) AS 'Committed Target as % of Physical Memory'
      ,CONVERT(decimal(10,1), dosi.committed_kb  / 1024) AS  'Total Committed (MB)'
      ,CONVERT(decimal(3, 1), (CONVERT(decimal(10,1), dosi.committed_kb  / 1024) / CONVERT(decimal(10, 1), dosm.total_physical_memory_kbFf / 1024)) * 100) AS 'Total Committed as % of Physical Memory'      
FROM   sys.dm_os_sys_memory AS dosm
       CROSS JOIN sys.dm_os_sys_info AS dosi;
GO

SELECT OBJECT_SCHEMA_NAME(p.object_id) + N'.' + OBJECT_NAME(p.object_id) AS object_name
      ,i.name AS index_name
      ,i.type_desc AS index_type
      ,p.partition_number
      ,p.data_compression_desc
      ,au.type_desc
      ,au.total_pages
      ,au.used_pages
      ,au.data_pages
      ,dobd.buffer_pages
FROM   sys.partitions AS p 
       INNER  JOIN sys.allocation_units AS au 
                ON p.partition_id = au.container_id
       LEFT   JOIN sys.indexes AS i
                ON p.object_id = i.object_id 
                   AND p.index_id = i.index_id
       OUTER APPLY (SELECT COUNT(*) AS buffer_pages
                    FROM   sys.dm_os_buffer_descriptors AS dobd
                    WHERE  dobd.allocation_unit_id = au.allocation_unit_id) AS dobd
WHERE  p.object_id IN (object_id(N'dbo.CSI_A'), object_id(N'dbo.I'))
ORDER  BY object_name, index_name;
GO

SELECT clerk_name
      ,total_kb
      ,simulated_kb
      ,simulation_benefit
      ,internal_benefit
      ,external_benefit
      ,value_of_memory
      ,periodic_freed_kb
      ,internal_freed_kb
FROM   sys.dm_os_memory_broker_clerks;
GO

SELECT name
      ,type
      ,pages_kb
      ,pages_in_use_kb
      ,entries_count
      ,entries_in_use_count
FROM   sys.dm_os_memory_cache_counters 
WHERE  type = 'CACHESTORE_COLUMNSTOREOBJECTPOOL';
GO

SELECT name
      ,type
      ,memory_node_id
      ,pages_kb
      ,page_size_in_bytes
      ,virtual_memory_reserved_kb
      ,virtual_memory_committed_kb
	  ,shared_memory_reserved_kb
      ,shared_memory_committed_kb
FROM   sys.dm_os_memory_clerks 
WHERE  type = 'CACHESTORE_COLUMNSTOREOBJECTPOOL';
GO