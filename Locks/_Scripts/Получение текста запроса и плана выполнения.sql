DECLARE @Handle         varbinary(max)
       ,@StatementStart int
       ,@StatementEnd   int;

SELECT SUBSTRING(deqt.text, (deqs.statement_start_offset / 2) + 1,
           ((CASE
             WHEN deqs.statement_end_offset = -1 THEN DATALENGTH(deqt.text)
             ELSE deqs.statement_end_offset
             END - deqs.statement_start_offset) / 2) + 1) AS query_text
      ,deqp.query_plan
      ,deqs.creation_time
      ,deqs.last_execution_time
from   sys.dm_exec_query_stats AS deqs WITH (NOLOCK)
       CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS deqt
       OUTER APPLY sys.dm_exec_query_plan(deqs.plan_handle) AS deqp
where  deqs.sql_handle = @Handle 
       AND deqs.statement_start_offset = @StatementStart
       AND deqs.statement_end_offset = @StatementEnd
OPTION (RECOMPILE);