/*
    runnable_tasks_count
        ѕоказывает количество рабочих потоков в очереди выполнени€ дл€ конкретного планировщика.
    quant_length_us
        ѕоказывает квант, используемый планировщиком, который обычно составл€ет четыре миллисекунды.
*/

SELECT scheduler_id
      ,parent_node_id
      ,cpu_id
      ,is_online
      ,is_idle
      ,status
      ,runnable_tasks_count
      ,quant_length_us

FROM   sys.dm_os_schedulers;