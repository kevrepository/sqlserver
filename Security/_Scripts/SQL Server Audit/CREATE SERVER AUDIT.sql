/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-server-audit-transact-sql

    CREATE SERVER AUDIT audit_name  
        {  
            TO { [ FILE (<file_options> [ , ...n ] ) ] | APPLICATION_LOG | SECURITY_LOG }  
            [ WITH ( <audit_options> [ , ...n ] ) ]   
            [ WHERE <predicate_expression> ]  
        }  
    [ ; ]  

    <file_options>::=  
    {  
            FILEPATH = 'os_file_path'  
        [ , MAXSIZE = { max_size { MB | GB | TB } | UNLIMITED } ]  
        [ , { MAX_ROLLOVER_FILES = { integer | UNLIMITED } } | { MAX_FILES = integer } ]  
        [ , RESERVE_DISK_SPACE = { ON | OFF } ]   
    }  
    
    MAX_ROLLOVER_FILES
        Когда файл аудита заполняется, вы можете либо выполнить цикл, либо создать новый файл. 
        Данный параметр определяет, сколько новых файлов может быть сгенерировано, 
        прежде чем они начнут цикл (0 - один файл, 5 - шесть файлов).        
    MAX_FILES
        Указывает ограничение на количество файлов аудита, которые могут быть сгенерированы, когда это число будет достигнуто, журналы не будут циклически выполняться. 
        Вместо этого аудит завершается с ошибкой, и события, которые вызывают действие аудита, обрабатываются на основе настройки для ON_FAILURE.
    RESERVE_DISK_SPACE
        Этот параметр заранее размещает на диске файл в соответствии со значением MAXSIZE.
        Предварительно выделите пространство на томе, равное значению, установленному в MAXSIZE.


    <audit_options>::=  
    {  
        [   QUEUE_DELAY = integer ]  
        [ , ON_FAILURE = { CONTINUE | SHUTDOWN | FAIL_OPERATION } ]  
        [ , AUDIT_GUID = uniqueidentifier ]  
    }  
    
    QUEUE_DELAY
        Указывает, записываются ли события аудита синхронно или асинхронно.
        Если установлено значение 0 , события записываются в журнал синхронно.
        В противном случае укажите продолжительность в миллисекундах, которая может пройти до того, как события будут вынуждены писать.
        Значение по умолчанию - 1000 (1 секунда), что также является минимальным значением.
    ON_FAILURE
        Указывает, будет ли экземпляр, выполняющий запись в целевой объект, вызывать ошибку, 
        продолжать работу или останавливать SQL Server, если целевой объект не может выполнить запись в журнал аудита. 
        
        CONTINUE
            SQL Server продолжает работу. Записи аудита не сохраняются.
            Аудит продолжает попытки регистрации событий и возобновляется после устранения причины сбоя.
            
        SHUTDOWN
            Приводит к принудительному завершению работы экземпляра SQL Server.

        FAIL_OPERATION
            Действия с базой данных завершаются ошибкой, если они вызывают события аудита. 
            Действия, которые не вызывают события аудита, можно продолжить, но события аудита возникать не будут. 
            Аудит продолжает попытки регистрации событий и возобновляется после устранения причины сбоя.
    AUDIT_GUID
        Чтобы поддерживать такие сценарии, как зеркальное отображение базы данных, аудиту необходим конкретный идентификатор GUID, 
        который совпадает с идентификатором GUID, найденным в зеркальной базе данных. 
        Этот идентификатор GUID не может быть изменен после создания аудита.

    <predicate_expression>::=  
    {  
        [NOT ] <predicate_factor>   
        [ { AND | OR } [NOT ] { <predicate_factor> } ]   
        [,...n ]  
    }  
    
    <predicate_factor>::=   
        event_field_name { = | < > | ! = | > | > = | < | < = } { number | ' string ' }  

    
    ALTER SERVER AUDIT
        https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-server-audit-transact-sql

    DROP SERVER AUDIT
        https://docs.microsoft.com/en-us/sql/t-sql/statements/drop-server-audit-transact-sql
*/

USE Master
GO

CREATE SERVER AUDIT audit_name
TO FILE
(
    FILEPATH = 'os_file_path'
   ,MAXSIZE = 256 MB
   ,MAX_ROLLOVER_FILES = UNLIMITED
   ,RESERVE_DISK_SPACE = OFF
)
WITH
(
    QUEUE_DELAY = 1000
   ,ON_FAILURE = CONTINUE
)
WHERE object_name = 'sysadmin';
GO

/*
ALTER SERVER AUDIT audit_name
    WITH (STATE = ON);

DROP SERVER AUDIT audit_name;
*/