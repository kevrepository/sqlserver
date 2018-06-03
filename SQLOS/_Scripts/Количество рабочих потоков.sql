-- Максимальное количество рабочих потоков.
SELECT max_workers_count
FROM   sys.dm_os_sys_info;
GO
-- Количество рабочих потоков, которые активны в данный момент времени.
SELECT scheduler_id
      ,cpu_id
      ,scheduler_address
      ,status
      ,SUM(current_workers_count) AS current_workers_count
      ,SUM(active_workers_count) AS active_workers_count
      ,work_queue_count
FROM   sys.dm_os_schedulers
WHERE  scheduler_id < 1048576
GROUP  BY GROUPING SETS
       (
           ()
          ,(scheduler_id, cpu_id, scheduler_address, status, current_workers_count, active_workers_count, work_queue_count)
       );
GO