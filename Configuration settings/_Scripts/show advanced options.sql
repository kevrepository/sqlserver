EXEC sp_configure 'show advanced options', 1; 
GO

RECONFIGURE;
GO

/*
    config_value
        Значение, в которое был установлен параметр конфигурации.
    run_value
        Текущее активное значение параметра конфигурации.
*/

EXEC sp_configure;
GO