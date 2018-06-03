/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

----------------------------------------------------------------------------
-- Demo 1: QS in action
----------------------------------------------------------------------------

-- Use OPT
use opt;
go

-- Proc P1
alter proc p1 
	@b int
as
	set nocount on;
	
	declare @c int, @start datetime, @ms int;
	set @start = getdate();

	select @c = c from t1big where b <= @b;

	set @ms = datediff(ms, @start, getdate());
	raiserror('P1 execution time: %d ms', 10, 1, @ms) with nowait;
go

-- Enable QS
alter database opt set query_store = on (query_capture_mode = all, operation_mode = read_write);
alter database opt set query_store clear;
dbcc freeproccache with no_infomsgs;
go

-- Show Actual Plan (do not turn on "Actual Plan" in SSMS)
set statistics xml on;
go
exec p1 @b = 1;
go
dbcc freeproccache with no_infomsgs;
go
exec p1 @b = 100;
go
dbcc freeproccache with no_infomsgs;
go
set statistics xml off
go

-- Run Proc In Cycle, Go to Regressed Queries, Detailed Grid
dbcc freeproccache with no_infomsgs;

declare @i int = 1;
while @i < 100000000 begin

	exec p1 @b = @i;
	
	waitfor delay '00:00:01';

	set @i += 1;

end;