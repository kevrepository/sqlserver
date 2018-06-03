SELECT dtl.request_session_id
      ,dtl.resource_type
      ,dtl.resource_description
      ,dtl.request_mode
      ,dtl.request_status
      ,dowt.blocking_session_id
      ,OBJECT_NAME(p.object_id) AS object_name
      ,i.name AS index_name
FROM   sys.dm_tran_locks AS dtl 
       INNER JOIN sys.partitions AS p 
               ON p.hobt_id = dtl.resource_associated_entity_id
       INNER JOIN sys.indexes AS i 
               ON i.object_id = p.object_id 
                  AND i.index_id = p.index_id
       LEFT  JOIN sys.dm_os_waiting_tasks AS dowt 
               ON dowt.resource_address = dtl.lock_owner_address
                  AND dtl.request_status IN ('WAIT', 'CONVERT')
WHERE  dtl.request_session_id <> @@SPID
ORDER  BY dtl.request_session_id;