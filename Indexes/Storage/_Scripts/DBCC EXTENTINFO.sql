/*
    DBCC EXTENTINFO ( {database_name | database_id | 0}, {table_name | table_id}, {index_name | index_id | -1}, {partition_id | 0} );

    database_name | database_id | 0
        ��� ���� ������ ��� ������������� ���� ������. ���� ������ �������� 0 ��� �������� �� ����������, ����� �������������� ������� ���� ������.
    table_name | table_id
        ��� ������� ��� ������������� �������.
    index_name | index_id | -1
        ��� ������� ��� ������������� �������. ���� �������� -1, �� ����� ����� �������� ���������� ��� ���� �������� � �������.
    partition_id | 0
        ����������, ����� ������ ������� ������ ������������ �� ������, �������� ������������� �������. ���� �������� 0, �� ����� ����� �������� ���������� ��� ���� �������� �������.

    file_id
        ����� �����, � ������� ��������� ��������.
    page_id
        ����� ��������.
    pg_alloc
        ���������� �������, ���������� ��������� �������.
    ext_size
        ������ ��������.
    object_id
        ������������� ������� ��� �������.
    index_id
        ������������� �������, ��������� � ����� ��� ��������.
    partition_number
        ����� ������� ��� ���� ��� �������.
    partition_id
        ������������� ������� ��� ���� ��� �������.
    iam_chain_type
        ��� IAM-������� ������������. ���������� ����� ���� ������ � ������, ������ LOB � ������ ������������.
    pfs_bytes
        ������ ������, ������� ���������� ���������� ���������� �����, ���� �� ������ ���������, �������� �� �������� ��������� IAM, �������� �� ��� ���������� � �������� �� ��� ������ ��������� �������.

    https://www.safaribooksonline.com/library/view/expert-performance-indexing/9781484211182/9781484211199_Ch02.xhtml#Sec21
*/

DBCC EXTENTINFO ('AdventureWorks2014', 'Person.Address', 'PK_Address_AddressID', 0);