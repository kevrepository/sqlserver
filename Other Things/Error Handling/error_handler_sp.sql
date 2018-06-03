/*
    Сообщение об ошибке начинается с трех звездочек, это позволяет:
        - Видеть, что это сообщение, от обработчика CATCH;
        - NOT LIKE '***%' позволяет избежать повторного изменения сообщений об ошибках.

    CATCH при использовании error_handler_sp:

        BEGIN CATCH
           ...
           
           EXEC error_handler_sp;
           
           RETURN ...;
        END CATCH
*/

CREATE PROCEDURE dbo.error_handler_sp 
AS 
BEGIN
   DECLARE @Message   NVARCHAR(4000)
          ,@Severity  TINYINT
          ,@State     TINYINT
          ,@Number    INT
          ,@Procedure NVARCHAR(128)
          ,@Line      INT;
           
   SELECT @Message   = ERROR_MESSAGE()
         ,@Severity  = ERROR_SEVERITY()
         ,@State     = ERROR_STATE()
         ,@Number    = ERROR_NUMBER()
         ,@Procedure = ERROR_PROCEDURE()
         ,@Line      = ERROR_LINE();
       
   IF @Message NOT LIKE '***%' 
   BEGIN 
      SELECT @Message = 
        '***' + COALESCE(QUOTENAME(@Procedure), '<dynamic SQL>') + 
        ', Line' + CONVERT(NVARCHAR(10), @Line) + 
        '. Number ' + CONVERT(NVARCHAR(10), @Number) + ': ' + @Message;
   END;

   RAISERROR ('% s', @Severity, @State, @Message);
END;

GO