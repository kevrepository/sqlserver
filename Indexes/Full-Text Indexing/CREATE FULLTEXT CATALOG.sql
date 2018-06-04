/*
    CREATE FULLTEXT CATALOG catalog_name  
         [WITH <catalog_option>]  
         [AS DEFAULT]  
         [AUTHORIZATION owner_name ]  
    
    <catalog_option> ::= ACCENT_SENSITIVITY = {ON|OFF}

    ACCENT_SENSITIVITY = {ON|OFF}
        Указывает, будет ли каталог учитывать диакритические знаки для полнотекстового индексирования. Если это свойство меняется, индекс перестраивается.

    AS DEFAULT
        Указывает, что каталог является каталогом по умолчанию. Установка этого нового каталога AS DEFAULT сделает этот каталог полнотекстовым каталогом по умолчанию.

    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/create-fulltext-catalog-transact-sql
*/