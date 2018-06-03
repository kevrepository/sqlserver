SELECT t.id AS trace_id
      ,t.status AS trace_status
      ,des.session_id
      ,des.host_name
      ,des.program_name
      ,des.login_name
      ,desws.*
FROM   sys.traces AS t
       INNER JOIN sys.dm_exec_sessions AS des
               ON t.reader_spid = des.session_id
       INNER JOIN sys.dm_exec_session_wait_stats AS desws
               ON des.session_id = desws.session_id