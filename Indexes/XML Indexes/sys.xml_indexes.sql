SELECT OBJECT_SCHEMA_NAME(object_id) + '.' + OBJECT_NAME(object_id) AS object_name
      ,name
      ,type_desc
      ,is_unique
      ,data_space_id
      ,ignore_dup_key
      ,is_primary_key
      ,is_unique_constraint
      ,fill_factor
      ,is_padded
      ,is_disabled
      ,is_hypothetical
      ,allow_row_locks
      ,allow_page_locks
      ,using_xml_index_id
      ,secondary_type
      ,secondary_type_desc
      ,has_filter
      ,filter_definition
      ,xml_index_type
      ,xml_index_type_description
      ,path_id
FROM   sys.xml_indexes;