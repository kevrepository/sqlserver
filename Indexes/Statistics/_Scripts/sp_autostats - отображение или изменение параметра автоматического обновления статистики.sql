/*
    sp_autostats [ @tblname = ] 'table_or_indexed_view_name'   
        [ , [ @flagc = ] 'stats_value' ]   
        [ , [ @indname = ] 'statistics_name' ] 

    table_or_indexed_view_name
        Имя таблицы или индексированного представления.
    stats_value
        Обновляет параметр AUTO_UPDATE_STATISTICS, присваивая ему ON или OFF.
    
        Когда stats_flag — не указан, отображается текущее значение AUTO_UPDATE_STATISTICS.
    statistics_name
        Имя объекта статистики для отображения или обновления параметра AUTO_UPDATE_STATISTICS.
        
        Значение по умолчанию NULL.

    https://docs.microsoft.com/ru-ru/sql/relational-databases/system-stored-procedures/sp-autostats-transact-sql
*/