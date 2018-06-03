/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-schema-transact-sql

    CREATE SCHEMA schema_name_clause [ <schema_element> [ ...n ] ]  

    <schema_name_clause> ::=  
        {  
        schema_name  
        | AUTHORIZATION owner_name  
        | schema_name AUTHORIZATION owner_name  
        }  

    <schema_element> ::=   
        {   
            table_definition | view_definition | grant_statement |   
            revoke_statement | deny_statement   
        }  

    https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-schema-transact-sql

    ALTER SCHEMA schema_name   
        TRANSFER [ <entity_type> :: ] securable_name   
    [;]  

    <entity_type> ::=  
        {  
        Object | Type | XML Schema Collection  
        }  

    https://docs.microsoft.com/en-us/sql/t-sql/statements/drop-schema-transact-sql

    DROP SCHEMA  [ IF EXISTS ] schema_name
*/

USE database_name;
GO

CREATE SCHEMA schema_name AUTHORIZATION owner_name;
GO

/*
    Перенос объекта в другую схему.

    USE database_name
    GO

    CREATE TABLE table_name
    (
        column_name int NOT NULL
    ) ;
    GO

    ALTER SCHEMA chema_name TRANSFER table_name;
    GO
*/