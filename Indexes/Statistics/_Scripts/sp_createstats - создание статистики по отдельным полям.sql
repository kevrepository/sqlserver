/*
    sp_createstats   
        [   [ @indexonly =   ] { 'indexonly'   | 'NO' } ]   
        [ , [ @fullscan =    ] { 'fullscan'    | 'NO' } ]   
        [ , [ @norecompute = ] { 'norecompute' | 'NO' } ]  
        [ , [ @incremental = ] { 'incremental' | 'NO' } ]  
    
    indexonly
        Создает статистику только по столбцам, которые входят в существующий индекс, 
        причем ни один из столбцов не должен быть первым столбцом в определении индекса.

        Значение по умолчанию NO.
    fullscan
        Использует CREATE STATISTICS инструкции с FULLSCAN параметр.
        
        Значение по умолчанию NO.    
    norecompute
        Использует CREATE STATISTICS инструкции с NORECOMPUTE параметр.

        Значение по умолчанию NO.    
    incremental
        Использует CREATE STATISTICS инструкции с INCREMENTAL = ON параметр.

        Значение по умолчанию NO.
    
    Значения кода возврата: 0 (успешное завершение) или 1 (неуспешное завершение).

    https://docs.microsoft.com/ru-ru/sql/relational-databases/system-stored-procedures/sp-createstats-transact-sql
*/