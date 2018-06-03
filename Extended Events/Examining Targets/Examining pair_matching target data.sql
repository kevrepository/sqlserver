CREATE EVENT SESSION ExaminingPairMatching ON SERVER
ADD EVENT sqlserver.sql_statement_starting 
(
    ACTION (sqlserver.session_id, sqlserver.plan_handle, sqlserver.sql_text)
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
), ADD EVENT sqlserver.sql_statement_completed 
(
    ACTION (sqlserver.session_id, sqlserver.plan_handle, sqlserver.sql_text)
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
)
ADD TARGET package0.pair_matching
( 
    SET BEGIN_EVENT = 'sqlserver.sql_statement_starting'
       ,BEGIN_MATCHING_COLUMNS = 'statement'
       ,BEGIN_MATCHING_ACTIONS = 'sqlserver.session_id'
       ,END_EVENT = 'sqlserver.sql_statement_completed'
       ,END_MATCHING_COLUMNS = 'statement'
       ,END_MATCHING_ACTIONS = 'sqlserver.session_id'
       ,RESPOND_TO_MEMORY_PRESSURE = 0
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
ALTER EVENT SESSION ExaminingRingBuffer ON SERVER STATE = START;
ALTER EVENT SESSION ExaminingRingBuffer ON SERVER STATE = STOP;
DROP EVENT SESSION ExaminingRingBuffer ON SERVER;
*/        