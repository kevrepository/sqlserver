USE DBReceiver;

GO

ALTER DATABASE DBReceiver SET ENABLE_BROKER;

-- SELECT service_broker_guid FROM sys.databases WHERE name = 'DBReceiver';

GO

-- Cхема содержащая объекты поддержки Service Broker.
CREATE SCHEMA communication;

GO

-- Таблицу для хранения ошибок при обмене сообщениями.
CREATE TABLE communication.TransferDataError
(
     ID             BIGINT IDENTITY(1, 1) NOT NULL
    ,ErrorProcedure NVARCHAR(126)         NOT NULL
    ,ErrorLine      INT                   NOT NULL
    ,ErrorNumber    INT                   NOT NULL
    ,ErrorMessage   NVARCHAR(4000)        NOT NULL
    ,ErrorSeverity  INT                   NOT NULL
    ,ErrorState     INT                   NOT NULL
    ,ErrorDate      DATETIME2             NOT NULL
    ,CONSTRAINT PK_communication_TransferDataError PRIMARY KEY (ID)
);

ALTER TABLE communication.TransferDataError ADD 
    CONSTRAINT DF_communication_TransferDataError_ErrorDate DEFAULT (SYSDATETIME()) FOR ErrorDate;

-- Таблица для хранения полученных сообщений.
CREATE TABLE communication.ReceivedMessage
(
     ID                    INT IDENTITY(1, 1) NOT NULL
    ,DialogID              UNIQUEIDENTIFIER   NOT NULL
    ,MessageSequenceNumber BIGINT             NOT NULL
    ,MessageBody           NVARCHAR(4000)     NOT NULL
    ,MessageDate           DATETIME2          NOT NULL
    ,CONSTRAINT PK_communication_ReceivedMessage PRIMARY KEY (ID)
);

ALTER TABLE communication.ReceivedMessage ADD 
    CONSTRAINT DF_communication_ReceivedMessage_MessageDate DEFAULT (SYSDATETIME()) FOR MessageDate;

GO

-- Хранимая процедура, которая обрабатывает полученные сообщения.
CREATE PROCEDURE communication.ReceiveTransferredData
AS
BEGIN
     DECLARE @DialogID              UNIQUEIDENTIFIER
            ,@MessageBody           NVARCHAR(4000)
            ,@MessageSequenceNumber BIGINT
            ,@MessageTypeName       VARCHAR(256);

     WHILE (1 = 1)
     BEGIN
        BEGIN TRANSACTION
        
        BEGIN TRY
            RECEIVE TOP(1) @DialogID = conversation_handle
                          ,@MessageSequenceNumber = message_sequence_number
                          ,@MessageTypeName = message_type_name
                          ,@MessageBody = message_body
            FROM    communication.QueueReceivedData;
                    
            IF @@ROWCOUNT = 0
            BEGIN
               IF @@TRANCOUNT > 0
                    ROLLBACK;
               
               BREAK;
            END;
                    
            IF @MessageTypeName = N'//Communication/EndOfDataTransfer'
                END CONVERSATION @DialogID;
            ELSE
                INSERT INTO communication.ReceivedMessage(DialogID, MessageSequenceNumber, MessageBody)
                VALUES (@DialogID, @MessageSequenceNumber, @MessageBody);
            
            IF @@TRANCOUNT > 0
                COMMIT;
        END TRY
        BEGIN CATCH
            IF @@TRANCOUNT > 0
                ROLLBACK;
                
            INSERT INTO communication.TransferDataError(ErrorProcedure, ErrorLine, ErrorNumber, ErrorMessage, ErrorSeverity, ErrorState)
            VALUES (ERROR_PROCEDURE(), ERROR_LINE(), ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_STATE());
        END CATCH;
     END;
END;

GO