SELECT dest.text
      ,decp.objtype
      ,decp.usecounts
      ,decp.size_in_bytes
      ,domce.type as cache_store_type
      ,domce.original_cost
      ,domce.current_cost
      ,domce.disk_ios_count
      ,domce.pages_kb
      ,domce.context_switches_count
      ,deqp.query_plan
FROM   sys.dm_exec_cached_plans AS decp WITH (NOLOCK) 
       INNER  JOIN sys.dm_os_memory_cache_entries AS domce WITH (NOLOCK) 
                ON domce.memory_object_address = decp.memory_object_address
       CROSS APPLY sys.dm_exec_sql_text(decp.plan_handle) AS dest
       CROSS APPLY sys.dm_exec_query_plan(decp.plan_handle) AS deqp
WHERE  decp.cacheobjtype = 'Compiled plan' 
       AND domce.type IN (N'CACHESTORE_SQLCP', N'CACHESTORE_OBJCP')
ORDER  BY decp.usecounts DESC;