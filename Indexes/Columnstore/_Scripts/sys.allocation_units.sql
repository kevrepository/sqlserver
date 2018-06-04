SELECT i.name AS index_name
      ,p.index_id
      ,p.partition_number
      ,p.data_compression_desc
      ,au.type_desc
      ,au.total_pages
      ,au.used_pages
      ,au.data_pages
FROM   sys.partitions AS p 
       INNER JOIN sys.allocation_units AS au 
               ON p.partition_id = au.container_id
       INNER JOIN sys.indexes AS i
               ON p.object_id = i.object_id 
                  and p.index_id = i.index_id
WHERE  p.object_id = object_id(N'Sales.SalesOrderDetail');