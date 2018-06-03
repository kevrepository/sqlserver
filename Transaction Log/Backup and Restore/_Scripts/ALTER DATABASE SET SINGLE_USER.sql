/*
    ALTER DATABASE { database_name  | CURRENT }  
    SET   
    {  
        <db_user_access_option> [ WITH <termination> ]   
    } 

	<db_user_access_option> ::=  
		{ SINGLE_USER | RESTRICTED_USER | MULTI_USER }  
	
    <termination>  ::=   
    {  
        ROLLBACK AFTER integer [ SECONDS ]   
      | ROLLBACK IMMEDIATE   
      | NO_WAIT  
    }  
*/

ALTER DATABASE CURRENT SET SINGLE_USER WITH NO_WAIT;