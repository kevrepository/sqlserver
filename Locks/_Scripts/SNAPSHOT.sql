/*
    ALTER DATABASE { database_name  | CURRENT } SET ALLOW_SNAPSHOT_ISOLATION ON
        [ WITH ROLLBACK AFTER integer [ SECONDS ]
             | ROLLBACK IMMEDIATE
             | NO_WAIT ];

    ROLLBACK AFTER integer [SECONDS] | ROLLBACK IMMEDIATE
        ”казывает, нужно ли откатить транзакции через указанное количество секунд или немедленно.
    NO_WAIT
        ”казывает, что если требуемое изменение состо€ни€ или параметра базы данных не может быть выполнено немедленно без ожидани€ фиксации или отката содержащей его транзакции, 
        то запрос потерпит неудачу.
*/

ALTER DATABASE CURRENT SET ALLOW_SNAPSHOT_ISOLATION OFF;
GO