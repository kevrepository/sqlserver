SELECT SUM(wait_time_ms - signal_wait_time_ms) AS resource_wait_time_ms
      ,CONVERT(numeric(20,2), 100.0 * SUM(wait_time_ms - signal_wait_time_ms) / SUM(wait_time_ms)) AS resource_waits_pct
      ,SUM(signal_wait_time_ms) AS signal_wait_time_ms
      ,CONVERT(numeric(20,2), 100.0 * SUM(signal_wait_time_ms) / SUM(wait_time_ms)) AS signal_waits_pct
FROM   sys.dm_os_wait_stats;