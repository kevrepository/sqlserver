USE master

-- Логин, будет использоваться для отправки данных через конечную точку.
CREATE LOGIN LoginDataTransferSender
    WITH PASSWORD = 'Pa$$w0rd';

GO

CREATE USER UserDataTransferSender 
    FOR LOGIN LoginDataTransferSender;

GO

/*
    SELECT is_master_key_encrypted_by_server
    FROM   sys.databases
    WHERE  name = 'master';
*/

CREATE MASTER KEY ENCRYPTION
    BY PASSWORD = 'Pa$$w0rd';

GO

-- Сертификат для безопасной связь между серверами.
CREATE CERTIFICATE CertificateDataTransferSender
WITH
     SUBJECT = 'Сertificate for the Service Broker TCP Endpoint'
    ,EXPIRY_DATE = '22220101';

GO

-- Сертификат, созданный на сервере получателя, 
-- для авторизации пользователя UserDataTransferSender.
CREATE CERTIFICATE CertificateDataTransferReceiver
     AUTHORIZATION UserDataTransferSender
     FROM FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL13.INSTANCE02\MSSQL\Backup\CertificateDataTransferReceiver.cer';

GO

-- Конечная точка для обмена сообщениями сервисом Service Broker.
CREATE ENDPOINT EndpointDataTransfer
    STATE = STARTED
    AS TCP ( LISTENER_PORT = 4002 )
    FOR SERVICE_BROKER 
    (
        AUTHENTICATION = CERTIFICATE CertificateDataTransferSender
       ,ENCRYPTION = SUPPORTED
    );

GO

-- В реальных приложениях вы должны настроить это на основе ваших требований безопасности.
GRANT CONNECT ON ENDPOINT::EndpointDataTransfer TO LoginDataTransferSender;

GO