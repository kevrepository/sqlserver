SELECT checkpoint_file_id
      ,checkpoint_pair_file_id 
      ,file_type_desc
      ,internal_storage_slot
      ,file_size_in_bytes
      ,file_size_used_in_bytes
      ,logical_row_count
      ,state_desc
FROM   sys.dm_db_xtp_checkpoint_files
order  by internal_storage_slot, file_type_desc;