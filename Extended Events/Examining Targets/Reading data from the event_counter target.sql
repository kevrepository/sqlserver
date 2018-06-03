DECLARE @SessionName nvarchar(256) = 'ExaminingEventCounter';

;WITH TargetData
AS
(
    SELECT CONVERT(XML, dxst.target_data) AS target_data
    FROM   sys.dm_xe_sessions AS dxs
           INNER JOIN sys.dm_xe_session_targets AS dxst 
                   ON dxst.event_session_address = dxs.address
    WHERE  dxs.name = @SessionName
           AND dxst.target_name = 'event_counter'
), EventInfo
AS
(
    SELECT TD.event.value('@name', 'nvarchar(128)') AS name
          ,TD.event.value('@count','bigint') AS count_event
    FROM   TargetData
           CROSS APPLY TargetData.target_data.nodes('/CounterTarget/Packages/Package[@name="sqlserver"]/Event') AS TD(event)
)

SELECT EI.name
      ,EI.count_event
FROM   EventInfo AS EI;

GO