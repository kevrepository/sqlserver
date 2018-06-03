/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

----------------------------------------------------------------------------
-- Part 2 - Demo 1: Recompilation
----------------------------------------------------------------------------
use opt;
go
-- Enable QS
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = all,
	max_storage_size_mb = 100, 
	size_based_cleanup_mode = off, 
	data_flush_interval_seconds = 900
);
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go

-- one plan captured and cached
exec dbo.query_store_cache_store_info 1, 1, 50;
go
exec p1 1;
go
exec dbo.query_store_cache_store_info 1, 1, 50;
go

-- clearing cahe the plan is removed from cache but still in QS
dbcc freeproccache with no_infomsgs;
go
exec dbo.query_store_cache_store_info 1, 1, 50;
go

-- exec one more time for the value 10, the second plan is captured
exec p1 10;
go
exec dbo.query_store_cache_store_info 1, 1, 50;
go

-- enable qs_recompilation session 

-- force/unforce plan observing recompilations
exec sp_query_store_force_plan ?, ?;
go
set statistics xml on;
exec p1 10;
set statistics xml off;
go
exec sp_query_store_unforce_plan ?, ?;
go
set statistics xml on;
exec p1 10;
set statistics xml off;
go

-- stop session

-- option recompile
dbcc freeproccache with no_infomsgs;
go
declare @b int = 1; --10 (still 1 in predicate)
select * from t1 where b = @b option(recompile);
go
exec dbo.query_store_cache_store_info 1, 1, 50;
go
