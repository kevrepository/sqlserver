/*
    sp_spaceused [[ @objname = ] 'objname' ]   
    [, [ @updateusage = ] 'updateusage' ]  
    [, [ @mode = ] 'mode' ]  
    [, [ @oneresultset = ] oneresultset ]  
    [, [ @include_total_xtp_storage = ] include_total_xtp_storage ]

    @objname
        Имя таблицы или индексированного представления.
    @updateusage
        Указывает, что для обновления сведений об использовании места на диске следует запустить инструкцию DBCC UPDATEUSAGE.
*/

EXEC sp_spaceused N'dbo.FactInternetSales', TRUE;