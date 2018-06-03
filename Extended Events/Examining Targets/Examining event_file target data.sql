CREATE EVENT SESSION ExaminingEventFile ON SERVER
ADD EVENT sqlserver.sql_statement_starting 
(
    ACTION (sqlserver.session_id, sqlserver.plan_handle, sqlserver.sql_text)
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
), ADD EVENT sqlserver.sql_statement_completed 
(
    ACTION (sqlserver.session_id, sqlserver.plan_handle, sqlserver.sql_text)
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
), ADD EVENT sqlserver.sql_statement_recompile 
(
    ACTION (sqlserver.session_id, sqlserver.plan_handle, sqlserver.sql_text)
    WHERE  (sqlserver.like_i_sql_unicode_string(sqlserver.sql_text, N'%production.Product%'))
)
ADD TARGET package0.event_file
( 
    SET FILENAME = 'D:\ExaminingEventFile.xel'
       ,MAX_FILE_SIZE = 4096 
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
ALTER EVENT SESSION ExaminingEventFile ON SERVER STATE = START;
ALTER EVENT SESSION ExaminingEventFile ON SERVER STATE = STOP;
DROP EVENT SESSION ExaminingEventFile ON SERVER;
*/        