/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

----------------------------------------------------------------------------
-- Part 2, Demo 3: Stages and USE PLAN
----------------------------------------------------------------------------
use opt;
go
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = auto,
	max_storage_size_mb = 100,
	size_based_cleanup_mode = off,
	data_flush_interval_seconds = 900
);
go
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go
dbcc traceon(3604, 8675) with no_infomsgs;
go
print ('---------------------------------------------------------');
print ('Regular Optimization Process:');
print ('');
go
set statistics xml on;
exec p1 1;
set statistics xml off;
go
exec sp_query_store_force_plan 1, 1;
go
print ('---------------------------------------------------------');
print ('Forced Optimization Process:');
print ('');
go
set statistics xml on;
exec p1 1;
set statistics xml off;
go
exec sp_query_store_unforce_plan 1, 1;
go
dbcc traceoff(3604, 8675) with no_infomsgs;
go
-- Oserve Xml Plans properties next