SELECT OBJECT_NAME(t.parent_id) AS object_name
      ,te.type_desc
FROM   sys.triggers AS t
       INNER JOIN sys.trigger_events AS te
               ON t.object_id = te.object_id
GROUP  BY t.parent_id, te.type_desc
HAVING COUNT(*) > 1;