SELECT *
FROM   table_name
WHERE  %%lockres%% = sys.dm_tran_locks.resource_description;