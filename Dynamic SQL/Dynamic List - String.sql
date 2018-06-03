DECLARE @IDs NVARCHAR(MAX);

SELECT @IDs = COALESCE(@IDs + ', ', '') + 'ContactTypeID: ' + CONVERT(NVARCHAR(10), ContactTypeID) + ', Name: ' + Name
FROM   person.ContactType;

SELECT @IDs;

GO