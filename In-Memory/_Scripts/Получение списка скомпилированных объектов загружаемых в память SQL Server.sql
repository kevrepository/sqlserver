SELECT [object_id]
      ,SCHEMA_NAME([schema_id]) + '.' + [name] AS [object_name]
FROM   sys.tables
WHERE  is_memory_optimized = 1;


SELECT  SCHEMA_NAME([schema_id]) + '.' + [name] AS [object_name]
FROM    sys.table_types
WHERE   is_memory_optimized = 1;

SELECT  p.[object_id]
       ,SCHEMA_NAME(p.[schema_id]) + '.' + p.name AS [object_name]        
FROM    sys.all_sql_modules AS asm
        INNER JOIN sys.procedures AS p
                ON asm.object_id = p.object_id
WHERE   asm.uses_native_compilation = 1;

SELECT base_address
      ,file_version
      ,[language]
      ,[description]
      ,[name]
FROM   sys.dm_os_loaded_modules
WHERE  [description] = 'XTP Native DLL';