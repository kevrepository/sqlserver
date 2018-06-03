SELECT latch_class
      ,waiting_requests_count
      ,wait_time_ms
      ,max_wait_time_ms
FROM   sys.dm_os_latch_stats;