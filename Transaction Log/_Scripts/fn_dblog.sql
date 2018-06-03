/*
    You can try trace flag 2537, which allows looking at inactive VLFs.

    DBCC TRACEON(2537);
*/

SELECT * 
FROM   sys.fn_dblog(NULL, NULL)
WHERE  Operation LIKE '%delete%';