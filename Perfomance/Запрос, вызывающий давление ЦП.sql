SELECT ot.task_state
      ,er.session_id
      ,os.context_switches_count
      ,os.pending_disk_io_count
      ,os.scheduler_id
      ,os.status AS scheduler_status
      ,DB_NAME(er.database_id) AS database_name
      ,er.command
      ,est.text
FROM   sys.dm_os_schedulers AS os
       INNER JOIN sys.dm_os_tasks AS ot 
               ON os.active_worker_address = ot.worker_address
       INNER JOIN sys.dm_exec_requests AS er 
               ON ot.task_address = er.task_address
       CROSS APPLY sys.dm_exec_sql_text(er.plan_handle) AS est
WHERE  er.session_id <> @@SPID
       -- AND ot.task_state = 'RUNNABLE'