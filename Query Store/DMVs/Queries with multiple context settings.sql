-- ќбнаружени€ запросов, которые загр€зн€ют кеш плана.
select qsq.query_id
      ,qsqt.query_sql_text
      ,COUNT(DISTINCT qsq.context_settings_id) AS  context_settings_count
      ,COUNT(DISTINCT qsp.plan_id) AS plan_count
from   sys.query_store_query AS qsq
       INNER JOIN sys.query_store_query_text AS qsqt
               ON qsqt.query_text_id = qsq.query_text_id
       INNER JOIN sys.query_store_plan AS qsp 
	           ON qsp.query_id = qsq.query_id
GROUP  BY qsq.query_id, qsqt.query_sql_text
HAVING COUNT(DISTINCT qsq.context_settings_id) > 1
ORDER  BY COUNT(DISTINCT qsq.context_settings_id);

GO