SELECT t.name AS table_name
      ,mc.name AS column_name
      ,mc.masking_function
FROM   sys.masked_columns AS mc
       INNER JOIN sys.tables AS t
               ON mc.object_id = t.object_id
ORDER  BY table_name, column_name;