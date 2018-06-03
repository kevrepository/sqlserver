DECLARE @Statement  NVARCHAR(MAX)
       ,@Parameters NVARCHAR(MAX);

IF OBJECT_ID('tempdb..#LastNames', 'U') IS NOT NULL
    DROP TABLE #LastNames;

CREATE TABLE #LastNames
(
    LastName NVARCHAR(50)
);

INSERT #LastNames (LastName)
VALUES (N'Thomas');

SELECT @Statement = '
SELECT *
FROM   Person.Person
WHERE  LastName IN (SELECT LastName 
                    FROM #LastNames)
                    
INSERT #LastNames (LastName)
VALUES (N''Smith'');';

EXEC sp_executesql @Statement;

SELECT *
FROM   #LastNames;

GO