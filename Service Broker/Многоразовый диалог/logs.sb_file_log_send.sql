create procedure [logs].[sb_file_log_send]
as
	set nocount on

	declare @qty int = 0,
			@batch_size int = 1000,
			@conversation_handle uniqueidentifier,
			@exchange_id int = null,
			@time_out_retry varchar(100) = '00:01:00',
			@wait_batch_delay_ss int,
			@wait_batch_ss int = 1,
			@dt_response_wait datetime,
			@wait_response_ms int = 30000,
			@conversation_state char(2),
			@is_receive bit = 0;

	begin try
		while 1 = 1
		begin
			set @conversation_state = null
			set @exchange_id = null

			select	@conversation_handle = isnull(s.[conversation_handle], @conversation_handle),	
					@batch_size = isnull(s.batch_size, @batch_size),			
					@time_out_retry = isnull(s.time_out_retry, @time_out_retry),		
					@wait_batch_ss = isnull(s.wait_batch_ss, @wait_batch_ss),			
					@wait_response_ms = isnull(s.wait_response_ms, @wait_response_ms),
					@conversation_state = ce.[state]		
			from	logs.sb_settings s
					left join sys.conversation_endpoints ce
						on ce.[conversation_handle] = s.[conversation_handle]
			where	sb_name = 'sb_file_log_send'

			

			if isnull(@conversation_state, '') != 'CO'
			begin
				if @conversation_state is not null
					end conversation @conversation_handle 

				begin transaction 
					begin dialog @conversation_handle
						from service SenderServiceFile
						to service 'ReceiverServiceFile'
						on contract SampleContractFile
						with encryption=on;

					update	logs.sb_settings
					set		[conversation_handle] = @conversation_handle
					where	sb_name = 'sb_file_log_send'
				commit transaction
			end

			exec logs.file_log_send
					@batch_size = @batch_size,
					@conversation_handle = @conversation_handle,
					@qty = @qty output,
					@exchange_id = @exchange_id output 

			set @dt_response_wait = getutcdate() 

			if @exchange_id is not null
			begin
				exec logs.file_log_receive
					@exchange_id = @exchange_id,
					@wait_response_ms = @wait_response_ms,
					@is_receive = @is_receive output
			end

			set @wait_batch_delay_ss = @wait_batch_ss - datediff(ss, @dt_response_wait, getutcdate()) 

			if @qty < @batch_size and @wait_batch_delay_ss > 0 
				waitfor delay @wait_batch_delay_ss

		end
	end try
	begin catch
		if @@trancount > 0 
			rollback
		exec dbo.rethrow_error
	end catch;
GO