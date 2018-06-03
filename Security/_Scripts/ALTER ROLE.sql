/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-role-transact-sql

    ALTER ROLE role_name  
    {  
           ADD MEMBER database_principal  
        |  DROP MEMBER database_principal  
        |  WITH NAME = new_name  
    }  
    [;]

    WITH NAME = new_name
        Указывает на изменение имени определяемой пользователем роли базы данных. 
        Новое имя еще не должно существовать в базе данных.
*/