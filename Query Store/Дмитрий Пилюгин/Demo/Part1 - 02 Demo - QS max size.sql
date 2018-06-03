/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

----------------------------------------------------------------------------
-- Demo 2: QS ad-hoc plans pollution
----------------------------------------------------------------------------

-- Use OPT
use opt;
go

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
exec dbo.query_store_cache_store_info;
go

-- Force Parametrization
alter database opt set parameterization forced;
go

-- Run many Ad-hoc queries
declare @i int = 1;
while @i < 10000 begin

	declare @sql nvarchar(max) = N'declare @c int; select @c = t1.c from t1 where t1.b = ' + convert(nvarchar(10), @i);
	exec sp_executesql @sql;

	set @i += 1;

end;
go
exec sp_query_store_flush_db;
go

-- Back to Simple Parametrization
alter database opt set parameterization simple;
go

-- Current QS information
exec dbo.query_store_cache_store_info;
go