CREATE OR ALTER PROC dbo.AppLock
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Result INT;

    BEGIN TRAN
        EXEC @Result = sp_getapplock @Resource = 'AppLock'
                                    ,@LockMode = 'Exclusive'
                                    ,@LockOwner = 'Transaction'
                                    ,@LockTimeout = 15000;
        
        SELECT @Result;

        IF @Result >= 0
        BEGIN
            SELECT Name
            FROM   Production.Product
            WHERE  ProductID = @ProductID;

            WAITFOR DELAY '00:00:20';

            EXEC sp_releaseapplock @Resource = 'AppLock';
        END;
        
    COMMIT TRAN;
END;