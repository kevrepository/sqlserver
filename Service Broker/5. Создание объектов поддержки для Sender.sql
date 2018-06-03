USE DBSender;

GO

ALTER DATABASE DBSender SET ENABLE_BROKER;

-- SELECT service_broker_guid FROM sys.databases WHERE name = 'DBSender';

GO

-- Cхема содержащая объекты поддержки Service Broker.
CREATE SCHEMA communication;

GO

-- Таблицу для хранения ошибок при обмене сообщениями.
CREATE TABLE communication.TransferDataError
(
     ID             BIGINT IDENTITY(1, 1) NOT NULL
    ,ErrorProcedure NVARCHAR(128)         NOT NULL
    ,ErrorLine      INT                   NOT NULL
    ,ErrorNumber    INT                   NOT NULL
    ,ErrorMessage   NVARCHAR(4000)        NOT NULL
    ,ErrorSeverity  INT                   NOT NULL
    ,ErrorState     INT                   NOT NULL
    ,ErrorDate      DATETIME2             NOT NULL
    ,CONSTRAINT PK_transfer_Error PRIMARY KEY (ID)
);

ALTER TABLE communication.TransferDataError ADD 
    CONSTRAINT DF_communication_TransferDataError_ErrorDate DEFAULT SYSDATETIME() FOR ErrorDate;

GO

-- Хранимая процедура, которая отправляет данные.
CREATE PROCEDURE communication.SendData
     @MessageBody NVARCHAR(4000)
    ,@DialogID    UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN DIALOG CONVERSATION @DialogID
            FROM SERVICE [//Communication/ServiceDataTransfer]
            TO SERVICE '//Communication/ServiceDataTransfer'
            ON CONTRACT [//Communication/ContractDataTransfer]
            WITH ENCRYPTION = OFF;

        SEND ON CONVERSATION @DialogID
            MESSAGE TYPE [//Communication/Message] (@MessageBody)
    END TRY
    BEGIN CATCH
        INSERT INTO communication.TransferDataError (ErrorProcedure, ErrorLine, ErrorNumber, ErrorMessage, ErrorSeverity, ErrorState)
        VALUES (ERROR_PROCEDURE(), ERROR_LINE(), ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_STATE());
    END CATCH;
END

GO

-- Точка входа.
CREATE PROCEDURE communication.DoWork
AS
BEGIN
    DECLARE @DialogID    UNIQUEIDENTIFIER
           ,@MessageBody NVARCHAR(4000) = FORMAT(SYSDATETIME(), 'yyyyMMdd HH:mm:ss');
     
    EXEC communication.SendData @MessageBody, @DialogID OUTPUT;

    SEND ON CONVERSATION @DialogID MESSAGE TYPE [//Communication/EndOfDataTransfer];
END;