SELECT [type]
      ,memory_node_id
      ,pages_kb
      ,virtual_memory_reserved_kb
      ,virtual_memory_committed_kb
      ,awe_allocated_kb
FROM   sys.dm_os_memory_clerks
ORDER  BY virtual_memory_reserved_kb DESC;