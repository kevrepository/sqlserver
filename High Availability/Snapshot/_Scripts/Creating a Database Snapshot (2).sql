DECLARE @DatabaseName         nvarchar(128) = 'AdventureWorks2014'
       ,@LogicalFileName      nvarchar(128)
       ,@PhysicalFileName     nvarchar(255)
       ,@PhysicalPathName     nvarchar(255)
       ,@Statement            nvarchar(MAX) = ''; 

DECLARE DatabaseFiles CURSOR FOR   
SELECT mf.name AS logical_file_name
      ,REVERSE(SUBSTRING(REVERSE(mf.physical_name), 1, CHARINDEX(N'\', REVERSE(mf.physical_name)) - 1)) AS physical_file_name
      ,REVERSE(SUBSTRING(REVERSE(mf.physical_name), CHARINDEX(N'\', REVERSE(mf.physical_name)), LEN(mf.physical_name) - CHARINDEX(N'\', REVERSE(mf.physical_name)) + 1)) AS physical_path_name
FROM   sys.master_files AS mf
       INNER JOIN sys.databases AS d
               ON d.database_id = mf.database_id
WHERE mf.type = 0
      AND d.name = @DatabaseName;

OPEN DatabaseFiles;

FETCH NEXT FROM DatabaseFiles 
INTO @LogicalFileName, @PhysicalFileName, @PhysicalPathName;

WHILE @@FETCH_STATUS = 0  
BEGIN
    SET @PhysicalFileName = @PhysicalPathName + 'SNAP_' + SUBSTRING(@PhysicalFileName, 1, CHARINDEX('.', @PhysicalFileName)) + 'snap';
    
    SET @Statement += ', (NAME = ' + @LogicalFileName + ', FILENAME = ''' + @PhysicalFileName + ''')';
    
    FETCH NEXT FROM DatabaseFiles 
    INTO @LogicalFileName, @PhysicalFileName, @PhysicalPathName;
END;

CLOSE DatabaseFiles;
DEALLOCATE DatabaseFiles;

IF @Statement <> ''
BEGIN
    SET @Statement = 
        'CREATE DATABASE ' + 'SNAP_' + @DatabaseName + ' ON ' + SUBSTRING(@Statement, 3, LEN(@Statement) - 1) + ' AS SNAPSHOT OF ' + @DatabaseName + ';';

    EXEC sp_executesql @Statement;
END;

--EXEC SP_HELPDB AdventureWorks2016;