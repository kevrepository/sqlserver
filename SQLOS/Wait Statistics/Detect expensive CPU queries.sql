SELECT dest.text AS query_text
      ,deqs.execution_count
      ,deqs.total_worker_time / 1000 AS total_worker_time_ms
      ,deqs.last_worker_time / 1000 AS last_worker_time_ms
      ,deqs.last_execution_time
      ,deqp.query_plan
FROM   sys.dm_exec_query_stats AS deqs
       CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
       CROSS APPLY sys.dm_exec_query_plan(deqs.plan_handle) AS deqp
ORDER  BY deqs.total_worker_time DESC;