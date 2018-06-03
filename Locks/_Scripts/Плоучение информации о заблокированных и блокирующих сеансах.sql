SELECT dtl1.resource_type
      ,DB_NAME(dtl1.resource_database_id) AS database_name
      ,CASE 
       WHEN dtl1.resource_type = N'OBJECT'   THEN OBJECT_NAME(dtl1.resource_associated_entity_id, dtl1.resource_database_id)
       WHEN dtl1.resource_type = N'DATABASE' THEN N'DB'
       ELSE CASE
            WHEN dtl1.resource_database_id = DB_ID()
            THEN (SELECT OBJECT_NAME(OBJECT_ID, dtl1.resource_database_id)
                  FROM   sys.partitions
                  WHERE  hobt_id = dtl1.resource_associated_entity_id)
            ELSE N'(Run under DB context)'
            END
       END AS object_name
      ,dtl1.resource_description
      ,dtl1.request_session_id
      ,dtl1.request_mode
      ,dtl1.request_status
      ,dowt.wait_duration_ms
      ,der.query_text
      ,der.query_plan
FROM   sys.dm_tran_locks AS dtl1 WITH (NOLOCK) 
       INNER  JOIN sys.dm_tran_locks AS dtl2 WITH (NOLOCK) 
                ON dtl1.resource_associated_entity_id = dtl2.resource_associated_entity_id
       LEFT   JOIN sys.dm_os_waiting_tasks AS dowt WITH (NOLOCK)
                ON dtl1.lock_owner_address = dowt.resource_address 
                   AND dtl1.request_status = 'WAIT'
       OUTER APPLY (SELECT SUBSTRING(dest.text, (der.statement_start_offset / 2) + 1, 
                             ((CASE 
                               WHEN der.statement_end_offset = -1 THEN DATALENGTH(dest.text)
                               ELSE der.statement_end_offset
                               END - der.statement_start_offset) / 2) + 1) AS query_text
                          ,deqp.query_plan
                    FROM   sys.dm_exec_requests AS der WITH (NOLOCK)
                           CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) AS dest
                           OUTER APPLY sys.dm_exec_query_plan(der.plan_handle) AS deqp
                    WHERE  der.session_id = dtl1.request_session_id) der
WHERE  dtl1.request_status <> dtl2.request_status
       AND (dtl1.resource_description = dtl2.resource_description 
            OR (dtl1.resource_description IS NULL 
                AND dtl2.resource_description IS NULL))
OPTION (RECOMPILE);