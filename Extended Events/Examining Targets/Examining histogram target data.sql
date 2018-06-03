CREATE EVENT SESSION ExaminingHistogram ON SERVER
ADD EVENT sqlserver.sql_statement_starting 
(
    ACTION (sqlserver.session_id)
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
)
ADD TARGET package0.histogram
( 
    SET SLOTS = 32
       ,FILTERING_EVENT_NAME = 'sqlserver.sql_statement_starting'
       ,SOURCE_TYPE = 1
       ,SOURCE = 'session_id'
) 
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
ALTER EVENT SESSION ExaminingHistogram ON SERVER STATE = START;
ALTER EVENT SESSION ExaminingHistogram ON SERVER STATE = STOP;
DROP EVENT SESSION ExaminingHistogram ON SERVER;
*/        