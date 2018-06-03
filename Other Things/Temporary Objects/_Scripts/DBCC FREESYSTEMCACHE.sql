/*
    MARK_IN_USE_FOR_REMOVAL
        Асинхронно освобождает текущие используемые элементы из соответствующих кэшей после того, как они перестают использоваться.
*/
DBCC FREESYSTEMCACHE('Temporary Tables & Table Variables')
    WITH MARK_IN_USE_FOR_REMOVAL;
GO