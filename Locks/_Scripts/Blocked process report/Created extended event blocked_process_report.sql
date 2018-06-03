CREATE EVENT SESSION blocked_process_report ON SERVER
ADD EVENT sqlserver.blocked_process_report 
ADD TARGET package0.event_file
( 
    SET filename = 'X:\Blocked process report.xel'
   ,max_file_size = 1000
)
WITH
(
    max_memory = 4096KB
   ,event_retention_mode = allow_single_event_loss
   ,max_dispatch_latency = 15 seconds
   ,track_causality = OFF
   ,memory_partition_mode = NONE
   ,startup_state = OFF
);

/*
ALTER EVENT SESSION blocked_process_report ON SERVER STATE = START;
ALTER EVENT SESSION blocked_process_report ON SERVER STATE = STOP;
DROP EVENT SESSION blocked_process_report ON SERVER;
*/