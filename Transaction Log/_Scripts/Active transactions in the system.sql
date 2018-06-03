SELECT dtst.session_id
      ,[des].login_name
      ,[des].host_name
      ,[des].program_name
      ,[des].login_time
      ,dtdt.database_transaction_begin_time
      ,dtdt.database_transaction_log_record_count
      ,dtdt.database_transaction_log_bytes_used
      ,dtdt.database_transaction_log_bytes_reserved
      ,dest.text AS query_text
      ,deqp.query_plan
FROM   sys.dm_tran_database_transactions AS dtdt
       INNER  JOIN sys.dm_tran_session_transactions AS dtst
                ON dtdt.transaction_id = dtst.transaction_id
       INNER  JOIN sys.dm_exec_sessions AS [des]
                ON [des].[session_id] = dtst.[session_id]
       LEFT   JOIN sys.dm_exec_requests AS der 
                ON der.session_id = dtst.session_id
       INNER  JOIN sys.dm_exec_connections AS [dec] 
                ON [dec].session_id = dtst.session_id  
       CROSS APPLY sys.dm_exec_sql_text([dec].most_recent_sql_handle) AS dest
       CROSS APPLY sys.dm_exec_query_plan(der .plan_handle) AS deqp
WHERE  dtdt.database_id = DB_ID()
ORDER  BY dtdt.database_transaction_begin_time;