USE master;

GO
-- https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store

USE master;

GO

ALTER DATABASE database_name SET QUERY_STORE = ON
(
    OPERATION_MODE = READ_WRITE
   ,DATA_FLUSH_INTERVAL_SECONDS = 900
   ,INTERVAL_LENGTH_MINUTES = 60
   ,MAX_STORAGE_SIZE_MB = 200
   ,CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 0)
   ,SIZE_BASED_CLEANUP_MODE = OFF
   ,QUERY_CAPTURE_MODE = ALL
);

GO
/*
ALTER DATABASE database_name SET QUERY_STORE 
(
    OPERATION_MODE = READ_WRITE
   ,DATA_FLUSH_INTERVAL_SECONDS = 900
   ,INTERVAL_LENGTH_MINUTES = 60
   ,MAX_STORAGE_SIZE_MB = 200
   ,CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 0)
   ,SIZE_BASED_CLEANUP_MODE = OFF
   ,QUERY_CAPTURE_MODE = ALL
);
*/
GO



/*
OPERATION_MODE
    READ_WRITE (по умолчанию) - собирает и сохраняет планы выполнения и статистику времени выполнения.
    READ_ONLY - позволяет читать даннные из хранилища запросов.

DATA_FLUSH_INTERVAL_SECONDS (по умолчанию 15 минут (900 секунд))
Определяет частоту, с которой данные, записанные в хранилище запросов, сохраняются на диск. Для оптимизации производительности данные, собранные хранилищем запросов, асинхронно записываются на диск.

INTERVAL_LENGTH_MINUTES (по умолчанию 60 минут)
Определяет временной интервал вычисления агрегировынных статистических данных о среде выполнения в хранилище запросов. Для оптимизации использования свободного места статистические данные времени выполнения в хранилище вычисляются для фиксированного интервала времени.

MAX_STORAGE_SIZE_MB (по умолчанию 100 МБ, таблицы хранилища данных помещаются в основную файловую группу)
Настраивает максимальный размер хранилища запросов. Если данные в хранилище запросов достигают заданного ограничения, хранилище запросов автоматически изменяет состояние с READ_WRITE на READ_ONLY и прекращает сбор новых данных.

CLEANUP_POLICY (STALE_QUERY_THRESHOLD_DAYS) (по умолчанию 30 дней)
Длительность хранения данных в хранилище запросов.

SIZE_BASED_CLEANUP_MODE (по умолчанию AUTO)
Определяет, будет ли автоматически активирована очистка, когда общий объем данных приблизится к верхней границе ограничения (80 процентов). Удаляет информацию о наименее дорогостоящих запросах. Может иметь значение AUTO или OFF.

QUERY_CAPTURE_MODE (по умолчанию ALL, SQL Server Azure AUTO)
Определяет запросы, собираемые в хранилище запросов (все запросы или только важные запросы), основываясь на показателях выполнения и потребления ресурсов; определяет отслеживание текущих запросов без добавления новых.
Может иметь значение ALL (регистрировать все запросы), AUTO (игнорировать редкие запросы и запросы с малой продолжительностью компиляции и выполнения) или NONE (остановить регистрацию новых запросов).

MAX_PLANS_PER_QUERY (по умолчанию 200)
Целое число, представляющее максимальное количество поддерживаемых планов для каждого запроса.
*/