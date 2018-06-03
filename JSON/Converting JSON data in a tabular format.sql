-- Compatibility level 130.

/*
JSON data type of the value

0 null
1 string
2 number
3 true/false
4 array
5 object
*/

DECLARE @JSONAlbum NVARCHAR(MAX) = N'
{  
    "Album":"Wish You Were Here"
   ,"Year":1975
   ,"IsVinyl":true
   ,"Songs":[
       {
          "Title":"Shine On You Crazy Diamond"
          ,"Authors":"Gilmour, Waters, Wright"
       }
      ,{
          "Title":"Have a Cigar"
          ,"Authors":"Waters"
       }
      ,{
          "Title":"Welcome to the Machine"
          ,"Authors":"Waters"
       }
      ,{
          "Title":"Wish You Were Here"
          ,"Authors":"Gilmour, Waters"
       }
    ]
   ,"Members":{
        "Guitar":"David Gilmour"
       ,"Bass Guitar":"Roger Waters"
       ,"Keyboard":"Richard Wright"
       ,"Drums":"Nick Mason"
    }
}';

SELECT [key]
      ,[value]
	  ,[type]
FROM OPENJSON(@JSONAlbum);


SELECT [key]
      ,[value]
	  ,[type]
FROM OPENJSON(@JSONAlbum, '$.Songs');

SELECT [key]
      ,[value]
	  ,[type]
FROM OPENJSON(@JSONAlbum, '$.Members');

-- Обработка данных из списка значений, разделенных запятыми.
DECLARE @IDs AS VARCHAR(100) = '1,2,3,4,9,10'; 

SELECT T.ID
      ,T.[Name]
FROM   (VALUES (1, 'Adjustable Race')
              ,(2, 'All-Purpose Bike Stand')
              ,(3, 'AWC Logo Cap')
              ,(4, 'BB Ball Bearing')
              ,(5, 'Bearing Ball')
              ,(6, 'Bike Wash - Dissolver')
              ,(7, 'Blade')
              ,(8, 'Cable Lock')
              ,(9, 'Chain')
              ,(10, 'Chain Stays')) AS T(ID, [Name])
       INNER JOIN (SELECT value 
	               FROM   OPENJSON('[' + @IDs + ']')) AS IDs 
	           ON IDs.value = T.ID;