EXECUTE sp_create_plan_guide 
    @name = N'name_plan_guide'
   ,@stmt = N'SELECT *
FROM   table_name
WHERE  column_name = @VariableName;'
   ,@type = N'OBJECT'
   ,@module_or_batch = N'module_name '
   ,@params = NULL
   ,@hints = N'OPTION (OPTIMIZE FOR (@VariableName = 1))';
GO

DECLARE @PlanHandle  varbinary(64)
       ,@StartOffset int;

SELECT @PlanHandle  = deqs.plan_handle
      ,@StartOffset = deqs.statement_start_offset
FROM   sys.dm_exec_query_stats AS deqs
       CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS dest
       CROSS APPLY sys.dm_exec_text_query_plan(deqs.plan_handle, deqs.statement_start_offset, deqs.statement_end_offset) AS detqp
WHERE  dest.text LIKE N'%'

EXECUTE sp_create_plan_guide_from_handle 
    @name = N'name_plan_guide'
   ,@plan_handle = @PlanHandle
   ,@statement_start_offset = @StartOffset;
GO



/*
    EXECUTE sp_control_plan_guide
        @operation = 'Drop'
       ,@name = N'name_plan_guide';
*/