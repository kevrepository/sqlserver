/*
    BACKUP DATABASE { database_name | @database_name_var }
     READ_WRITE_FILEGROUPS [ , <read_only_filegroup> [ ,...n ] ]
      TO <backup_device> [ ,...n ]
      [ <MIRROR TO clause> ] [ next-mirror-to ]
      [ WITH { DIFFERENTIAL | <general_WITH_options> [ ,...n ] } ]
    [;]

    <read_only_filegroup>::=  
     FILEGROUP = { logical_filegroup_name | @logical_filegroup_name_var }
*/