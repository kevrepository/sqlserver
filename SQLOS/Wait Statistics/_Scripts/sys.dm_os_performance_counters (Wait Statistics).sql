SELECT * 
FROM   sys.dm_os_performance_counters
WHERE  object_name = 'SQLServer:Wait Statistics' -- LIKE '%Wait Statistics%';