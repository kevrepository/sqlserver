CREATE EVENT SESSION ExaminingEventCounter ON SERVER
ADD EVENT sqlserver.sql_statement_starting 
(
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
), ADD EVENT sqlserver.sql_statement_completed 
(
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
), ADD EVENT sqlserver.sql_statement_recompile 
(
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
)
ADD TARGET package0.event_counter
WITH
(
    MAX_MEMORY = 4096KB
   ,EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS
   ,MAX_DISPATCH_LATENCY = 15 SECONDS
   ,TRACK_CAUSALITY = OFF
   ,MEMORY_PARTITION_MODE = NONE
   ,STARTUP_STATE = OFF
);

/*
ALTER EVENT SESSION ExaminingEventCounter ON SERVER STATE = START;
ALTER EVENT SESSION ExaminingEventCounter ON SERVER STATE = STOP;
DROP EVENT SESSION ExaminingEventCounter ON SERVER;
*/        