/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql

    CREATE DATABASE AUDIT SPECIFICATION audit_specification_name  
    {  
        FOR SERVER AUDIT audit_name   
            [ { ADD ( { <audit_action_specification> | audit_action_group_name } )   
          } [, ...n] ]  
        [ WITH ( STATE = { ON | OFF } ) ]  
    }  
    [ ; ]  
    <audit_action_specification>::=  
    {  
          action [ ,...n ]ON [ class :: ] securable BY principal [ ,...n ]  
    }

    audit_action_specification> | audit_action_group_name
        https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions

    ALTER DATABASE AUDIT SPECIFICATION
        https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-audit-specification-transact-sql

    DROP DATABASE AUDIT SPECIFICATION
        https://docs.microsoft.com/en-us/sql/t-sql/statements/drop-database-audit-specification-transact-sql
*/ 

USE master;
GO

CREATE DATABASE AUDIT SPECIFICATION audit_specification_name
    FOR SERVER AUDIT audit_name
    ADD (DELETE ON OBJECT::Person.Person BY public) ;
GO

/*
    CREATE DATABASE AUDIT SPECIFICATION audit_specification_name
        WITH (STATE = ON);

    DROP DATABASE AUDIT SPECIFICATION audit_specification_name;  
*/