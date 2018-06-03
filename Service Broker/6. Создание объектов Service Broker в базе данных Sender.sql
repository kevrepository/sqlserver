USE DBSender

CREATE MESSAGE TYPE 
    [//Communication/Message]
    VALIDATION = NONE;

CREATE MESSAGE TYPE 
    [//Communication/EndOfDataTransfer]
    VALIDATION = NONE;

CREATE CONTRACT 
    [//Communication/ContractDataTransfer]
    (
        [//Communication/Message] SENT BY ANY
       ,[//Communication/EndOfDataTransfer] SENT BY ANY
    );

-- Маршрут, по которому сообщения будут отправляться получателю.
CREATE ROUTE RouteDataTransfer
    AUTHORIZATION dbo
WITH
     SERVICE_NAME = '//Communication/ServiceDataTransfer'
    ,BROKER_INSTANCE = 'F72AE9DB-ECDF-4DAA-9673-F886D4EF0276' 
    ,ADDRESS = 'TCP://192.168.0.61:4001';

CREATE QUEUE communication.QueueReceivedData;

CREATE SERVICE 
    [//Communication/ServiceDataTransfer]
     AUTHORIZATION dbo
     ON QUEUE communication.QueueReceivedData;

GRANT SEND ON SERVICE::[//Communication/ServiceDataTransfer] TO PUBLIC;

GO