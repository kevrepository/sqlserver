/*
    ALTER DATABASE { database_name  | CURRENT }  
    SET   
    {  
        <recovery_option> [ WITH <termination> ]   
    } 

    <recovery_option> ::=   
    {  
        RECOVERY { FULL | BULK_LOGGED | SIMPLE }   
      | PAGE_VERIFY { CHECKSUM | TORN_PAGE_DETECTION | NONE }  
    } 

    <termination>  ::=   
    {  
        ROLLBACK AFTER integer [ SECONDS ]   
      | ROLLBACK IMMEDIATE   
      | NO_WAIT  
    }  
*/

ALTER DATABASE CURRENT SET RECOVERY FULL WITH NO_WAIT;