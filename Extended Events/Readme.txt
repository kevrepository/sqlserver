Расширенные события используют формат XML. 
Каждый тип события имеет свой собственный набор столбцов данных. Можно собрать дополнительные атрибуты, путем выполнения операторов, называемых действиями. 

Когда SQL Server запускает событие, он проверяет любые активные сеансы событий, которые потребляют такое событие. 
Когда такие сеансы существуют, SQL Server собирает столбцы данных событий и, если определены предикаты, собирает информацию, необходимую для их оценки. 
Если предикатная оценка удалась, SQL Server собирает все действия, передает данные синхронным целям и буферизует данные для асинхронных целей.

Пакеты (Packages)
    SQL Server объединяет объекты расширенных событий в пакеты.
    
    Типы пакетов SQL Server:
        package0
            Системные объекты расширенных событий.
        sqlserver
            Используется для объектов, связанных с SQL Server.
        sqlos
            Объекты, связанные с операционной системой SQL Server (SQLOS).
        SecAudit
            Является закрытым и используется SQL Server для функций аудита.
           
    Пакеты расширенных событий:
    
        SELECT dxp.guid
              ,dxp.name
              ,dxp.description
              ,dxp.capabilities
              ,dxp.capabilities_desc
              ,dolm.name as module_name
        FROM   sys.dm_xe_packages AS dxp 
               INNER JOIN sys.dm_os_loaded_modules dolm 
                       ON dolm.base_address = dxp.module_address;
     
События (Events)
    
    Cобытия:
        SELECT dxp.name AS package_name
              ,dxo.name AS event_name
              ,dxo.description
        FROM   sys.dm_xe_packages AS dxp 
               INNER JOIN sys.dm_xe_objects AS dxo 
                       ON dxo.package_guid = dxp.guid
        WHERE  (dxp.capabilities IS NULL 
                OR dxp.capabilities & 1 = 0)     -- Exclude private packages.
               AND (dxo.capabilities IS NULL
                    OR dxo.capabilities & 1 = 0) -- Exclude private objects.
               AND dxo.object_type = 'event'
        ORDER  BY dxp.name, dxo.name;
        
    Каждое событие имеет набор столбцов, относящихся к одной из трех категорий, следующим образом:
        - Только для чтения содержат статическую информацию о событии (GUID события, версию схемы и т.д.).
        - Cтолбцы данных содержат данные о событии во время выполнения (количество операций ввода-вывода, время процессора и т.д.).
        - Настраиваемые столбцы позволяют изменять их значения во время создания сеанса событий, они управляют поведением события.
        
    Столбцы событий:
        SELECT dxoc.column_id
              ,dxoc.name
              ,dxoc.type_name AS data_type_name
              ,dxoc.column_type AS column_type_name
              ,dxoc.column_value
              ,dxoc.description
        FROM   sys.dm_xe_object_columns AS dxoc
        WHERE  dxoc.object_name = 'sql_statement_completed';
        
Предикаты (Predicates)
    Предикаты определяют булевы условия, когда необходимо запустить событие.
    
    SQL Traces оценивает фильтры столбцов после того, как событие будет собрано и передано контроллеру трассировки. 
    Расширенные события собирают минимально необходимый объем данных для оценки предикатов и не выполняют действия или событие, если предикаты были оценены как False.
    
    Список глобальных атрибутов:
    
        SELECT dxp.name AS package_name
              ,dxo.name AS predicate_name
              ,dxo.description
        FROM   sys.dm_xe_packages AS dxp 
               INNER JOIN sys.dm_xe_objects AS dxo 
                       ON dxo.package_guid = dxp.guid
        WHERE  (dxp.capabilities IS NULL 
                OR dxp.capabilities & 1 = 0)     -- Exclude private packages.
               AND (dxo.capabilities IS NULL
                    OR dxo.capabilities & 1 = 0) -- Exclude private objects.
               AND dxo.object_type = 'pred_source'
        ORDER  BY dxp.name, dxo.name;
        
    Функции сравнения, которые могут использоваться в предикатах:
    
        SELECT dxp.name AS package_name
              ,dxo.name AS comparison_function
              ,dxo.description
        FROM   sys.dm_xe_packages AS dxp 
               INNER JOIN sys.dm_xe_objects AS dxo 
                       ON dxo.package_guid = dxp.guid
        WHERE  (dxp.capabilities IS NULL 
                OR dxp.capabilities & 1 = 0)     -- Exclude private packages.
               AND (dxo.capabilities IS NULL 
                    OR dxo.capabilities & 1 = 0) -- Exclude private objects.
               AND dxo.object_type = 'pred_compare'
        ORDER  BY dxp.name, dxo.name;
        
    Сбор данных глобальных атрибутов добавляет небольшие накладные расходы для оценки предикатов. 
    Полезно писать несколько предикатов таким образом, чтобы столбцы данных событий оценивались до глобальных атрибутов, тем самым предотвращая сбор данных глобальных атрибутов.
    
    package0.counter - счетчик предиката (увеличивается, когда оценивает, важен порядок предикатов).
        
    package0.divides_by_uint64(поле, значение) - этот компаратор оценивает, делится ли одно число другим без остатка.
    
Дествия (Actions)
    Действия предоставляют вам возможность собирать дополнительную информацию с помощью событий.
    Действия выполняются синхронно в том же потоке, что и события, что добавляет накладные расходы на сбор событий. 
    
    Cписок доступных действий:
    
        SELECT dxp.name AS package_name
              ,dxo.name AS action_name
              ,dxo.description
        FROM   sys.dm_xe_packages AS dxp 
               INNER JOIN sys.dm_xe_objects AS dxo 
                       ON dxo.package_guid = dxp.guid
        WHERE  (dxp.capabilities IS NULL 
                OR dxp.capabilities & 1 = 0)     -- Exclude private packages.
               AND (dxo.capabilities IS NULL 
                    OR dxo.capabilities & 1 = 0) -- Exclude private objects.
               AND dxo.object_type = 'action'
        ORDER  BY dxp.name, dxo.name;
        
Типы (Types)
    
    SELECT name
          ,description
          ,type_name
          ,type_size
    FROM   sys.dm_xe_objects
    WHERE  object_type = 'type';
    
Карты (Maps)
    Перечисления, которые преобразуют целые ключи в удобочитаемое представление (например: карта wait_types позволяет вам преобразовать этот код в понятное определение типа ожидания).
    
    SELECT name
          ,description
          ,type_name
          ,type_size
    FROM   sys.dm_xe_objects
    WHERE  object_type = 'map';
    
    Значение ключей:
    
        SELECT name as map_name
              ,map_key
              ,map_value
        FROM   sys.dm_xe_map_values
        WHERE  name = 'wait_types'
        ORDER  BY map_key;
        
Цели (Targets)
    
    SELECT dxp.name AS package_name
          ,dxo.name AS target_name
          ,dxo.description
    FROM   sys.dm_xe_packages AS dxp 
           INNER JOIN sys.dm_xe_objects AS dxo 
                   ON dxo.package_guid = dxp.guid
    WHERE  (dxp.capabilities IS NULL 
            OR dxp.capabilities & 1 = 0)     -- Exclude private packages.
           AND (dxo.capabilities IS NULL
                OR dxo.capabilities & 1 = 0) -- Exclude private objects.
           AND dxo.object_type = 'target'
    ORDER  BY dxp.name, dxo.name;
    
    ring_buffer
        Асинхронная цель.
        Хранит данные в памяти кольцевого буфера заданного размера. Когда он заполнен, новые события перекрывают самые старые в буфере.
        
        Параметры:        
            max_memory
                Максимальный объем памяти для использования (KB).
            max_event_limit
                Максимальное количество событий (по умолчанию 1000).
            occurrence_number
                Значение 0 (по умолчанию) указывает, что самое старое событие отбрасывается, когда используется вся память.
                Значение больше 0, указывает предпочтительное количество событий каждого типа, где самые старые события каждого типа отбрасываются, когда используется вся память.
            
    asynchronous_file_target (SQL Server 2008/2008R2) и event_file (SQL Server 2012-2016)
        Aсинхронная цель. 
        Цели хранения событий в файле, используют собственный двоичный формат.
        
        Параметры:
            filename
                Местоположение файла и имя файла.
            max_file_size
                Максимальный размер файла (MB).
            max_rollover_files
                Максимальное количество файлов для сохранения.
            increment
                Инкрементный рост для файла (MB). Если не указано, значение по умолчанию для инкремента удваивает размер буфера сеанса.
                
    etw_classic_sync_target
        Синхронная цель. 
        Цель хранения событий в формате, который может быть использован ETW.
        
    synchronous_bucketizer (SQL Server 2008/2008R2), asynchronous_bucketizer (SQL Server 2008/2008R2) и histogram (SQL Server 2012-2016)
        Цель histogram асинхронная.
        Цели позволяют подсчитать количество конкретных событий, группируя результаты, основанные на колонке данных указанного события или действия.
        
        Параметры:
            source_type
                Тип объекта, по которому идет группировка (0 — поля событий, 1 — действия). 
            source 
                Имя столбца события или действие, которое предоставляет данные для группировки.
            slots 
                Указывает максимальное количество различных значений (групп) для сохранения. SQL Server игнорирует все новые значения (группы), как только это число будет достигнуто.
            filtering_event_name 
                Указывающее событие из сеанса событий, который вы используете в качестве источника данных для группировки (необязательное значение).
                   
    pair_matching
        Асинхронная цель. 
        Помогает устранить ситуации, при которых одно из ожидаемых событий по какой-то причине не происходит (например: поиск событий database_transaction_begin без соответствующих событий database_transaction_end).
        
        Параметры:
            begin_event
                Начальное имя события.
            end_event
                Конечное имя события.
            begin_matching_columns
            end_matching_columns
                Столбцы для срвнения.
            begin_matching_actions
            end_matching_actions
                Действия для срвнения.
            respond_to_memory_pressure
                0 - не реагировать на давление памяти, 1 - прекратить добавлять новых сирот в список при наличии давления памяти.
            max_orphans (по умолчанию 10000)
                Общее количество непарных событий, которые будут собраны в целевом объекте. Как только предел достигнут, непарные события удаляются по принципу FIFO.
        
    synchronous_event_counter (SQL Server 2008/2008R2) и event_counter (SQL Server 2012-2016)
        Синхронная цель. 
        Цели позволяют подсчитать количество вхождений определенных событий.
        
    Свойства цели:
    
        SELECT doc.column_id
              ,doc.name as column_name
              ,doc.type_name
              ,doc.description
              ,doc.capabilities_desc
        FROM   sys.dm_xe_objects AS dxo 
               INNER JOIN sys.dm_xe_object_columns AS doc 
                       ON dxo.package_guid = doc.object_package_guid 
                          AND doc.object_name = dxo.name
        WHERE  dxo.object_type = 'target'
               AND dxo.name = 'event_file'
        ORDER  BY doc.column_id;
        
Параметры конфигурации сеанса:
    
    MAX_MEMORY 
        Задает максимальный объем памяти, выделенной в сеансе для буферов событий. Значение по умолчанию 4 MB.
    
    EVENT_RETENTION_MODE
        NO_EVENT_LOSS 
            Указывает, что все события должны быть сохранены, а потеря события неприемлема. Потоки выполнения SQL Server ожидают, пока буферы будут сброшены и появится свободное место для размещения новых событий.
        ALLOW_SINGLE_EVENT_LOSS 
            Позволяет сеансу потерять одно событие, когда буферы заполнены.
        ALLOW_MULTIPLE_EVENT_LOSS 
            Позволяет сеансу потерять несколько событий, когда буферы заполнены.
            
    MEMORY_PARTITION_MODE 
        NONE
            SQL Server использует три центральных буфера с размером MAX_MEMORY / 3, округленным до следующей границы 64 КБ (например: MAX_MEMORY из 4000 КБ будет создавать три буфера по 1344 КБ каждый независимо от конфигурации сервера).
        PER_NODE
            SQL Server создает отдельный набор из трех буферов для каждого узла NUMA (например: на сервере с двумя узлами NUMA MAX_MEMORY из 4000 КБ создаст шесть буферов, три на узел, размером 704 КБ на буфер).
        PER_CPU
            SQL Server создает количество буферов на основе этой формулы, 2.5 * (количество процессоров) и разбивает их по каждому процессору (например, на сервере с 20 процессорами MAX_MEMORY из 4000 КБ будет создавать 50 буферов по 128 КБ каждый).
            
    MAX_DISPATCH_LATENCY
        SQL Server сбрасывает данные сеанса событий в асинхронные цели, когда буферы заполнены и/или основаны на временном интервале, который по умолчанию равен 30 секундам.
        
    STARTUP_STATE 
        Должен ли сеанс запускаться автоматически при запуске SQL Server.
        
    TRACK_CAUSALITY 
        Позволяет отслеживать последовательность событий и видеть, как разные события ведут друг к другу (например: оператор SQL, запускает событие чтения файла, которое, в свою очередь, вызывает событие ожидания с ожиданием PAGELATCHIO и т.д.) 
        Когда этот параметр включен, SQL Server добавляет уникальный идентификатор активности, который представляет собой комбинацию значения GUID, которое остается неизменным для задачи, и номер последовательности событий.
    
Представления управления данными расширенных событий:
    
    sys.dm_xe_sessions 
        Cодержит информацию об активных сеансах событий.
    sys.dm_xe_session_targets
        Информация о целях.
        Размер вывода XML-столбца target_data ограничен до 4 МБ. Это может привести к ситуации, когда некоторые события из цели ring_buffer отсутствуют в представлении.
        События хранятся в двоичном формате внутри, а сериализация XML может значительно увеличить выходной размер, делая его более 4 МБ.
    sys.dm_xe_sessions_object_columns 
        Отображаются значения конфигурации для объектов, привязанных к сеансу.