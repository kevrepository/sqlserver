SELECT t.[name]
      ,CONVERT(integer, CONVERT(binary(4), RIGHT(t.[name], 8), 2)) AS object_id_from_name
      ,t.[object_id]
      ,t.[type_desc]
      ,t.create_date
      ,t.modify_date
FROM   tempdb.sys.tables AS t
WHERE  t.[name] LIKE N'#[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]';
GO