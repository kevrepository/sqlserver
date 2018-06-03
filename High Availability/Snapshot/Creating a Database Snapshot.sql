--EXEC SP_HELPDB database_name;

CREATE DATABASE snapshot_database_name ON 
(
    NAME = logical_file_name 
   ,FILENAME  = 'os_file_name'
) 
AS SNAPSHOT OF source_database_name;

GO