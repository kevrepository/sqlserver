/*
    wait_completed
        Фиксирует завершенные ожидания.
    wait_info
        Фиксирует, когда начинается ожидание, и когда кончается ожидание.
    wait_info_external
        Когда SQL Server запускает внешнюю задачу, выполняющуюся в превентивном режиме.
*/

CREATE EVENT SESSION [Wait Statistics] ON SERVER
ADD EVENT sqlos.wait_info
(
    ACTION (sqlserver.session_id, sqlserver.plan_handle, sqlserver.sql_text)
    WHERE  (sqlserver.session_id = 58 AND wait_type = 'PAGELATCH_EX')
),ADD EVENT sqlos.wait_completed
(
    ACTION (sqlserver.session_id, sqlserver.plan_handle, sqlserver.sql_text)
    WHERE  (sqlserver.session_id = 58)
)
ADD TARGET package0.event_file
( 
    SET FILENAME = 'D:\Wait Statistics.xel'
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
ALTER EVENT SESSION [Wait Statistics] ON SERVER STATE = START;
ALTER EVENT SESSION [Wait Statistics] ON SERVER STATE = STOP;
DROP EVENT SESSION [Wait Statistics] ON SERVER;
*/
