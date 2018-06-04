/*
    INDEXPROPERTY ( object_ID , index_or_statistics_name , property )

    IndexDepth
        Глубина индекса.
    IndexFillFactor	
        Коэффициент заполнения.
    IndexID
        Идентификатор индекса.
    IsAutoStatistics
        Статистики были сформированы параметром AUTO_CREATE_STATISTICS инструкции ALTER DATABASE.
    IsClustered
        Кластеризованный индекс.
    IsDisabled
        Индекс отключен.
    IsFulltextKey
        Индекс является ключом для полнотекстового и семантического индексирования таблицы.
    IsHypothetical
        Индекс является гипотетическим.
    IsPadIndex
        Индекс задает пространство, которое должно оставаться свободным на каждом уровне индекса.
    IsPageLockDisallowed
        Значение блокировки страницы, установленное параметром ALLOW_PAGE_LOCKS инструкции ALTER INDEX.
    IsRowLockDisallowed	
        Значение блокировки строк, установленное параметром ALLOW_ROW_LOCKS инструкции ALTER INDEX.
    IsStatistics	
        Статистика, созданная с помощью инструкции CREATE STATISTICS или параметром AUTO_CREATE_STATISTICS инструкции ALTER DATABASE.
    IsUnique
        Индекс является уникальным.
    IsColumnstore
        Оптимизированный для памяти xVelocity индекс columnstore.

    https://docs.microsoft.com/ru-ru/sql/t-sql/functions/indexproperty-transact-sql
*/