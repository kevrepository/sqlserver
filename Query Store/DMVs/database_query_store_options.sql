-- https://docs.microsoft.com/ru-ru/sql/relational-databases/system-catalog-views/sys-database-query-store-options-transact-sql

SELECT desired_state_desc
      ,actual_state_desc
      ,readonly_reason
      ,current_storage_size_mb
      ,flush_interval_seconds
      ,interval_length_minutes
      ,max_storage_size_mb
      ,stale_query_threshold_days
      ,max_plans_per_query
      ,query_capture_mode_desc
      ,size_based_cleanup_mode_desc
      ,actual_state_additional_info
FROM   sys.database_query_store_options;