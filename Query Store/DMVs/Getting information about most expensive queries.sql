-- Получение информации о наиболее дорогих запросах.

select qsq.query_id
      ,qsqt.query_sql_text
      ,qsp.plan_id
      ,CONVERT(XML, qsp.query_plan) AS query_plan
      ,SUM(qsrs.count_executions) AS count_executions
      ,CONVERT(INT, SUM(qsrs.count_executions * (qsrs.avg_logical_io_reads + avg_logical_io_writes)) / SUM(qsrs.count_executions)) AS avg_logical_io
      ,CONVERT(INT, SUM(qsrs.count_executions * (qsrs.avg_logical_io_reads + avg_logical_io_writes))) AS total_logical_io
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_cpu_time) / SUM(qsrs.count_executions)) AS avg_cpu_time
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_cpu_time)) AS total_cpu_time
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_duration) / SUM(qsrs.count_executions)) AS avg_duration_microsecond -- / 1000000 = seconds
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_duration)) AS total_duration_microsecond -- / 1000000 = seconds
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_physical_io_reads) / SUM(qsrs.count_executions)) AS avg_physical_io_reads
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_physical_io_reads)) AS total_physical_io_reads
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_query_max_used_memory) / SUM(qsrs.count_executions)) AS avg_used_memory
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_query_max_used_memory)) AS total_used_memory
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_rowcount) / SUM(qsrs.count_executions)) AS avg_rowcount
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_rowcount)) AS total_rowcount
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_dop) / SUM(qsrs.count_executions)) AS avg_dop
      ,CONVERT(INT, SUM(qsrs.count_executions * qsrs.avg_dop)) AS total_dop
FROM   sys.query_store_query AS qsq
       INNER JOIN sys.query_store_plan AS qsp 
               ON qsp.query_id = qsq.query_id
       INNER JOIN sys.query_store_query_text AS qsqt
               ON qsqt.query_text_id = qsq.query_text_id
       INNER JOIN sys.query_store_runtime_stats AS qsrs 
               ON qsrs.plan_id = qsp.plan_id
       INNER JOIN sys.query_store_runtime_stats_interval AS qsrsi
               ON qsrsi.runtime_stats_interval_id = qsrs.runtime_stats_interval_id
--WHERE  qsrsi.end_time >= DATEADD(DAY,-1,GETDATE())
GROUP  BY qsq.query_id, qsqt.query_sql_text, qsp.plan_id, qsp.query_plan;

GO