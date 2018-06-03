USE master;

GO
-- Если, имеется несколько моментальных снимков, те, которые вы не хотите использовать при возврате, должены быть удалены.
RESTORE DATABASE TestSnapshot FROM DATABASE_SNAPSHOT = 'SNAP_TestSnapshot';

GO
/*
SELECT d.name AS database_name_source
      ,ds.name AS database_name_snapshot
      ,ds.create_date AS create_date_snapshot
FROM   sys.databases AS d
       INNER JOIN sys.databases AS ds
               ON ds.source_database_id = d.database_id
WHERE  d.name = 'TestSnapshot'
       AND d.snapshot_isolation_state_desc = 'OFF';
*/
GO