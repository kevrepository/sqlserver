/*
    Показывает 0, если задача все еще ждет или время ожидания, когда ожидание завершено.
*/

SELECT dowt.session_id
      ,dowt.wait_type
      ,dowt.waiting_tasks_count
      ,dowt.max_wait_time_ms
      ,dowt.wait_time_ms - dowt.signal_wait_time_ms AS resource_wait_time_ms -- Waiter list (SUSPENDED).
      ,dowt.signal_wait_time_ms -- Runnable queue (RUNNABLE).
      ,dowt.wait_time_ms AS total_wait_time_ms
      ,COALESCE(dowt.wait_time_ms / NULLIF(dowt.waiting_tasks_count, 0), 0) AS average_wait_time_ms
      ,COALESCE(dowt.wait_time_ms * 100.0 / NULLIF(SUM(dowt.wait_time_ms) OVER(PARTITION BY dowt.session_id), 0), 0) AS percentage
FROM   sys.dm_exec_session_wait_stats AS dowt
       INNER JOIN sys.dm_exec_sessions AS des
               ON dowt.session_id = des.session_id
WHERE  des.is_user_process = 1
ORDER  BY dowt.session_id, percentage DESC;