/*
OPENJSON( jsonExpression [ , path ] )   
[
    WITH (    
        column_name data_type [ column_path ] [ AS JSON ]   
    [ , column_name data_type [ column_path ] [ AS JSON ] ]   
    [ , . . . n ]    
    )   
]   
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
FROM   OPENJSON(@json) 
WITH   ( 
           AlbumName NVARCHAR(50) '$.Album'
          ,AlbumYear SMALLINT '$.Year'
          ,IsVinyl   BIT '$.IsVinyl'
       );


