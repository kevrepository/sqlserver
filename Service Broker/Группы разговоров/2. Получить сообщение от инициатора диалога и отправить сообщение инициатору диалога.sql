DECLARE @DialogHandle UNIQUEIDENTIFIER;

-- Обработка первого сообщения.
RECEIVE @DialogHandle = conversation_handle
FROM [communication].[QueueReceivedData];
 
SEND ON CONVERSATION @DialogHandle
MESSAGE TYPE [//Communication/Message] (FORMAT(SYSDATETIME(), 'yyyyMMdd HH:mm:ss'));

-- Обработка второго сообщения.
RECEIVE @DialogHandle = conversation_handle
FROM [communication].[QueueReceivedData];
 
SEND ON CONVERSATION @DialogHandle
MESSAGE TYPE [//Communication/Message] (FORMAT(SYSDATETIME(), 'yyyyMMdd HH:mm:ss'));

GO