DECLARE @SessionName nvarchar(256) = 'ExaminingHistogram';

;WITH TargetData
AS
(
    SELECT CONVERT(XML, dxst.target_data) AS target_data
    FROM   sys.dm_xe_sessions AS dxs
           INNER JOIN sys.dm_xe_session_targets AS dxst 
                   ON dxst.event_session_address = dxs.address
    WHERE  dxs.name = @SessionName
           AND dxst.target_name = 'histogram'
), EventInfo
AS
(
    SELECT TD.event.value('((./value)/text())[1]', 'smallint') AS [source]
          ,TD.event.value('@count','int') AS [count]
    FROM   TargetData
           CROSS APPLY TargetData.target_data.nodes('/HistogramTarget/Slot') AS TD(event)
)

SELECT EI.[source]
      ,EI.[count]
FROM   EventInfo AS EI;

GO