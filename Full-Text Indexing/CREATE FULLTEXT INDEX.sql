/*
    CREATE FULLTEXT INDEX ON table_name  
       [ ( { column_name   
                 [ TYPE COLUMN type_column_name ]  
                 [ LANGUAGE language_term ]   
                 [ STATISTICAL_SEMANTICS ]  
            } [ ,...n]   
          ) ]
        KEY INDEX index_name
        [ ON <catalog_filegroup_option> ]
        [ WITH [ ( ] <with_option> [ ,...n] [ ) ] ]
    [;]

    <catalog_filegroup_option>::=  
    {  
       fulltext_catalog_name   
    | ( fulltext_catalog_name, FILEGROUP filegroup_name )  
    | ( FILEGROUP filegroup_name, fulltext_catalog_name )  
    | ( FILEGROUP filegroup_name )  
    }  
    
    <with_option>::=  
    {  
      CHANGE_TRACKING [ = ] { MANUAL | AUTO | OFF [, NO POPULATION ] }   
    | STOPLIST [ = ] { OFF | SYSTEM | stoplist_name }
    | SEARCH PROPERTY LIST [ = ] property_list_name   
    }  

    TYPE COLUMN type_column_name
        Задает имя столбца, который содержит тип документа для документов, загружаемых в типы BLOB, такие как .doc, .pdf и .xls. 
        Эта опция используется только для varbinary, varbinary(max) и типов данных изображения. 

    STATISTICAL_SEMANTICS
        Создает дополнительные индексы ключевых фраз и подобия документов, которые являются частью статистического семантического индексирования.
    
    KEY INDEX index_name
        Имя индекса уникального индекса в table_name. Индекс KEY INDEX должен быть уникальным столбцом с одним ключом, не допускающим значения NULL.
        Выбрать минимально возможный индекс ключа для полнотекстового уникального ключа. 
        Для оптимальной производительности рекомендуется использовать для полнотекстовых ключей тип данных integer.

    CHANGE_TRACKING [ = ] { MANUAL | AUTO | OFF [, NO POPULATION ] }  
        Указывает, будет ли SQL Server распространять на полнотекстовый индекс изменения (обновления, удаления или вставки), выполненные в столбцах таблицы, которые включены в полнотекстовый индекс. 
        Изменения данных, внесенные с помощью инструкций WRITETEXT и UPDATETEXT, не отражаются в полнотекстовом индексе и не отмечаются при отслеживании изменений.
        Аргумент AUTO используется по умолчанию.

        MANUAL
            Указывает, что отслеживаемые изменения должны распространяться вручную путем вызова инструкции ALTER FULLTEXT INDEX … START UPDATE POPULATION.
            Агент SQL Server можно использовать для периодического вызова инструкции Transact-SQL .
            
        AUTO (по умолчанию)
            Указывает, что отслеживаемые изменения будут распространяться автоматически при изменениях данных в базовой таблице (автоматическое заполнение). 
            Изменения могут распространяться автоматически, однако это не значит, что они будут немедленно отражаться в полнотекстовом индексе. 
            
        OFF 
            Указывает, что в SQL Server не хранится список изменений индексированных данных.
        
        [ , NO POPULATION]
            Если аргумент NO POPULATION не указан, SQL Server заполняет индекс полностью, после того как он был создан.
            
            Аргумент NO POPULATION может использоваться только в том случае, если аргументу CHANGE_TRACKING присвоено значение OFF. 
            Если указан аргумент NO POPULATION, SQL Server не заполняет индекс после его создания. 
            Индекс заполняется только после выполнения пользователем команды ALTER FULLTEXT INDEX с предложением START FULL POPULATION или START INCREMENTAL POPULATION.
            
    STOPLIST [ = ] { OFF | SYSTEM | stoplist_name }  
        Связывает полнотекстовый список стоп-слов с индексом. Индекс не заполняется токенами, которые являются частью указанного списка стоп-слов. 
        Если список STOPLIST не указан, SQL Server связывает с индексом системный полнотекстовый список стоп-слов.
            
        OFF
            Указывает, что с полнотекстовым индексом не связан ни один из списков стоп-слов.

        SYSTEM
            Указывает, что для полнотекстового индекса должен использоваться системный полнотекстовый список стоп-слов.

        stoplist_name
            Задает имя списка стоп-слов, который будет связан с полнотекстовым индексом.

    SEARCH PROPERTY LIST [ = ] property_list_name
        Связывает список свойств поиска с индексом.

        OFF
            Указывает, что с полнотекстовым индексом не связан ни один список свойств.

        property_list_name
            Задает имя списка свойств поиска, который будет связан с полнотекстовым индексом.

    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/create-fulltext-index-transact-sql
*/