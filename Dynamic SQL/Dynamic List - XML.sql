DECLARE @IDs NVARCHAR(MAX) = '';

SET @IDs = STUFF((SELECT N',' + CONVERT(NVARCHAR(10), BusinessEntityID)
                  FROM   Person.Person
                  ORDER  BY LastName
                  FOR    XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

SELECT @IDs AS IDs;

GO