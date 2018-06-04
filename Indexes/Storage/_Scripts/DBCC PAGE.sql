/*
    DBCC PAGE ( { database_name | database_id | 0}, file_number, page_number [,print_option ={0|1|2|3} ]);

    database_name | database_id | 0
        Имя базы данных или идентификатор базы данных. Если задано значение 0, будет использоваться текущая база данных.
    file_number
        Номер файла.
    page_number
        Номер страницы.
    print_option = {0|1|2|3}
        Способ возврата результата. По умолчанию используется 0.
            
    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch02.xhtml#Sec24
*/

DBCC TRACEON (3604);

DBCC PAGE ('AdventureWorks2014', 1, 25768, 3);