/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-login-transact-sql

    CREATE LOGIN login_name { WITH <option_list1> | FROM <sources> }  

    <option_list1> ::=   
        PASSWORD = { 'password' | hashed_password HASHED } [ MUST_CHANGE ]  
        [ , <option_list2> [ ,... ] ]  

    MUST_CHANGE        
        Если этот параметр задан, то при первом использовании нового имени входа SQL Server запрашивается новый пароль.

    <option_list2> ::=    
        SID = sid  
        | DEFAULT_DATABASE = database      
        | DEFAULT_LANGUAGE = language  
        | CHECK_EXPIRATION = { ON | OFF}  
        | CHECK_POLICY = { ON | OFF}  
        | CREDENTIAL = credential_name   
    
    CHECK_EXPIRATION
        Указывает, должна ли политика истечения срока действия паролей применяться к этому имени входа.
    CHECK_POLICY        
        Указывает, что политики паролей Windows компьютера, на котором работает SQL Server, должны применяться к этому имени входа.
    CREDENTIAL
        Имя учетных данных для сопоставления с новым именем входа SQL Server.
        
    <sources> ::=  
        WINDOWS [ WITH <windows_options>[ ,... ] ]  
        | CERTIFICATE certname  
        | ASYMMETRIC KEY asym_key_name  

    <windows_options> ::=        
        DEFAULT_DATABASE = database
        | DEFAULT_LANGUAGE = language
*/