/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

----------------------------------------------------------------------------
-- Demo 3: QS ad-hoc plans pollution
----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- 3.0 Queries to Identify good candidate for parametrization
----------------------------------------------------------------------------

select TotalQueries = count(*), DifferentQueries = count(distinct q.query_hash) from sys.query_store_query q;
select TotalPlans = count(*), DifferentPlans = count(distinct p.query_plan_hash) from sys.query_store_plan p;

----------------------------------------------------------------------------
-- 3.1 Optimize for Adhoc Workloads
----------------------------------------------------------------------------

-- Enable QS
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = all, -- Default
	max_storage_size_mb = 100, -- Default
	size_based_cleanup_mode = off -- Default
);
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go

-- Current QS information
exec dbo.query_store_cache_store_info 1, 1, 50;
go

-- Optimize for ad hoc workloads
sp_configure 'optimize for ad hoc workloads', 1;
reconfigure;
go

-- Run some Ad-hoc queries
go
declare @c int; select @c = t1.c from t1 where t1.b = 1;
go
declare @c int; select @c = t1.c from t1 where t1.b = 2;
go
declare @c int; select @c = t1.c from t1 where t1.b = 3;
go

-- Turn off Optimize for ad hoc workloads
sp_configure 'optimize for ad hoc workloads', 0;
reconfigure;
go

-- Current QS information
exec dbo.query_store_cache_store_info 1, 1, 50;
go

----------------------------------------------------------------------------
-- 3.2 Using query_capture_mode = Auto Mode
----------------------------------------------------------------------------

-- Use OPT
use opt;
go

-- Enable QS
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = auto, -- <-- Set AUTO mode (!)
	max_storage_size_mb = 100, -- Default
	size_based_cleanup_mode = off -- Default
);
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go

-- Current QS information
exec dbo.query_store_cache_store_info;
go

-- Run many Ad-hoc queries
declare @i int = 1;
while @i < 40000 begin

	declare @sql nvarchar(max) = N'declare @c int; select @c = t1.c from t1 where t1.b = ' + convert(nvarchar(10), @i);
	exec sp_executesql @sql;

	set @i += 1;

end;
go
exec sp_query_store_flush_db;
go

-- Current QS information
exec dbo.query_store_cache_store_info;
go

----------------------------------------------------------------------------
-- 3.3 Fixing by Forced Parametrization
----------------------------------------------------------------------------

-- Enable QS
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = all, -- Default
	max_storage_size_mb = 100, -- Default
	size_based_cleanup_mode = off -- Default
);
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go

-- Current QS information
exec dbo.query_store_cache_store_info 1, 0, 50;
go

-- Force Parametrization
alter database opt set parameterization forced;
go

-- !!! Turn On Discard Result in Query Options - Grid - Results

-- Run many Ad-hoc queries
declare @i int = 1;
while @i < 40000 begin

	declare @sql nvarchar(max) = N'select t1.c from t1 where t1.b = ' + convert(nvarchar(10), @i);
	exec sp_executesql @sql;

	set @i += 1;

end;
go
exec sp_query_store_flush_db;
go

-- !!! Turn Off Discard Result in Query Options - Grid - Results

-- Back to Simple Parametrization
alter database opt set parameterization simple;
go

-- Current QS information
exec dbo.query_store_cache_store_info 1, 0, 50;
go


----------------------------------------------------------------------------
-- 3.4 Fixing by User Parametrization
----------------------------------------------------------------------------

-- Enable QS
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = all, -- Default
	max_storage_size_mb = 100, -- Default
	size_based_cleanup_mode = off -- Default
);
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go

-- Current QS information
exec dbo.query_store_cache_store_info 1, 1, 50;
go

-- Run many Ad-hoc queries
declare @i int = 1;
while @i < 40000 begin

	declare @sql nvarchar(max) = N'declare @c int; select @c = t1.c from t1 where t1.b = @i';
	exec sp_executesql @sql, N'@i int', @i;

	set @i += 1;

end;
go
exec sp_query_store_flush_db;
go

-- Current QS information
exec dbo.query_store_cache_store_info 1, 1, 50;
go