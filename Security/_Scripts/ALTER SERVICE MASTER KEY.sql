/*
    ALTER SERVICE MASTER KEY   
        [ { <regenerate_option> | <recover_option> } ] [;]  
    
    <regenerate_option> ::=  
        [ FORCE ] REGENERATE  

    FORCE
        ”казывает, что главный ключ службы должен быть принудительно создан повторно, даже если это может привести к потере данных.
    REGENERATE
        ”казывает, что главный ключ службы должен быть создан повторно.
*/