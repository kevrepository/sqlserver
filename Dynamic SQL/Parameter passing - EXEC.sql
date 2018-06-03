DECLARE @Statement  NVARCHAR(MAX)
       ,@Parameters NVARCHAR(MAX)
       ,@FirstName  NVARCHAR(50) = 'Edward';

IF OBJECT_ID('tempdb..#LastNames', 'U') IS NOT NULL
    DROP TABLE #LastNames;

CREATE TABLE #LastNames 
(
    LastName NVARCHAR (50) NOT NULL
);

SET @Statement = '
SELECT LastName
FROM   Person.Person
WHERE  FirstName = @FirstName;';

SET @Parameters = '@FirstName NVARCHAR(50)';

INSERT INTO #LastNames (LastName) EXEC sp_executesql @Statement, @Parameters, @FirstName = @FirstName;

SELECT *
FROM #LastNames;