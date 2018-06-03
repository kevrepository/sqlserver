SELECT des.session_id
      ,des.open_transaction_count
      ,dtst.transaction_id
      ,dtst.enlist_count
      ,dtst.is_local
      ,dtst.is_enlisted
      ,dtst.is_bound
      ,dtasdt.transaction_sequence_num
      ,dtasdt.commit_sequence_num
      ,dtasdt.is_snapshot
      ,dtasdt.first_snapshot_sequence_num
      ,dtasdt.max_version_chain_traversed
      ,dtasdt.average_version_chain_traversed
      ,dtasdt.elapsed_time_seconds
FROM   sys.dm_exec_sessions AS des
       LEFT JOIN sys.dm_tran_session_transactions AS dtst
              ON des.session_id = dtst.session_id
       LEFT JOIN sys.dm_tran_active_snapshot_database_transactions AS dtasdt
              ON dtst.transaction_id = dtasdt.transaction_id
       LEFT JOIN sys.dm_exec_requests AS der
              ON des.session_id = der.session_id      
WHERE  des.is_user_process = 1;
GO