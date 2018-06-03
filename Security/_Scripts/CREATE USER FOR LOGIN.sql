/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql

    CREATE USER user_name   
        [   
            { FOR | FROM } LOGIN login_name   
        ]  
        [ WITH <limited_options_list> [ ,... ] ]   
    [ ; ]

    <limited_options_list> ::=  
          DEFAULT_SCHEMA = schema_name ]   
        | ALLOW_ENCRYPTED_VALUE_MODIFICATIONS = [ ON | OFF ] ]  

    ALLOW_ENCRYPTED_VALUE_MODIFICATIONS
        ”казывает, что пользовател€м разрешено массовое копирование зашифрованных данных без предварительной дешифровки.
*/

CREATE USER user_name FOR LOGIN login_name
    WITH DEFAULT_SCHEMA = schema_name;