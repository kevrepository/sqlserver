SELECT domcc.name
      ,domcc.[type]
      ,domcc.pages_kb / 1024 AS pages_mb
      ,domcc.pages_in_use_kb AS pages_in_use_mb
      ,domcc.entries_count
      ,domcc.entries_in_use_count
FROM   sys.dm_os_memory_cache_counters AS domcc
WHERE  domcc.[type] = N'CACHESTORE_TEMPTABLES';
GO

-- https://msdn.microsoft.com/pl-pl/library/ms177441(v=sql.110).aspx
SELECT dopc.[object_name]
      ,dopc.counter_name 
      ,dopc.cntr_value      
FROM   sys.dm_os_performance_counters AS dopc
WHERE  dopc.[object_name] = N'SQLServer:Plan Cache'
       AND dopc.instance_name = N'Temporary Tables & Table Variables'
       AND dopc.counter_name IN (N'Cache Object Counts', N'Cache Objects in use');
GO

-- https://docs.microsoft.com/en-us/sql/relational-databases/performance-monitor/sql-server-general-statistics-object
SELECT dopc.[object_name]
      ,dopc.counter_name 
      ,dopc.cntr_value
FROM   sys.dm_os_performance_counters AS dopc 
WHERE  dopc.counter_name = 'Temp Tables Creation Rate' 
       AND dopc.[object_name] = 'SQLServer:General Statistics';
GO