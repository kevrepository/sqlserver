/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

----------------------------------------------------------------------------
-- Part 2, Demo 2: Query Capture Mode
----------------------------------------------------------------------------

-- Enable qs_capture_mode session

-- Enable QS
use opt
go
alter database opt set query_store = off;
alter database opt set query_store clear;
go
alter database opt set query_store = on (
	operation_mode = read_write,
	query_capture_mode = auto,
	max_storage_size_mb = 100,
	size_based_cleanup_mode = off,
	data_flush_interval_seconds = 5
);
go
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
set nocount on;
go
declare @c int;
select @c = c from t1big where b <= 1;
go
declare @c int;
select @c = c from t1big where b <= 1;
go
select * from sys.query_store_query_text;
go
declare @c int;
select @c = c from t1big where b <= 3;
go 3
select * from sys.query_store_query_text;
go