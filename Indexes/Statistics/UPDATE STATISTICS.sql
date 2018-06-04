/*
    UPDATE STATISTICS table_or_indexed_view_name ( { index_or_statistics_name } [ ,...n ] )
    [    WITH   
        [  
            FULLSCAN   
              [ [ , ] PERSIST_SAMPLE_PERCENT = { ON | OFF } ]    
            | SAMPLE number { PERCENT | ROWS }   
              [ [ , ] PERSIST_SAMPLE_PERCENT = { ON | OFF } ]    
            | RESAMPLE   
              [ ON PARTITIONS ( { <partition_number> | <range> } [, Еn] ) ]
        ]   
        [ [ , ] [ ALL | COLUMNS | INDEX ]   
        [ [ , ] NORECOMPUTE ]   
        [ [ , ] INCREMENTAL = { ON | OFF } ] 
        [ [ , ] MAXDOP = max_degree_of_parallelism ] 
    ] ;  


    FULLSCAN
        ¬ычисл€ет статистику путем просмотра всех строк в таблице или индексированном представлении.
    SAMPLE number { PERCENT | ROWS }
        ”казывает приблизительное процентное соотношение или число строк в таблице или индексированном представлении дл€ оптимизатора запросов, которые используютс€ при обновлении статистики.
    PERSIST_SAMPLE_PERCENT
        —охран€ет процент выборки набора дл€ последующих обновлений, в которых €вно не указан процент выборки.
    RESAMPLE
        ќбновить каждый объект статистики, использу€ последнее значение частоты выборки.

    ALL | COLUMNS | INDEX
        ќбновить всю существующую статистику, созданную по одному или нескольким столбцам, или статистику, созданную дл€ индексов.
    NORECOMPUTE
        ќтключить параметр автоматического обновлени€ статистики AUTO_UPDATE_STATISTICS дл€ указанной статистики.

    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/update-statistics-transact-sql
*/