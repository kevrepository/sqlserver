USE Master;
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
) ;
GO

CREATE SERVER AUDIT SPECIFICATION audit_specification_name
    FOR SERVER AUDIT audit_name
    ADD (USER_DEFINED_AUDIT_GROUP);
GO

ALTER SERVER AUDIT audit_specification_name
    WITH (STATE = ON);
GO

/*
    Пользовательское событие может быть поднято с помощью хранимой процедуры sp_audit_write.
    
    https://technet.microsoft.com/en-us/library/gg471540%28v=sql.110%29.aspx?f=255&MSPPError=-2147217396\

    sp_audit_write [ @user_defined_event_id =  ] user_defined_event_id , 
            [ @succeeded =  succeeded 
        [ , [ @user_defined_information =  ] 'user_defined_information' ] 
        [ ; ]
        
    @user_defined_event_id
        Указывает идентификатор определяемого пользователем события.
    @succeeded
        Указывает, было ли событие успешным (0 - событие не выполнено, 1 - событие преуспело).
    @user_defined_information
        Задает описание события.

    
    EXEC sys.sp_audit_write 1, 1, 'defined_information';
*/