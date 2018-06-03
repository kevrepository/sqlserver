/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-role-transact-sql

    CREATE ROLE role_name [ AUTHORIZATION owner_name ]

    AUTHORIZATION owner_name
        Пользователь (или роль) базы данных, который станет владельцем новой роли. 
        Если пользователь не указан, владельцем роли станет пользователь, выполнивший инструкцию CREATE ROLE.
*/

CREATE ROLE role_name AUTHORIZATION owner_name;  