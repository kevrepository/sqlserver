SELECT wait_type
      ,waiting_tasks_count
      ,wait_time_ms - signal_wait_time_ms AS resource_wait_time_ms -- Waiter list (SUSPENDED).
      ,signal_wait_time_ms -- Runnable queue (RUNNABLE).
      ,wait_time_ms AS total_wait_time_ms
      ,COALESCE (wait_time_ms / NULLIF(waiting_tasks_count, 0), 0) AS average_wait_time_ms
FROM   sys.dm_os_wait_stats
WHERE  wait_type LIKE 'PAGE%LATCH_%';

/*
    Cleaning sys.dm_os_wait_stats.
    
    DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR);
*/