SELECT *
FROM   sys.dm_os_wait_stats
WHERE  wait_type LIKE 'PAGE%LATCH_%';