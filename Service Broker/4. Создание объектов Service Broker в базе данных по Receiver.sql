USE DBReceiver;

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

-- Маршрут, по которому получатель будут отправлять ответные сообщения.
CREATE ROUTE RouteDataTransfer
    AUTHORIZATION dbo
WITH 
     SERVICE_NAME = '//Communication/ServiceDataTransfer'
    ,BROKER_INSTANCE = 'F62F7D63-94A1-4D82-9ED8-7552C41E098E'
    ,ADDRESS = 'TCP://192.168.0.61:4002';

CREATE QUEUE communication.QueueReceivedData
WITH
     STATUS = ON
    ,ACTIVATION
     (
         PROCEDURE_NAME = communication.ReceiveTransferredData
        ,MAX_QUEUE_READERS = 1
        ,EXECUTE AS 'dbo'
     );

CREATE SERVICE 
    [//Communication/ServiceDataTransfer]
    AUTHORIZATION dbo
    ON QUEUE communication.QueueReceivedData 
    (
        [//Communication/ContractDataTransfer]
    );

GRANT SEND ON SERVICE::[//Communication/ServiceDataTransfer] TO PUBLIC;

GO