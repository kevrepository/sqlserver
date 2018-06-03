/*
    Блокировки с низким приоритетом.

    NONE
        Продолжить ожидание блокировки с обычным приоритетом.

        Если MAX_DURATION больше 0, тогда транзакция выполняется в режиме блокировок с низким приоритетом в течении указанного времени.
    SELF
        Операция прерывается, если блокировка не может быть предоставлена ​​в течение времени, заданного параметром MAX_DURATION.
    BLOCKERS         
        Остановить все пользовательские транзакции, которые в данный момент блокируют SWITCH или ONLINE INDEX REBUILD, чтобы можно было продолжить данную операцию DDL.
*/

ALTER INDEX { index_name | ALL } ON <object> REBUILD
WITH
(
    ONLINE = ON ( WAIT_AT_LOW_PRIORITY ( MAX_DURATION = <time> [ MINUTES ] , ABORT_AFTER_WAIT = { NONE | SELF | BLOCKERS } ) )
);
GO

ALTER TABLE <object> SWITCH PARTITION source_partition_number_expression TO target_table
WITH
(
    WAIT_AT_LOW_PRIORITY ( MAX_DURATION = <time> [ MINUTES ] , ABORT_AFTER_WAIT = { NONE | SELF | BLOCKERS } )
);
GO