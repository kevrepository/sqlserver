/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

----------------------------------------------------------------------------
-- Part 2, Demo 4: Plan Forcing
----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- NO_INDEX
----------------------------------------------------------------------------
use opt;
go
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = all,
	max_storage_size_mb = 100,
	size_based_cleanup_mode = off,
	data_flush_interval_seconds = 900
);
go
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go
-- Exec query - Grab the plan
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look what is stored and look at the Plan
exec dbo.query_store_cache_store_info 1;
go
-- Force plan that uses index ix_b
exec sp_query_store_force_plan 1, 1;
go
-- drop the index ix_b
drop index ix_b on t1big;
go
-- Exec query - with forced plan
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look at forcing_failed_reason_desc
exec dbo.query_store_cache_store_info 1;
go
-- return the index back
create index ix_b on t1big(b);
go

----------------------------------------------------------------------------
-- NO_PLAN (more interesting scenario)
----------------------------------------------------------------------------
use opt;
go
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = all,
	max_storage_size_mb = 100,
	size_based_cleanup_mode = off,
	data_flush_interval_seconds = 900
);
go
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go

-- a.
-- Exec query - Grab the plan
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look what is stored and look at the Plan
exec dbo.query_store_cache_store_info 1;
go
-- Force plan that uses index ix_b
exec sp_query_store_force_plan 1, 1;
go

-- b.
-- re-creating index with different specification
create index ix_b on t1big(b) include(c) with (drop_existing = on);
go

-- c.
-- Exec query - Grab the plan, look at use plan = true, forced plan successfuly used
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look what is stored and look at the Plan
exec dbo.query_store_cache_store_info 1;
go

-- d.
-- Make index covering
create index ix_b on t1big(b) include(c, d) with (drop_existing = on);
go

--e.
-- Covering index leads to another optimization path and rules, as a result NO_PLAN
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look what is stored and look at the Plan and failed reason = NO_PLAN
exec dbo.query_store_cache_store_info 1;
go

-- Return index back
create index ix_b on t1big(b) with (drop_existing = on);
go

----------------------------------------------------------------------------
-- NO_DB
----------------------------------------------------------------------------
use opt;
go
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = all,
	max_storage_size_mb = 100,
	size_based_cleanup_mode = off,
	data_flush_interval_seconds = 900
);
go
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go
-- a.
-- Exec query - Grab the plan
go
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look what is stored and look at the Plan
exec dbo.query_store_cache_store_info 1;
go
-- Force plan that uses index ix_b
exec sp_query_store_force_plan 1, 1;
go

-- b. 
-- rename data base
use master;
go
alter database opt set single_user with rollback immediate;
go
alter database opt modify name = opt_renamed;
go
use opt_renamed;
go
alter database opt_renamed set multi_user with rollback immediate;
go

-- c. 
-- re-run the query
go
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look what is stored and look at the Plan
exec dbo.query_store_cache_store_info 1;
go

-- d. 
-- rename back
use master;
go
alter database opt_renamed set single_user with rollback immediate;
go
alter database opt_renamed modify name = opt;
go
use opt;
go
alter database opt set multi_user with rollback immediate;
go

-- e. 
-- re-run the query (Still NO_DB)
go
select * from t1big t1 join t2 on t1.a = t2.b where t1.b <= 1;
go
-- Look what is stored and look at the Plan
exec dbo.query_store_cache_store_info 1;
go