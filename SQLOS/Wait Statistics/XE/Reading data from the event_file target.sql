/*
    SELECT dxoc.object_name
          ,dxoc.column_id
          ,dxoc.name
          ,dxoc.type_name AS data_type_name
          ,dxoc.column_type AS column_type_name
          ,dxoc.column_value
          ,dxoc.description
    FROM   sys.dm_xe_object_columns AS dxoc
    WHERE  dxoc.object_name IN ('wait_info', 'wait_completed')
    ORDER  BY dxoc.object_name, dxoc.column_id;
*/

DECLARE @Path        nvarchar(260)
       ,@SessionName nvarchar(256) = 'Wait Statistics';

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
), EventInfo
AS
(
    SELECT event_data.value('/event[1]/@timestamp', 'datetime') AS timestamp
          ,event_data.value('/event[1]/@name', 'nvarchar(128)') AS name
          ,event_data.value('(/event[1]/action[@name="session_id"]/value)[1]', 'smallint') AS session_id
          ,event_data.value('(/event[1]/data[@name="wait_type"]/text)[1]', 'nvarchar(max)') AS wait_type
          ,event_data.value('(/event[1]/data[@name="duration"]/value)[1]', 'nvarchar(max)') AS duration
          ,event_data.value('(/event[1]/data[@name="signal_duration"]/value)[1]', 'nvarchar(max)') AS signal_duration
          ,event_data.value('(/event[1]/data[@name="wait_resource"]/value)[1]', 'nvarchar(max)') AS wait_resource
          ,event_data.value('(/event[1]/action[@name="sql_text"]/value)[1]', 'nvarchar(max)') AS sql_text
          ,event_data.value('xs:hexBinary((/event[1]/action[@name="plan_handle"]/value)[1])', 'varbinary(64)') AS plan_handle
          ,file_name
          ,file_offset          
    FROM   TargetData
)

SELECT EI.timestamp
      ,EI.file_name
      ,EI.file_offset
      ,EI.session_id
      ,EI.name
      ,EI.wait_type
      ,EI.duration
      ,EI.wait_resource
      ,EI.sql_text
      ,deqp.query_plan
FROM   EventInfo AS EI
       OUTER APPLY sys.dm_exec_query_plan(EI.plan_handle) AS deqp
ORDER  BY timestamp;
GO