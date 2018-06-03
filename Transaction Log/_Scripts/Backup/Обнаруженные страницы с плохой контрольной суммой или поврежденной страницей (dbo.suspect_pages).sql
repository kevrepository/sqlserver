USE msdb;
GO

SELECT database_id
      ,file_id
      ,page_id
      ,event_type
      ,CASE event_type
       WHEN 1 THEN '823 or 824 error'
       WHEN 2 THEN 'Bad checksum'
       WHEN 3 THEN 'Torn page'
       WHEN 4 THEN 'Restored'        
       WHEN 5 THEN 'Repaired'
       WHEN 7 THEN 'Deallocated by DBCC CHECKDB'
       END AS event_type_desc
      ,error_count
      ,last_update_date
FROM   dbo.suspect_pages;
GO