/*
    DBCC SHOW_STATISTICS ( table_or_indexed_view_name, target )  [ WITH [ NO_INFOMSGS ] < option > [ , n ] ]
    
    < option > :: = STAT_HEADER | DENSITY_VECTOR | HISTOGRAM | STATS_STREAM

    table_or_indexed_view_name
        Имя таблицы или индексированного представления, для которого должны быть отображены статистические данные.
    target
        Имя индекса, статистики или столбца, для которого отображаются статистические данные.
    
    NO_INFOMSGS
        Подавляет все информационные сообщения со степенями серьезности от 0 до 10.

    STAT_HEADER | DENSITY_VECTOR | HISTOGRAM | STATS_STREAM
        Указание одного или более из этих параметров ограничивает результирующие наборы. Если параметры не указаны, то возвращаются все статистические данные.
    
    HISTOGRAM
        RANGE_HI_KEY
            Верхнее значение столбца для этапа гистограммы.
        RANGE_ROWS
            Оценочное количество строк, значение столбца которых находится на этапе гистограммы, исключая верхнюю границу.
        EQ_ROWS
            Оценочное количество строк, значение столбца которых равно верхней границе шага гистограммы.
        DISTINCT_RANGE_ROWS
            Оценочное количество строк с отдельным значением столбца на этапе гистограммы, исключая верхнюю границу.
        AVG_RANGE_ROWS
            Среднее количество строк с повторяющимися значениями столбцов на этапе гистограммы, исключая верхнюю границу (RANGE_ROWS / DISTINCT_RANGE_ROWS для DISTINCT_RANGE_ROWS > 0).
            В нем указано, сколько строк можно ожидать, когда извлекается какое-либо одно значение или диапазон значений из статистики.

    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch03.xhtml#Sec2
*/

USE AdventureWorks2014;
GO

DBCC SHOW_STATISTICS ('Person.Address', PK_Address_AddressID);
GO