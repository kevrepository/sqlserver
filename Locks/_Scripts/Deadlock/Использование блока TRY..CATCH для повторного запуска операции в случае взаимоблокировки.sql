DECLARE @retry int = 5;

WHILE (@retry > 0)
BEGIN
    BEGIN TRY
        BEGIN TRAN
        ...
        COMMIT
    END TRY
    BEGIN CATCH
        IF (ERROR_NUMBER() = 1205)
            SET @retry = @retry - 1;
        ELSE
            SET @retry = 0;

        IF XACT_STATE() <> 0
            ROLLBACK;
    END CATCH
END;