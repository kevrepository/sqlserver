/*
    DBCC IND ( {'database_name' | database_id | 0}, {'table_name' | table_id}, {'index_name' | index_id | -1} );

    'database_name' | database_id
        Имя базы данных или идентификатор базы данных. Если для этого параметра задано значение 0, будет использоваться текущая база данных.
    'table_name' | table_id
        Имя таблицы или идентификатор таблицы.
    'index_name' | index_id | -1
        Имя индекса или идентификатор индекса. Если значение -1, то вывод будет включать результаты для всех индексов в таблице.

    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch02.xhtml#Sec22
*/

DBCC IND ('AdventureWorks2014', 'Person.Address', 1);