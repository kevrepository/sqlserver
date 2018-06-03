;WITH regressions
AS
(
    SELECT qsq.query_id
	      ,qsq.query_text_id
		  ,qsp.plan_id
		  ,qsp2.plan_id AS plan_id2
          ,qsp.query_plan
		  ,qsp2.query_plan AS query_plan2
		  ,qsrs.avg_duration
		  ,qsp2.avg_duration AS avg_duration2
          ,ROW_NUMBER() OVER (PARTITION BY qsp.plan_id ORDER BY qsrs.avg_duration) AS row_num
    FROM   sys.query_store_query AS qsq
	       INNER JOIN sys.query_store_plan AS qsp 
	               ON qsp.query_id = qsq.query_id
           INNER JOIN sys.query_store_runtime_stats AS qsrs
		           ON qsrs.plan_id = qsp.plan_id
           INNER JOIN sys.query_store_runtime_stats_interval AS qsrsi
		           ON qsrsi.runtime_stats_interval_id = qsrs.runtime_stats_interval_id
           CROSS APPLY (SELECT TOP 1 qsp.query_plan
		                            ,qsp.plan_id
									,qsrs.avg_duration
                        FROM   sys.query_store_plan AS qsp2
                               INNER JOIN sys.query_store_runtime_stats AS qsrs2
							           on qsp2.plan_id = qsrs2.plan_id
                               INNER JOIN sys.query_store_runtime_stats_interval AS qsrsi2
							           on qsrs2.runtime_stats_interval_id = qsrsi2.runtime_stats_interval_id
                        WHERE  qsp2.query_id  = qsq.query_id
						       AND qsp2.plan_id <> qsp.plan_id
							   AND qsrsi2.start_time > qsrsi.start_time
							   AND qsrs2.avg_duration >= qsrs.avg_duration * 2
                        ORDER  BY qsrs2.avg_duration DESC) AS qsp2
    WHERE  qsrsi.start_time >= DATEADD(DAY,-3, SYSDATETIME())
)

SELECT r.query_id
      ,qsqst.query_sql_text
	  ,r.plan_id
	  ,r.query_plan
	  ,r.plan_id2
	  ,r.query_plan2
      ,r.avg_duration
	  ,r.avg_duration2
FROM   regressions r 
       INNER JOIN sys.query_store_query_text AS qsqst 
	           ON qsqst.query_text_id = r.query_text_id
WHERE  r.row_num = 1
ORDER  BY r.avg_duration2 / r.avg_duration DESC;

GO