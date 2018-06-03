USE database_name;
GO

CREATE TABLE schema_name.table_name 
(
    column_name type_name MASKED WITH (FUNCTION = 'default()') NOT NULL
);

GO

ALTER TABLE schema_name.table_name ALTER COLUMN column_name ADD MASKED WITH (FUNCTION = 'default()');
GO

/*
  CREATE USER user_name WITHOUT LOGIN;
  
  GRANT SELECT ON OBJECT::schema_name.object_name TO user_name;
  
  –азрешить пользователю просматривать замаскированные данные.
  GRANT UNMASK TO user_name;
  
  ќтменить разрешение на просмотр замаскированных данных.
  REVOKE UNMASK TO user_name;
*/