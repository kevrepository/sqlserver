select opc1.cntr_value AS [Batch Requests/sec]
      ,opc2.cntr_value AS [SQL Compilations/sec]
      ,CONVERT(decimal(15, 2), (opc1.cntr_value * 1. - opc2.cntr_value * 1.) / opc1.cntr_value * 100) AS plan_reuse_pct
FROM   sys.dm_os_performance_counters AS opc1
       CROSS JOIN sys.dm_os_performance_counters AS opc2
WHERE  opc1.counter_name = N'Batch Requests/sec'
       AND opc2.counter_name = N'SQL Compilations/sec';