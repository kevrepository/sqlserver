SELECT ProductID
      ,Name
FROM   Production.Product
ORDER  BY Name FOR JSON AUTO;

GO

SELECT ProductID
      ,Name
FROM   Production.Product
ORDER  BY Name FOR JSON PATH;

GO

-- Добавление корневого узла.
SELECT ProductID
      ,Name
FROM   Production.Product
ORDER  BY Name FOR JSON PATH, ROOT('Products');

GO

-- Вложенные свойства (SellStartDate, SellEndDate) нового свойства SellDate.
SELECT ProductID
      ,Name
	  ,SellStartDate AS 'SellDate.DateStart'
	  ,SellEndDate AS 'SellDate.DateEnd'
FROM   Production.Product
ORDER  BY Name FOR JSON PATH;

GO

-- Включение нулевых значений.
SELECT ProductID
      ,Name
	  ,SellStartDate AS 'SellDate.DateStart'
	  ,SellEndDate AS 'SellDate.DateEnd'
FROM   Production.Product
ORDER  BY Name FOR JSON PATH, INCLUDE_NULL_VALUES;

GO

-- Форматировать как отдельный объект.
SELECT ProductID
      ,Name
FROM   Production.Product
WHERE  ProductID = 1
ORDER  BY Name FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;

GO
