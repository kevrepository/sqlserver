SELECT type AS cache_store
      ,SUM(pages_in_bytes) / 1024.0 AS size_in_kb
FROM   sys.dm_os_memory_objects
WHERE  TYPE IN ('MEMOBJ_CACHESTORESQLCP', 'MEMOBJ_CACHESTOREOBJCP', 'MEMOBJ_CACHESTOREXPROC','MEMOBJ_SQLMGR')
GROUP  BY TYPE;

/*
SELECT *
FROM   sys.dm_os_memory_cache_hash_tables
WHERE  type IN ('CACHESTORE_OBJCP', 'CACHESTORE_SQLCP', 'CACHESTORE_XPROC', 'CACHESTORE_PHDR');
*/