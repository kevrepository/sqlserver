;WITH TargetData
AS
(
    SELECT CONVERT(XML, event_data) AS event_data
          ,file_name
          ,file_offset
    FROM   sys.fn_xe_file_target_read_file('X:\Blocked process report*.xel', NULL, NULL, NULL)
), EventInfo
AS
(
    SELECT file_name
          ,file_offset
          ,event_data.value('/event[1]/@timestamp', 'datetime') AS timestamp
          ,event_data.value('/event[1]/@name', 'sysname') AS name
          ,event_data.value('(/event[1]/action[@name="session_id"]/value)[1]', 'smallint') AS session_id
          ,event_data.query('(event/data[@name="blocked_process"]/value/blocked-process-report)[1]') AS blocked_process_report
    FROM   TargetData
)

SELECT EI.timestamp
      ,EI.file_name
      ,EI.file_offset
      ,EI.name
      ,EI.session_id
      ,EI.blocked_process_report
FROM   EventInfo AS EI;

GO
/*
SELECT LEFT(dxsoc.column_value, LEN(dxsoc.column_value) - CHARINDEX('.', REVERSE(dxsoc.column_value))) + '*.' + 
       RIGHT(dxsoc.column_value, CHARINDEX('.', REVERSE(dxsoc.column_value)) - 1)
FROM   sys.dm_xe_session_object_columns AS dxsoc
       INNER JOIN sys.dm_xe_sessions AS dxs
               ON dxs.address = dxsoc.event_session_address
where dxs.name = 'ExtendedEventStatement'
      AND dxsoc.object_name = 'event_file'
      AND dxsoc.column_name = 'filename';
*/
GO