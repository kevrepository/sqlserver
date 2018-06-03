CREATE TABLE communication.Dialog
(
    ServiceSourceName      NVARCHAR(128)    NOT NULL
   ,ServiceDestinationName NVARCHAR(128)    NOT NULL
   ,ContractName           NVARCHAR(128)    NOT NULL
   ,DialogHandle           UNIQUEIDENTIFIER NOT NULL
   ,CONSTRAINT PK_communication_Dialog PRIMARY KEY (ServiceSourceName, ServiceDestinationName, ContractName)
);

CREATE PROCEDURE dbo.CreateConversation
    @ServiceSourceName      NVARCHAR(128)
   ,@ServiceDestinationName NVARCHAR(128)
   ,@ContractName           NVARCHAR(128)
   ,@MessageTypeName        NVARCHAR(128)
   ,@MessageBody            NVARCHAR(4000)
   ,@DialogHandle           UNIQUEIDENTIFIER
AS
BEGIN
    SELECT @DialogHandle = DialogHandle
    FROM   communication.Dialog
    WHERE  ServiceSourceName = @ServiceSourceName
           AND ServiceDestinationName = @ServiceDestinationName
           AND ContractName = @ContractName;

    IF @DialogHandle IS NULL
    BEGIN
        BEGIN DIALOG CONVERSATION @DialogHandle
            FROM SERVICE @ServiceSourceName
            TO SERVICE @ServiceDestinationName
            ON CONTRACT @ContractName;

        UPDATE communication.Dialog
        SET DialogHandle = @DialogHandle
        WHERE ServiceSourceName = @ServiceSourceName
             AND ServiceDestinationName = @ServiceDestinationName
             AND ContractName = @ContractName;
        
        IF @@ROWCOUNT = 0
             INSERT INTO communication.Dialog (ServiceSourceName, ServiceDestinationName, ContractName, DialogHandle)
             VALUES (@ServiceSourceName, @ServiceDestinationName, @ContractName, @DialogHandle);
    END;

    SEND ON CONVERSATION @DialogHandle
        MESSAGE TYPE @MessageType (@MessageBody);

    IF NOT EXISTS(SELECT *
                  FROM   communication.Dialog
                  WHERE  ServiceSourceName = @ServiceSourceName
                         AND ServiceDestinationName = @ServiceDestinationName
                         AND ContractName = @ContractName
                         AND DialogHandle = @DialogHandle)
        SEND ON CONVERSATION @DialogHandle
            MESSAGE TYPE [//Communication/EndOfDataTransfer];
END;




GO