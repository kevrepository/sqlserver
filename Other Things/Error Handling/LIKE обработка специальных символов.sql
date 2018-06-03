IF OBJECT_ID(N'dbo.SelectStringBeginning', N'U') IS NOT NULL
    DROP PROC dbo.SelectStringBeginning;

GO

CREATE PROC dbo.SelectStringBeginning
    @StringBeginning nvarchar(100)
AS
BEGIN
    DECLARE @ModifiedStringBeginning nvarchar(100);

    SET @ModifiedStringBeginning = 
        REPLACE(REPLACE(@StringBeginning, N'[', N'[[]'), N'%', N'[%]');

    -- WHERE column_name LIKE @ModifiedStringBeginning + N'%';
END;

GO