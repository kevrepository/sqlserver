/*
    CREATE [ PRIMARY ] XML INDEX index_name   
        ON <object> ( xml_column_name )  
        [ USING XML INDEX xml_index_name   
            [ FOR { VALUE | PATH | PROPERTY } ] ]  
        [ WITH ( <xml_index_option> [ ,...n ] ) ]  
    [ ; ]  
    
    <object> ::=  
    {  
        [ database_name. [ schema_name ] . | schema_name. ] table_name  
    }
    
    <xml_index_option> ::=  
    {   
        PAD_INDEX  = { ON | OFF }  
      | FILLFACTOR = fillfactor  
      | SORT_IN_TEMPDB = { ON | OFF }  
      | IGNORE_DUP_KEY = OFF  
      | DROP_EXISTING = { ON | OFF }  
      | ONLINE = OFF  
      | ALLOW_ROW_LOCKS = { ON | OFF }  
      | ALLOW_PAGE_LOCKS = { ON | OFF }  
      | MAXDOP = max_degree_of_parallelism  
    } 

    FOR { VALUE | PATH | PROPERTY }
        ”казывает тип вторичного XML индекса.

    IX_PXML_
    IX_XMLPATCH_
    IX_XMLVALUE_
    IX_XMLPROPERTY_

    https://docs.microsoft.com/ru-ru/sql/t-sql/statements/create-xml-index-transact-sql
*/