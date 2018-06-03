/*
    SELECT name 
          ,page_verify_option_desc 
    FROM   sys.databases;

    ALTER DATABASE { database_name  | CURRENT }  SET PAGE_VERIFY { CHECKSUM | TORN_PAGE_DETECTION | NONE }

    TORN_PAGE_DETECTION - устаревша€ функци€ SQL Server, она не будет доступна в будущих верси€х.

    »зменение параметра PAGE_VERIFY не вызывает немедленного создани€ CHECKSUM на страницах данных.
    CHECKSUM генерируетс€ только тогда, когда страницы записываютс€ на диск после того, как модифицируютс€.
*/

ALTER DATABASE CURRENT SET PAGE_VERIFY CHECKSUM WITH NO_WAIT;