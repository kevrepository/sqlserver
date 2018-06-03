/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-server-audit-specification-transact-sql

    CREATE SERVER AUDIT SPECIFICATION audit_specification_name  
    FOR SERVER AUDIT audit_name  
    {  
        { ADD ( { audit_action_group_name } )   
        } [, ...n]  
        [ WITH ( STATE = { ON | OFF } ) ]  
    }  
    [ ; ]  
    
    https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-server-audit-specification-transact-sql

    ALTER SERVER AUDIT SPECIFICATION audit_specification_name  
    {  
        [ FOR SERVER AUDIT audit_name ]  
        [ { { ADD | DROP } ( audit_action_group_name )  
          } [, ...n] ]  
        [ WITH ( STATE = { ON | OFF } ) ]  
    }  
    [ ; ]

    https://docs.microsoft.com/en-us/sql/t-sql/statements/drop-server-audit-specification-transact-sql

    DROP SERVER AUDIT SPECIFICATION audit_specification_name  
    [ ; ]  

    audit_action_group_name
        https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions
    
    ALTER SERVER AUDIT SPECIFICATION
        https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-server-audit-specification-transact-sql

    DROP SERVER AUDIT SPECIFICATION
        https://docs.microsoft.com/en-us/sql/t-sql/statements/drop-server-audit-specification-transact-sql
*/

USE master;
GO

CREATE SERVER AUDIT SPECIFICATION audit_specification_name
    FOR SERVER AUDIT audit_name
    ADD (SERVER_ROLE_MEMBER_CHANGE_GROUP);
GO

/*
    ALTER SERVER AUDIT SPECIFICATION audit_specification_name
        WITH (STATE = ON);

    DROP SERVER AUDIT SPECIFICATION audit_specification_name;
*/