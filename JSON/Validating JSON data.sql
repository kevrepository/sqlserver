/*
ISJSON ( expression )

1 - входная строка соответствует JSON.
0 - входная строка недействительна.
NULL - входное выражение NULL.
*/

SELECT ISJSON('test')     -- 0
      ,ISJSON('')         -- 0 
      ,ISJSON('{}')       -- 1
      ,ISJSON('{"a"}')    -- 0 
      ,ISJSON('{"a":1}')  -- 1
      ,ISJSON('{"a":1"}') -- 0

SELECT ISJSON('{"id": 1, "id": "a"}') -- 1