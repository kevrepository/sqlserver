-- https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/query-store-stored-procedures-transact-sql

-- Cбрасывает данные, наход€щиес€ в пам€ти на диск.
-- sys.sp_query_store_flush_db;

-- ѕозвол€ет форсировать конкретный план дл€ конкретного запроса.
-- sp_query_store_force_plan query_id, plan_id;

-- ”дал€ет один план из хранилища запросов.
-- sp_query_store_remove_plan plan_id;

-- ”дал€ет запрос, а также все св€занные с ним планы и статистику времени выполнени€ из хранилища запросов.
-- sp_query_store_remove_query query_id;

-- ”дал€ет статистику времени выполнени€ дл€ конкретного плана запроса из хранилища запросов.
-- sp_query_store_reset_exec_stats plan_id;

-- ѕозвол€ет отключить конкретный план дл€ конкретного запроса.
-- sp_query_store_unforce_plan query_id, plan_id;

