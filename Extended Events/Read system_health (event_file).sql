-- https://docs.microsoft.com/en-us/sql/relational-databases/extended-events/use-the-system-health-session

DECLARE @Path        nvarchar(260)
       ,@SessionName nvarchar(256) = 'system_health';

SET @Path = (SELECT LEFT(dxsoc.column_value, LEN(dxsoc.column_value) - CHARINDEX('.', REVERSE(dxsoc.column_value))) + '*.' + 
                    RIGHT(dxsoc.column_value, CHARINDEX('.', REVERSE(dxsoc.column_value)) - 1)
             FROM   sys.dm_xe_session_object_columns AS dxsoc 
                    INNER JOIN sys.dm_xe_sessions AS dxs 
                            ON dxs.address = dxsoc.event_session_address
             WHERE dxs.name = @SessionName
                   AND dxsoc.object_name = 'event_file'
                   AND dxsoc.column_name = 'filename');

;WITH TargetData
AS
(
    SELECT CONVERT(XML, event_data) AS event_data
          ,file_name
          ,file_offset
    FROM   sys.fn_xe_file_target_read_file(@Path, NULL, NULL, NULL)
)

SELECT event_data.value('/event[1]/@timestamp', 'datetime') AS timestamp
      ,event_data.value('/event[1]/@name', 'nvarchar(128)') AS name
FROM   TargetData
GO