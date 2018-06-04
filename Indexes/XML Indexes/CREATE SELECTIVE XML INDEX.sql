/*
    CREATE SELECTIVE XML INDEX index_name ON object_name (xml_column_name)  
        [WITH XMLNAMESPACES (<xmlnamespace_list>)]
        FOR (<promoted_node_path_list>)  
        [WITH (<index_options>)]
    [ ; ]

    WITH XMLNAMESPACES (<xmlnamespace_list>)
        Cписок пространств имен, используемых пути для индексирования.

    <promoted_node_path_list> ::= <named_promoted_node_path_item> [, <promoted_node_path_list>]

    <named_promoted_node_path_item> ::= <path_name> = <promoted_node_path_item>  

    <promoted_node_path_item> ::= <xquery_node_path_item> | <sql_values_node_path_item>  

    <xquery_node_path_item> ::= <node_path> [AS XQUERY <xsd_type_or_node_hint>] [SINGLETON]  

    <xsd_type_or_node_hint> ::= [<xsd_type>] [MAXLENGTH(x)] | node()  

    <sql_values_node_path_item> ::= <node_path> AS SQL <sql_type> [SINGLETON]  

    <node_path> ::= character_string_literal  

    <xsd_type> ::= character_string_literal  

    <sql_type> ::= identifier  

    <path_name> ::= identifier  

    <index_options> ::=   
    (   
      | PAD_INDEX  = { ON | OFF }
      | FILLFACTOR = fillfactor
      | SORT_IN_TEMPDB = { ON | OFF }
      | IGNORE_DUP_KEY = OFF
      | DROP_EXISTING = { ON | OFF }
      | ONLINE = OFF
      | ALLOW_ROW_LOCKS = { ON | OFF }
      | ALLOW_PAGE_LOCKS = { ON | OFF }
      | MAXDOP = max_degree_of_parallelism
    )  
*/