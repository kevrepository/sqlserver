/*
    BACKUP DATABASE { database_name | @database_name_var }
     <file_or_filegroup> [ ,...n ]
      TO <backup_device> [ ,...n ]
      [ <MIRROR TO clause> ] [ next-mirror-to ]
      [ WITH { DIFFERENTIAL | <general_WITH_options> [ ,...n ] } ]
    [;]

    <file_or_filegroup>::=  
    {  
      FILE = { logical_file_name | @logical_file_name_var }   
    | FILEGROUP = { logical_filegroup_name | @logical_filegroup_name_var }  
    }   
*/