DECLARE @SessionName nvarchar(256) = 'ExaminingRingBuffer';

;WITH TargetData
AS
(
    SELECT CONVERT(XML, dxst.target_data) AS target_data
    FROM   sys.dm_xe_sessions AS dxs
           INNER JOIN sys.dm_xe_session_targets AS dxst 
                   ON dxst.event_session_address = dxs.address
    WHERE  dxs.name = @SessionName
           AND dxst.target_name = 'ring_buffer'
), EventInfo
AS
(
    SELECT TD.event.value('@timestamp', 'datetime') AS timestamp
          ,TD.event.value('@name', 'nvarchar(128)') AS name
          ,TD.event.value('(data[@name="physical_reads"]/value)[1]', 'bigint') AS physical_reads
          ,TD.event.value('(data[@name="logical_reads"]/value)[1]', 'bigint') AS logical_reads
          ,TD.event.value('(action[@name="session_id"]/value)[1]', 'smallint') AS session_id
          ,TD.event.value('(action[@name="sql_text"]/value)[1]', 'nvarchar(max)') AS sql_text
          ,TD.event.value('xs:hexBinary((action[@name="plan_handle"]/value)[1])', 'varbinary(64)') AS plan_handle
    FROM   TargetData
           CROSS APPLY TargetData.target_data.nodes('/RingBufferTarget/event') AS TD(event)
)

SELECT EI.timestamp
      ,EI.name
      ,EI.session_id
      ,EI.physical_reads
      ,EI.logical_reads
      ,EI.sql_text
      ,dxqp.query_plan
FROM   EventInfo AS EI 
       OUTER APPLY sys.dm_exec_query_plan(EI.plan_handle) AS dxqp;

GO