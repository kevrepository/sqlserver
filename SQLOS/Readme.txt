SQLOS - это платформа, которая функционирует как пользовательская операционная система, отвечающая за управление ресурсами.
Он используется для операций низкого уровня, таких как планирование, ввод-вывод, управление памятью и управление ресурсами.

Сессии (Sessions).
    Когда приложение аутентифицируется на SQL Server, оно устанавливает соединение в контексте сеанса, которое идентифицируется session_id.
    Просмотреть список всех прошедших проверку сеансов, можно запросив sys.dm_exec_sessions (пользовательские сессии, лучше отфильтровать используя is_user_process).
    
    Возможные значения состояния сессии:
        RUNNING
            В настоящее время выполняется один или несколько запросов.
        SLEEPING
            В настоящее время подключен, но нет выполняющихся запросов.
        DORMANT
            Сеанс был сброшен из-за пула соединений и теперь находится в состоянии предварительного входа.
        PRECONNECT
            Сеанс находится в классификаторе Resource Governor.
            
Запросы (Requests).
    Для запроса информации о запросе, можно использовать sys.dm_exec_requests.

Задания (Tasks) (см. рис. Процесс выполнения задачи.jpg).
    Задачи представляют собой фактическую работу, которая должна выполняться SQLOS, но они сами не выполняют никакой работы.
    Когда запрос получен SQL Server, для выполнения запроса будут созданы одна или несколько задач.
    Количество задач, которые генерируются для запроса, зависит от того, выполняется ли запрос с использованием параллелизма или если он выполняется последовательно.

    Для запроса информации о задаче, можем использовать sys.dm_os_tasks.
    Состояние задачи можно определить, посмотрев на стобец task_state:
        PENDING
            Ожидание рабочего потока.
        RUNNABLE
            Готов к запуску, но ожидает получения кванта времени.
        RUNNING
            Выполняется в планировщике.
        SUSPENDED
            Рабочий поток ждет ресурс.
        DONE
            Завершено.
        SPINLOOP
            Находится в спин-блокировке.
    
Рабочие потоки (Worker Threads).
    Рабочие потоки - это то, где выполняется фактическая работа для запроса.
    Каждая создаваемая задача получит назначенный ей рабочий поток, а рабочий поток затем выполнит действия, запрошенные задачей.
    
    Рабочий поток фактически не выполняет саму работу, он запрашивает поток из операционной системы Windows для выполнения этой работы.
    Получить доступ к информации о потоках операционной системы Windows, можно запросив sys.dm_os_threads.
    
    В случае, когда ни один рабочий поток не может быть найден, и максимальное количество рабочих потоков было достигнуто, запрос будет поставлен в очередь до тех пор, пока рабочий поток не завершит свою текущую работу и не станет доступным.
    
    Мы также можем вычислить максимальное количество рабочих потоков, используя эти формулы:
        32-разрядная система с менее или равными 4 логическими процессорами: 256 рабочих потоков.
        32-разрядная система с более чем 4 логическими процессорами: 256 + ((количество логических процессоров - 4) * 8).
        64-битная система с менее или равными 4 логическими процессорами: 512 рабочих потоков.
        64-битная система с более чем 4 логическими процессорами: 512 + ((количество логических процессоров - 4) * 16).
        
        Пример: если у нас 64-разрядная система с 16 процессорами (или ядрами) мы можем вычислить максимальное число рабочих потоков, используя формулу 512 + ((16 - 4) * 16), что даст нам максимум 704 рабочих потока.
        
    Максимальное количество рабочих потоков:
        
        SELECT max_workers_count
        FROM sys.dm_os_sys_info;
        
    Количество рабочих потоков может быть изменено путем изменения праметра Maximum worker threads в свойствах SQL сервера.
    
    Для 32-разрядных систем требуется 512 КБ для каждого рабочего потока. Для 64-разрядных систем требуется 2048 КБ для каждого рабочего потока.
    
    SQL Server автоматически уничтожит рабочие потоки, если они простаивают в течение 15 минут или если ваш SQL Server находится под большим давлением памяти.
    
    Для запроса информации о рабочих потоках, можем использовать sys.dm_os_workers.
    
    Рабочие потоки проходят разные фазы, пока они подвергаются воздействию процессора, которые мы можем видеть, когда мы смотрим на столбец state в sys.dm_os_workers DMV:
        - INIT.
            Рабочий поток инициализируется SQLOS.
        - SUSPENDED.
            Рабочий поток ждет ресурс.
        - RUNNABLE.
            Рабочий поток готов к работе на процессоре.
        - RUNNING.
            Рабочий поток в настоящее время выполняет работу над процессором.
            
    Задача может также выполняться в превентивном режиме, но это произойдет только тогда, когда задача запускает код вне домена SQL Server (расширенные хранимые процедуры, распределенный запрос, другой внешнего код).
    Поскольку код не находится под управлением SQL Server, рабочий поток переключается в превентивный режим, и задача запускается в этом режиме, поскольку он не контролируется планировщиком.
    Вы можете определить, работает ли рабочий поток в превентивном режиме, посмотрев на столбец is_preemptive в sys.dm_os_workers.
            
Планировщики.
    Когда задача запрашивает время процессора, планировщик, назначает рабочие потоки, чтобы запрос мог обрабатываться.
    Он также отвечает за то, чтобы рабочие потоки взаимодействовали друг с другом и уступали процессор, когда их квант времени истек.
        
    Каждый фактический процессор (будь то гиперпоточность или физические ядра) имеет планировщик, созданный для него при запуске SQL Server.
    Если в вашей системе два процессора, каждый из которых имеет четыре ядра, будет восемь планировщиков, которые SQLOS может использовать для обработки пользовательских запросов, каждый из которых сопоставляется с одним из логических процессоров.
    
    Изменение значения привязки процесса может изменить статус одного или нескольких планировщиков в OFFLINE, что вы можете сделать, не перезагружая свой SQL Server. 
    Обратите внимание, что когда планировщик переключается с ONLINE на OFFLINE из-за изменения конфигурации, любая работа, уже назначенная планировщику, сначала завершается, и новая работа не назначается.
    SQL Server поддерживает схожесть процессоров с помощью двух параметров: affinity mask (также известен как CPU affinity mask) и affinity I/O mask.
    
    Для отображения информации о планировщиках, можно использовать sys.dm_os_schedulers. Планировщики, выполняющие пользовательские запросы, имеют идентификационный номер менее 1048576 и помечены как "VISIBLE ONLINE".
    Столбец мax_workers_count в sys.dm_os_sys_info показывет максимальное количество рабочих потоков, которые могут быть созданы, а active_worker_count в sys.dm_os_schedulers показывает количество рабочих потоков, которые активны в данный момент времени.
    Мы можем просмотреть количество рабочих потоков, связанных с планировщиком, просмотрев столбец current_workers_count в sys.dm_os_schedulers.
    Столбец work_queue_count, показывает, сколько задач ждут свободного рабочего потока (высокие цифры в этом столбце, могут означать, давление в ЦП).
    
    Существует также специальный тип планировщика со статусом "VISIBLE ONLINE (DAC)". Это планировщик, предназначенный для использования с выделенным соединением администратора. 
    Этот планировщик позволяет подключаться к SQL Server в ситуациях, когда он не отвечает (например, когда нет свободных рабочих потоков, доступных в планировщиках, которые обрабатывают запросы пользователей).
    
    SQLOS имеет монитор планировщика, который постоянно запускается, функция которого предназначена для мониторинга состояния планировщика.
    Он включает в себя несколько функций, таких как обеспечение того, чтобы задания выполнялись через регулярные промежутки времени, 
    так как новые запросы, назначенные процессу, попадают в рабочий поток, гарантируя, что завершение ввода-вывода будет обработано в разумные сроки и рабочие потоки будут сбалансированы среди всех планировщиков.
    
    Монитор планировщика также поддерживает запись о состоянии здоровья с использованием кольцевого буфера, который содержит информацию об использовании процесса и памяти и может быть проверен с помощью sys.dm_os_ring_buffers.
    
Когда рабочий поток получает доступ к планировщику (см. Scheduler and its phases and queues.jpg), он обычно попадает в Waiter List и получает состояние SUSPENDED. 
Waiter List является неупорядоченным списком рабочих потоков, которые имеют состояние SUSPENDED и ждут ресурсов.
Всякий раз, когда рабочий поток получает доступ к необходимым ему ресурсам, он переходит к Runnable Queue и получает состояние RUNNABLE.
Время, затрачиваемое на нахождение в Runnable Queue, называется временем ожидания сигнала.
Первый рабочий поток в Runnable Queue переместится на фазу RUNNING, где он получит процессорное время для выполнения своей работы.

Когда рабочий поток находится на этапе RUNNING, возможны три сценария:
    - Рабочий поток нуждается в дополнительных ресурсах, в этом случае он перейдет от этапа RUNNING в Waiter List.
    - Рабочий поток расходует свой квант (фиксированное значение 4 миллисекунды) и должен уступить. Рабочий поток перемещается в нижнюю часть Runnable Queue.
    - Рабочий поток выполняет свою работу и и покидает планировщик.
    
    