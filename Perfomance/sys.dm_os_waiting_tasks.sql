SELECT owt.session_ID
      ,owt.wait_type,
      ,UPPER(es.status) AS status
      ,owt.wait_duration_ms
      ,est.text AS query_text
      ,es.cpu_time
      ,es.memory_usage
      ,es.logical_reads
      ,es.total_elapsed_time
      ,owt.blocking_session_id
      ,es.program_name
      ,DB_NAME(er.database_id) AS database_name
FROM   sys.dm_os_waiting_tasks AS owt
       INNER JOIN sys.dm_exec_requests AS er
               ON owt.session_id = er.session_id
       INNER JOIN sys.dm_exec_sessions AS es
              ON es.session_id = er.session_id
       CROSS APPLY sys.dm_exec_sql_text (er.sql_handle) AS est
WHERE  es.is_user_process = 1;