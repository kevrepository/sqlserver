create procedure [dbo].[sb_load_file_increment]
as
	declare @message_body varbinary(max);
	declare @conversation_handle uniqueidentifier;
	declare @message_type_name sysname;
	declare @exchange_id int

	begin try
		while 1 = 1
		begin
			begin transaction

				waitfor
				( 
					receive top(1)
							@conversation_handle = [conversation_handle],
							@message_body = message_body,
							@message_type_name = message_type_name
					from dbo.TargetQueueFile
				), TIMEOUT 20000;

				if @@rowcount = 0
				begin
					commit transaction
					break
				end

				if @message_type_name = N'SenderMessageTypeFile'
				begin 
					exec dbo.load_file_increment
						@message = @message_body,
						@exchange_id = @exchange_id output

					if exists(
						select	1	
						from	sys.conversation_endpoints 
						where	[conversation_handle] = @conversation_handle 
								and [state] = 'CO'
					)
					begin;
						send on conversation @conversation_handle
						message type ReceiverMessageTypeFile(cast(@exchange_id as binary(4)))
					end
					else
					begin
						end conversation @conversation_handle
					end					
				end
				else if @message_type_name = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog'
				begin 
					end conversation @conversation_handle
				end
				else if @message_type_name = N'http://schemas.microsoft.com/SQL/ServiceBroker/Error'
				begin 
					end conversation @conversation_handle
				end

			commit transaction
		end
	end try
	begin catch
		if @@trancount > 0 
			rollback transaction
		exec dbo.rethrow_error
	end catch;
go

