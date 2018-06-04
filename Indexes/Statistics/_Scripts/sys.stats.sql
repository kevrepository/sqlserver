SELECT OBJECT_SCHEMA_NAME(s.object_id) + N'.' + OBJECT_NAME(s.object_id) AS [object_name]
      ,s.name AS statistic_name
      ,c.column_id
      ,c.name AS column_name
      ,s.auto_created
      ,s.user_created
      ,s.no_recompute
      ,s.has_filter
      ,s.filter_definition
      ,s.is_temporary
      ,s.is_incremental
FROM   sys.stats AS s
       INNER JOIN sys.stats_columns AS sc
               ON s.stats_id = sc.stats_id
                  AND s.object_id = sc.object_id
       INNER JOIN sys.columns AS c
               ON sc.column_id = c.column_id
                  AND sc.object_id = c.object_id
WHERE  s.object_id = OBJECT_ID(N'Person.Address')
ORDER  BY s.name, sc.column_id;