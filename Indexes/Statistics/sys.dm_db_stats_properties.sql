/*
    sys.dm_db_stats_properties (object_id, stats_id)

    object_id
        Идентификатор объекта.
    stats_id
        Идентификатор статистики.

    rows
        Общее количество строк при последнем обновлении статистики.
    rows_sampled
        Общее количество строк, отбираемых для расчета статистики.
    steps
        Количество шагов в гистограмме.
    unfiltered_rows
        Общее количество строк в таблице перед применением выражения фильтра.
    modification_counter
        Количество вставленных, удаленных или обновленных строк с момента последнего обновления статистики для таблицы.
    persisted_sample_percent
        Постоянная частота выборки, используемая для статистических обновлений, которые явно не указывают процент выборки.
*/

SELECT OBJECT_SCHEMA_NAME(s.object_id) + N'.' + OBJECT_NAME(s.object_id) AS [object_name]
      ,s.[name] AS statistic_name
      ,ddsp.last_updated
      ,ddsp.[rows]
      ,ddsp.rows_sampled
      ,ddsp.steps
      ,ddsp.unfiltered_rows
      ,ddsp.modification_counter
FROM   sys.stats AS s
       CROSS APPLY sys.dm_db_stats_properties(object_id, stats_id) AS ddsp
WHERE  s.object_id = OBJECT_ID(N'Person.Address');