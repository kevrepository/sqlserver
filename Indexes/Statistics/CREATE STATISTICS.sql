/*
    CREATE STATISTICS statistics_name ON { table_or_indexed_view_name } ( column [ ,...n ] )
        [ WHERE <filter_predicate> ]  
        [ WITH   
            [ [ FULLSCAN   
                [ [ , ] PERSIST_SAMPLE_PERCENT = { ON | OFF } ]    
              | SAMPLE number { PERCENT | ROWS }   
                [ [ , ] PERSIST_SAMPLE_PERCENT = { ON | OFF } ]
            [ [ , ] NORECOMPUTE ]   
            [ [ , ] INCREMENTAL = { ON | OFF } ] 
            [ [ , ] MAXDOP = max_degree_of_parallelism ]
        ] ;  

    <filter_predicate> ::=   
        <conjunct> [AND <conjunct>]  

    <conjunct> ::=  
        <disjunct> | <comparison>  

    <disjunct> ::=  
            column_name IN (constant ,Е)  

    <comparison> ::=  
            column_name <comparison_op> constant  

    <comparison_op> ::=  
        IS | IS NOT | = | <> | != | > | >= | !> | < | <= | !<  

    FULLSCAN
        ¬ычисл€ет статистику путем сканировани€ всех строк.
    SAMPLE number { PERCENT | ROWS }
        ”казывает приблизительное процентное соотношение или число строк в таблице или индексированном представлении дл€ оптимизатора запросов, которые используютс€ при создании статистики. 
    PERSIST_SAMPLE_PERCENT
        —охран€ет процент выборки набора дл€ последующих обновлений, в которых €вно не указан процент выборки.
    RESAMPLE
        ќбновить каждый объект статистики, использу€ последнее значение частоты выборки.
    NORECOMPUTE
        ќтключить параметр автоматического обновлени€ статистики AUTO_UPDATE_STATISTICS дл€ указанной статистики.

    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/create-statistics-transact-sql
*/