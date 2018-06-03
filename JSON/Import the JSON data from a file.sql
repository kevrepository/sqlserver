SELECT S.SongTitle
      ,S.SongAuthors
	  ,A.AlbumName
	  ,A.AlbumYear
	  ,A.IsVinyl
FROM   OPENROWSET(BULK 'D:\SQL Server Info\JSON\JSONAlbum.json', SINGLE_CLOB) AS JSONA
       CROSS APPLY OPENJSON(JSONA.BulkColumn) 
       WITH 
	   ( 
           AlbumName NVARCHAR(50) '$.Album'
		  ,AlbumYear SMALLINT '$.Year'
		  ,IsVinyl   BIT '$.IsVinyl'
		  ,Songs     NVARCHAR(MAX) '$.Songs' AS JSON
		  ,Members   NVARCHAR(MAX) '$.Members' AS JSON
       ) AS A
       CROSS APPLY OPENJSON(A.Songs)
       WITH 
       ( 
           SongTitle   NVARCHAR(200) '$.Title'
		  ,SongAuthors NVARCHAR(200) '$.Authors'
       ) AS S;