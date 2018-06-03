/*
    ALTER DATABASE { database_name  | CURRENT } SET READ_COMMITTED_SNAPSHOT ON
        [ WITH ROLLBACK AFTER integer [ SECONDS ]
             | ROLLBACK IMMEDIATE
             | NO_WAIT ];

    ROLLBACK AFTER integer [SECONDS] | ROLLBACK IMMEDIATE
        ”казывает, нужно ли откатить транзакции через указанное количество секунд или немедленно.
    NO_WAIT
        ”казывает, что если требуемое изменение состо€ни€ или параметра базы данных не может быть выполнено немедленно без ожидани€ фиксации или отката содержащей его транзакции, 
        то запрос потерпит неудачу.
*/

ALTER DATABASE CURRENT SET READ_COMMITTED_SNAPSHOT ON;
GO