/*
    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch03.xhtml#Sec13
*/
SELECT OBJECT_SCHEMA_NAME(i.[object_id]) + N'.' + OBJECT_NAME(i.[object_id]) AS [object_name]
      ,i.[name] AS index_name
      ,STUFF((SELECT N', ' + c.name
              FROM   sys.index_columns AS ic
                     INNER JOIN sys.columns AS c
                             ON ic.[object_id] = c.[object_id]
                                AND ic.column_id = c.column_id
              WHERE  ic.[object_id] = i.[object_id]
                     AND ic.index_id = i.index_id
              ORDER  BY ic.index_column_id
              FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS [index_columns]
      ,i.type_desc AS index_type_desc
      ,i.is_primary_key
      ,i.is_unique_constraint
      ,i.is_unique
      ,i.ignore_dup_key
      ,i.fill_factor
      ,i.is_disabled
      ,i.is_hypothetical
      ,i.allow_row_locks
      ,i.allow_page_locks
      ,i.has_filter
      ,i.filter_definition
      ,ddius.user_seeks
      ,ddius.user_scans
      ,ddius.user_lookups
      ,ddius.user_updates
      ,ddius.last_user_seek
      ,ddius.last_user_scan
      ,ddius.last_user_lookup
      ,ddius.last_user_update
FROM   sys.indexes AS i
       LEFT JOIN sys.dm_db_index_usage_stats AS ddius
              ON i.object_id = ddius.object_id
                 AND i.index_id = ddius.index_id
                 AND ddius.database_id = DB_ID()
WHERE  i.object_id = OBJECT_ID('Person.Address')
ORDER  BY [object_name], index_name;

--OBJECTPROPERTY(i.object_id, 'IsUserTable') = 1