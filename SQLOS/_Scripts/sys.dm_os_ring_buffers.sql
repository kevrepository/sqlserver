SELECT timestamp
      ,ring_buffer_address
      ,CONVERT(xml, record) AS record
FROM   sys.dm_os_ring_buffers
WHERE  ring_buffer_type = 'RING_BUFFER_SCHEDULER_MONITOR';