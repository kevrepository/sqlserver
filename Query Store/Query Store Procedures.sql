-- https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/query-store-stored-procedures-transact-sql

-- C��������� ������, ����������� � ������ �� ����.
-- sys.sp_query_store_flush_db;

-- ��������� ����������� ���������� ���� ��� ����������� �������.
-- sp_query_store_force_plan query_id, plan_id;

-- ������� ���� ���� �� ��������� ��������.
-- sp_query_store_remove_plan plan_id;

-- ������� ������, � ����� ��� ��������� � ��� ����� � ���������� ������� ���������� �� ��������� ��������.
-- sp_query_store_remove_query query_id;

-- ������� ���������� ������� ���������� ��� ����������� ����� ������� �� ��������� ��������.
-- sp_query_store_reset_exec_stats plan_id;

-- ��������� ��������� ���������� ���� ��� ����������� �������.
-- sp_query_store_unforce_plan query_id, plan_id;

