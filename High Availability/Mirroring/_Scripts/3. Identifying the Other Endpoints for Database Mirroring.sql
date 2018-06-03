-- Mirror Server Database: principal server endpoint.
ALTER DATABASE database_name
    SET PARTNER = 'partner_server'; -- TCP://<system-address>:<port>

GO

-- Principal Server Database: mirror server endpoint.
ALTER DATABASE database_name
    SET PARTNER = 'partner_server'; -- TCP://<system-address>:<port>

GO

-- Principal Server Database: witness server endpoint.
ALTER DATABASE database_name
    SET WITNESS = 'partner_server'; -- TCP://<system-address>:<port>

GO