SELECT session_id
      ,wait_type
      ,wait_duration_ms
      ,blocking_session_id
      ,resource_description
      ,CASE
       WHEN CONVERT(int, RIGHT(resource_description, LEN(resource_description) - CHARINDEX(':', resource_description, 3))) - 1 % 8088   = 0 THEN 'Is PFS Page'
       WHEN CONVERT(int, RIGHT(resource_description, LEN(resource_description) - CHARINDEX(':', resource_description, 3))) - 2 % 511232 = 0 THEN 'Is GAM Page'
       WHEN CONVERT(int, RIGHT(resource_description, LEN(resource_description) - CHARINDEX(':', resource_description, 3))) - 3 % 511232 = 0 THEN 'Is SGAM Page'
       ELSE 'Is Not PFS, GAM, or SGAM page'
       END AS resource_type
FROM   sys.dm_os_waiting_tasks
WHERE  wait_type LIKE 'PAGE%LATCH_%'
       AND resource_description LIKE '2:%';