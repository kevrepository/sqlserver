SELECT dtl.resource_type
      ,DB_NAME(dtl.resource_database_id) AS database_name
      ,CASE dtl.resource_type
       WHEN 'OBJECT' THEN OBJECT_NAME(dtl.resource_associated_entity_id, dtl.resource_database_id)
       WHEN 'DATABASE' THEN 'DB'
       ELSE
           CASE WHEN dtl.resource_database_id = DB_ID() THEN
               (SELECT OBJECT_NAME(object_id, dtl.resource_database_id)
                FROM   sys.partitions
                WHERE  hobt_id = dtl.resource_associated_entity_id)
           ELSE '(Run under DB context)'
           END
       END AS object_name
      ,dtl.resource_description
      ,dtl.request_session_id
      ,dtl.request_mode
      ,dtl.request_status
      ,dowt.wait_duration_ms
      ,der.query_text
      ,der.query_plan
FROM   sys.dm_tran_locks AS dtl WITH (NOLOCK)
       LEFT   JOIN sys.dm_os_waiting_tasks AS dowt WITH (NOLOCK) 
                ON dowt.resource_address = dtl.lock_owner_address 
                   AND dtl.request_status = 'WAIT'
       OUTER APPLY (SELECT SUBSTRING(dest.text, der.statement_start_offset / 2 + 1, 
                           (CASE der.statement_end_offset
                            WHEN -1
                            THEN DATALENGTH(dest.text)
                            ELSE der.statement_end_offset
                            END - der.statement_start_offset) / 2 + 1) AS query_text
                          ,deqp.query_plan
                    FROM   sys.dm_exec_requests AS der WITH (NOLOCK)
                           CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) AS dest
                           OUTER APPLY sys.dm_exec_query_plan(der.plan_handle) AS deqp
                    WHERE  der.session_id = dtl.request_session_id) AS der
--WHERE  dtl.request_session_id = session_id
ORDER  BY dtl.request_session_id
OPTION (RECOMPILE);