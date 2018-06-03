SELECT dtl.request_session_id AS session_id
      ,dtl.resource_type
      ,dtl.resource_description
      ,dtl.request_mode
      ,dtl.request_status
      ,dowt.blocking_session_id AS session_id_blocked_by
FROM   sys.dm_tran_locks AS dtl WITH (NOLOCK) 
       LEFT JOIN sys.dm_os_waiting_tasks AS dowt WITH (NOLOCK) 
              on dtl.lock_owner_address = dowt.resource_address 
                 and dtl.request_status = 'WAIT'
WHERE  dtl.request_session_id <> @@SPID 
       AND dtl.resource_type = 'KEY'
ORDER  BY dtl.request_session_id;