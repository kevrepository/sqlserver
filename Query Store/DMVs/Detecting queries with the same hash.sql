-- Обнаружение запросов с одинаковым хешем.
SELECT TOP 100 qsq.query_hash
              ,COUNT(*) AS query_count
              ,AVG(qsrs.count_executions) AS count_executions_avg
FROM   sys.query_store_query AS qsq
       INNER JOIN sys.query_store_plan AS qsp
	           ON qsp.query_id = qsq.query_id
       INNER JOIN sys.query_store_runtime_stats AS qsrs
	           ON qsp.plan_id = qsrs.plan_id
GROUP  BY qsq.query_hash
HAVING COUNT(*) > 1
ORDER  BY count_executions_avg, query_count;

GO