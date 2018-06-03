SELECT objtype
      ,COUNT(*) AS number_of_plans
      ,SUM(CONVERT(bigint, size_in_bytes)) / 1024 / 1024 AS plan_cache_size_mb
      ,AVG(usecounts) AS avg_use_count
FROM   sys.dm_exec_cached_plans
GROUP  BY objtype;