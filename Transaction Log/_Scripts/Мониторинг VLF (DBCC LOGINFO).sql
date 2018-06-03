/*
    FileId
        »дентификатор файла.
    Status
        —татус VLF. «начени€ 0 и 2 указывают на неактивные и активные VLF, соответственно.
    FileSize
        –азмер VLF в байтах.
    StartOffset
        Ќачальное смещение VLF в файле.
    CreateLSN 
        LSN в момент создани€ VLF. 0 означает, что VLF был создан во врем€ создани€ базы данных.
    FSeqNo
        ѕор€док использовани€ VLF. VLF с самым высоким FSeqNo €вл€етс€ файлом, в котором записаны текущие записи журнала.
    Parity 
        ћожет быть одним из двух возможных значений: 64 и 128. SQL Server переключает значение четности каждый раз, когда используетс€ VLF. 
        SQL Server использует значение четности, чтобы определить, где остановить обработку записей журнала во врем€ восстановлени€ после сбо€.
*/

/*
    USE master;
    GO
    
    IF OBJECT_ID('dbo.LogInfo', 'U') IS NOT NULL
        DROP TABLE dbo.LogInfo;
    GO
    
    CREATE TABLE dbo.LogInfo
    (
        RecoveryUnitID int           NULL
       ,FileID         tinyint       NULL
       ,FileSize       bigint        NULL
       ,StartOffset    bigint        NULL
       ,FSeqNo         int           NULL
       ,Status         tinyint       NULL
       ,Parity         tinyint       NULL
       ,CreateLSN      numeric(25,0) NULL 
    );
    GO

    TRUNCATE TABLE dbo.LogInfo;

    INSERT INTO dbo.LogInfo EXEC ('DBCC LOGINFO');
GO

    SELECT FileID
          ,StartOffset
          ,FSeqNo
          ,Status
          ,CreateLSN
    FROM   dbo.LogInfo
    ORDER  BY CASE
              WHEN FSeqNo = 0 THEN 9999999
              ELSE FSeqNo 
              END;
GO
*/

DBCC LOGINFO;