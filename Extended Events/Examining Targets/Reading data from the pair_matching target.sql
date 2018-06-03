DECLARE @SessionName nvarchar(256) = 'ExaminingPairMatching';

;WITH TargetData
AS
(
    SELECT CONVERT(XML, dxst.target_data) AS target_data
    FROM   sys.dm_xe_sessions AS dxs
           INNER JOIN sys.dm_xe_session_targets AS dxst 
                   ON dxst.event_session_address = dxs.address
    WHERE  dxs.name = @SessionName
           AND dxst.target_name = 'pair_matching'
), EventInfo
AS
(
    SELECT TD.event.value('@timestamp','datetime') AS [timestamp]
          ,TD.event.value('@name','int') AS [name]
    FROM   TargetData
           CROSS APPLY TargetData.target_data.nodes('/PairingTarget/event') AS TD(event)
)

SELECT EI.[timestamp]
      ,EI.[name]
FROM   EventInfo AS EI;

GO