/*
    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/execute-as-transact-sql

    { EXEC | EXECUTE } AS <context_specification>  
    [;]  

    <context_specification>::=  
    { LOGIN | USER } = 'name'  
        [ WITH { NO REVERT | COOKIE INTO @varbinary_variable } ]   
    | CALLER

    https://docs.microsoft.com/en-us/sql/t-sql/statements/revert-transact-sql

    REVERT  
        [ WITH COOKIE = @varbinary_variable ] 

    
    
    GRANT IMPERSONATE ON USER:: user2 TO user1;
*/

EXECUTE AS USER = 'name';