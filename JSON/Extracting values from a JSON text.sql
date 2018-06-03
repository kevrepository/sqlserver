/*
JSON_VALUE ( expression , path )

If the length of a JSON property value or string element is longer than 4,000, the function returns NULL.
*/

DECLARE @JSONAlbum NVARCHAR(MAX) = N'
{ 
    "Album":"Wish You Were Here"
   ,"Year":1975
   ,"IsVinyl":true
   ,"Members":[
        "Gilmour"
       ,"Waters"
	   ,"Wright"
	   ,"Mason"
	]
}';

SELECT JSON_VALUE(@JSONAlbum, '$.Album') AS Album
      ,JSON_VALUE(@JSONAlbum, '$.Year') AS [Year]
      ,JSON_VALUE(@JSONAlbum, '$.IsVinyl') AS IsVinyl
      ,JSON_VALUE(@JSONAlbum, '$.Members[0]') AS Member;

GO
/*
JSON_QUERY ( expression [ , path ] )
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

SELECT JSON_QUERY(@JSONAlbum,'$.Songs'); 
SELECT JSON_QUERY(@JSONAlbum,'$.Members'); 
SELECT JSON_QUERY(@JSONAlbum,'$.Songs[3]');