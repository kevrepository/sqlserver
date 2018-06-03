DECLARE @Password varbinary(MAX) = CONVERT(varbinary(MAX), 'Pa$$w0rd')
       ,@Salt     varbinary(4)   = CRYPT_GEN_RANDOM(4);

SELECT CONVERT(nvarchar(MAX), 0x0200 + @Salt + HASHBYTES('SHA2_512', @Password + @Salt));