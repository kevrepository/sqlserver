/*
    http://www.sommarskog.se/error_handling/Part3.html#idealtranshandling
*/

IF OBJECT_ID('dbo.ProcedureName', 'P') IS NOT NULL 
    DROP PROC dbo.ProcedureName;

GO

CREATE PROCEDURE dbo.ProcedureName
AS
BEGIN
    DECLARE @TranName  varchar(32) = REPLACE(CONVERT(char(36), NEWID()), '-', '')
           ,@TranCount int         = @@TRANCOUNT;
    
    IF @TranCount > 0
    BEGIN
        SAVE TRAN @TranName;
    END
    ELSE
    BEGIN
      BEGIN TRAN
    END;

    BEGIN TRY
        -- Modify data.
      
        IF @TranCount = 0
            COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @TranCount = 0
        BEGIN
            IF XACT_STATE() <> 0
            BEGIN
                ROLLBACK TRAN;
            END;
        END
        ELSE
        BEGIN
            IF XACT_STATE() = 1
            BEGIN
                ROLLBACK TRAN @TranName;
            END;

            --ELSE IF XACT_STATE() = -1
            --BEGIN
            --END;
        END;

        DECLARE @ErrorMessage  NVARCHAR(400)
               ,@ErrorNumber   INT
               ,@ErrorSeverity INT
               ,@ErrorState    INT;

        SELECT @ErrorMessage  = ERROR_MESSAGE()
              ,@ErrorNumber   = ERROR_NUMBER()
              ,@ErrorSeverity = ERROR_SEVERITY()
              ,@ErrorState    = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO