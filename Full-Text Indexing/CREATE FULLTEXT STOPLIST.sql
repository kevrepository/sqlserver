/*
    CREATE FULLTEXT STOPLIST stoplist_name  
    [ FROM { [ database_name.]source_stoplist_name } | SYSTEM STOPLIST ]  
    [ AUTHORIZATION owner_name ]  
    ;  

    source_stoplist_name
        Указывает, что новый список стоп-слов создается копированием существующего списка стоп-слов.

    SYSTEM STOPLIST
        Указывает, что новый список стоп-слов создается из списка стоп-слов, что существует по умолчанию в базы данных Resource.

    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/create-fulltext-stoplist-transact-sql

    ALTER FULLTEXT STOPLIST stoplist_name  
    {   
        ADD [N] 'stopword' LANGUAGE language_term    
      | DROP   
        {  
            'stopword' LANGUAGE language_term   
          | ALL LANGUAGE language_term   
          | ALL  
        }  
    }
    ;  

    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/alter-fulltext-stoplist-transact-sql
*/