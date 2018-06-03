-- Количество физических процессоров.
SELECT cpu_count AS logical_cpu
      ,cpu_count / hyperthread_ratio AS physical_cpu
FROM   sys.dm_os_sys_info;
GO

-- Переменная ms_ticks содержит количество миллисекунд с момента последнего запуска компьютера.
SELECT DATEADD(SECOND, - (ms_ticks / 1000), SYSDATETIME()) AS computer_last_start
FROM   sys.dm_os_sys_info;
GO