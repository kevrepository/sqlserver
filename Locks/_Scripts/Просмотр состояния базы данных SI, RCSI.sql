/*
    snapshot_isolation_state_desc
        OFF
            SI отключен в базе данных.
        IN_TRANSITION_TO_ON
            База данных находится в процессе включения SI.             
        ON
            SI включен в базе данных.
        IN_TRANSITION_TO_OFF
            База данных находится в процессе отключения SI.

    is_read_committed_snapshot_on
        OFF
            RCSI отключено в базе данных.
        ON
            RCSI включен в базе данных.
*/

SELECT database_id
      ,name
      ,snapshot_isolation_state_desc
      ,is_read_committed_snapshot_on
FROM   sys.databases
ORDER  BY database_id;
GO