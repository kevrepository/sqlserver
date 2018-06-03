/***************************************************************************
						24 HOP 2016
					Query Optimizer - Query Store

						(c) Dmitry Pilugin, 2016
						b: http://www.queryprocessor.ru
						t: @SomewereSomehow

****************************************************************************/

use master;
go
if db_id('opt') is not null drop database opt;
go
create database opt;
go
use opt;
go
create table t1(a int not null, b int not null, c int check (c between 1 and 50), constraint pk_a primary key(a));
create table t2(b int not null, c int, d char(10), constraint pk_b primary key(b));
create table t3(c int not null, constraint pk_c primary key(c));
go
insert into t1(a,b,c) select number, number%100+1, number%50+1 from master..spt_values where type = 'p' and number between 1 and 1000;
insert into t2(b,c) select number, number%100+1 from master..spt_values where type = 'p' and number between 1 and 1000;
insert into t3(c) select number from master..spt_values where type = 'p' and number between 1 and 1000;
go
alter table t1 add constraint fk_t2_b foreign key (b) references t2(b);
go
create statistics s_b on t1(b);
create statistics s_c on t1(c);
create statistics s_c on t2(c);
create statistics s_d on t2(c);
go
delete top(9) from t1 where b = 1
go
create index ix_b on t1(b);
update statistics t1 with fullscan;

go
select t1.*, d = convert(char(500),'') into t1big from t1 cross apply (select * from t1) x;
go
create clustered index cix on t1big(a);
create nonclustered index ix_b on t1big(b);
go
update statistics t1big with fullscan;
go
create proc p1 
	@b int
as
	set nocount on;
	
	declare @c int, @start datetime, @ms int;
	set @start = getdate();

	select @c = c from t1big where b <= @b;

	set @ms = datediff(ms, @start, getdate());
	raiserror('execution time: %d ms', 10, 1, @ms) with nowait;
go

create proc [dbo].[query_store_cache_store_info]
	@qs_info bit = null,
	@cs_info bit = null,
	@top int = 50
as
select actual_state_desc, current_storage_size_mb, max_storage_size_mb, query_store_plan_count = (select count(*) from sys.query_store_plan) from sys.database_query_store_options;

if @qs_info = 1 begin

	select top(@top)
		[QS: Query Text] = t.query_sql_text,
		[QS: Query Plan] = convert(xml,p.query_plan),
		p.query_id,
		p.plan_id,
		p.is_forced_plan,
		p.last_force_failure_reason_desc	
	from 
		sys.query_store_plan p 
		join sys.query_store_query q on p.query_id = q.query_id 
		join sys.query_store_query_text t on q.query_text_id = t.query_text_id;

end
if @cs_info = 1 begin

	select top(@top)
		[CS: Query Text] = st.text,
		[CS: Query Plan] = qp.query_plan,
		[CS: Plan Type] = cp.cacheobjtype
	from 
		sys.dm_exec_cached_plans cp 
		cross apply sys.dm_exec_query_plan(cp.plan_handle) qp 
		cross apply sys.dm_exec_sql_text (cp.plan_handle) st;

end
