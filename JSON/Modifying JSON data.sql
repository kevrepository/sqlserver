/*
JSON_MODIFY ( expression , path , newValue )
*/

-- Adding a new JSON property.
DECLARE @JSONAlbum NVARCHAR(MAX) = N'
{ 
    "Album":"Wish You Were Here", 
    "Year":1975 
}';

SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.IsVinyl', CONVERT(BIT, 1));
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.Members', JSON_QUERY(N'["Gilmour","Wright","Mason"]')); -- JSON_QUERY
 
PRINT @JSONAlbum;

-- Updating the value for a JSON property.
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.IsVinyl', CONVERT(BIT, 0));
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.Year', 1976);
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.Members[0]', 'Barrett'); 
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, 'append $.Members', 'Waters'); 

PRINT @JSONAlbum;

--SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.Year', NULL);
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, 'strict $.Year', NULL);

PRINT @JSONAlbum;

-- Removing a JSON property.
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.Year', NULL);
SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.Members[0]', NULL); 

PRINT @JSONAlbum;

SET @JSONAlbum = JSON_MODIFY(@JSONAlbum, '$.Members', JSON_QUERY(N'["Waters","Wright","Mason"]')); -- JSON_QUERY

PRINT @JSONAlbum;

-- Multiple changes.
SET @JSONAlbum = JSON_MODIFY(JSON_MODIFY(JSON_MODIFY(@JSONAlbum, '$.IsVinyl', CONVERT(BIT, 1)), '$.Recorded', 'Abbey Road Studios'), 'append $.Members', 'Barrett');

PRINT @JSONAlbum;
