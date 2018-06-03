DECLARE @Statement  NVARCHAR(MAX)
       ,@Parameters NVARCHAR(MAX)
       ,@FirstName  NVARCHAR(50) = 'Edward';

SELECT @Statement = '
SELECT *
FROM   Person.Person
WHERE  FirstName = @FirstName;

SET @FirstName = ''Xavier'';

SELECT @FirstName;';

SET @Parameters = '@FirstName NVARCHAR(50) OUTPUT';

EXEC sp_executesql @Statement, @Parameters, @FirstName OUTPUT;

SELECT @FirstName;

GO