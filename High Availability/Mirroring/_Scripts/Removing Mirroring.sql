-- 1. Principal Server Database.
ALTER DATABASE database_name SET PARTNER OFF;

GO

DROP ENDPOINT end_point_name;

GO

-- 2. Mirror Server Database.
DROP DATABASE database_name;

GO

DROP ENDPOINT end_point_name;

GO

-- 3. Witness Server Database.
DROP ENDPOINT end_point_name;

GO

/*
SELECT name
      ,type_desc
      ,port
      ,ip_address 
FROM   sys.tcp_endpoints;

SELECT name
      ,role_desc
      ,state_desc 
FROM   sys.database_mirroring_endpoints;
*/  