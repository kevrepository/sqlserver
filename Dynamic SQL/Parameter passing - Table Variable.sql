IF EXISTS(SELECT *
          FROM   sys.table_types
          WHERE  name = 'LastNames')
    DROP TYPE LastNames;
    
GO

CREATE TYPE LastNames AS TABLE
(
    LastName NVARCHAR(50) NOT NULL
);

GO

DECLARE @Statement  NVARCHAR(MAX)
       ,@Parameters NVARCHAR(MAX)
       ,@FirstName  NVARCHAR(50) = 'Edward'
       ,@LastNames  LastNames;

INSERT INTO @LastNames (LastName)
SELECT LastName
FROM   Person.Person 
WHERE  FirstName = @FirstName;

SET @Statement = '
SELECT *
FROM   Person.Person
WHERE  LastName IN (SELECT LastName 
                    FROM   @LastNames);'

SET @Parameters = '@FirstName NVARCHAR(50), @LastNames LastNames READONLY';

EXEC sp_executesql @Statement, @Parameters, @FirstName, @LastNames;

GO