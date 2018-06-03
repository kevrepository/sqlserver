USE master;

GO
-- Если, имеется несколько моментальных снимков, те, которые вы не хотите использовать при возврате, должены быть удалены.
RESTORE DATABASE database_name FROM DATABASE_SNAPSHOT = 'database_snapshot_name';

GO