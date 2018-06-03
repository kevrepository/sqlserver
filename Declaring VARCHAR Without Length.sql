DECLARE @Char CHAR = 'Char';

SELECT @Char                 -- CHAR(1)
      ,CONVERT(CHAR, 'Char') -- CHAR(30)
      ,CAST('Char' AS CHAR)  -- CHAR(30);

GO

CREATE TABLE dbo.TableName
(
    ColumnName CHAR NOT NULL -- CHAR(1)
);

GO

-- Получаем сообщение об ошибке.
-- String or binary data would be truncated.
INSERT dbo.TableName(ColumnName)
VALUES ('Char');

GO

-- При передачи значения в хранимую процедуру, строка усекается, без ошибки.
CREATE PROCEDURE dbo.StoredProcedureName
     @Char CHAR -- CHAR(1)
AS
BEGIN
     SET NOCOUNT ON;

     INSERT dbo.TableName
     VALUES (@Char);
END

GO

EXEC dbo.StoredProcedureName 'Char';

SELECT ColumnName
FROM   dbo.TableName;

GO