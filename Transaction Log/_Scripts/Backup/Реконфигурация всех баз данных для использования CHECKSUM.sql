DECLARE @Statement nvarchar (MAX);

SELECT @Statement = (SELECT 'ALTER DATABASE ' + QUOTENAME(name) + ' SET PAGE_VERIFY CHECKSUM WITH NO_WAIT;' AS [data()] 
                     FROM   sys.databases 
                     WHERE  page_verify_option_desc <> 'CHECKSUM'
                     FOR    XML PATH ('')); 

SELECT @Statement;

BEGIN TRY 
    EXEC sp_executesql @Statement;
END TRY
BEGIN CATCH
    SELECT 'Ошибка выполнения следующего оператора SQL:' + CHAR (13) + CHAR (10) + @Statement;
END CATCH;