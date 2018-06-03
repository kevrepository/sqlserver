SELECT der.session_id
      ,der.request_id
      ,der.start_time
      ,der.status
      ,der.command
      ,dest.text AS query_text
      ,deqp.query_plan
      ,der.blocking_session_id
      ,der.wait_type
      ,der.wait_time
FROM   sys.dm_exec_requests AS der
       INNER JOIN sys.dm_exec_sessions AS des
               ON der.session_id = des.session_id
       CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) AS dest
       CROSS APPLY sys.dm_exec_query_plan(der.plan_handle) AS deqp
           INNER JOIN sys.dm_os_tasks AS dot
            ON der.task_address = dot.task_address
    INNER JOIN sys.dm_os_workers AS dow
            ON dot.worker_address = dow.worker_address
    INNER JOIN sys.dm_os_schedulers AS dos 
            ON dow.scheduler_address = dos.scheduler_address
WHERE  des.is_user_process = 1;

/*
    INNER JOIN sys.dm_os_tasks AS dot
            ON der.task_address = dot.task_address
    INNER JOIN sys.dm_os_workers AS dow
            ON dot.worker_address = dow.worker_address
    INNER JOIN sys.dm_os_schedulers AS dos 
            ON dow.scheduler_address = dos.scheduler_address
*/