/****** Создание скрипта для настройки репликации. Дата скрипта: 30.04.2018 23:29:01 ******/
/****** Примечание. Из соображений безопасности все параметры паролей были записаны как значения NULL или пустые строки. ******/

/****** Установка сервера в качестве распространителя. Дата: 30.04.2018 23:29:01 ******/
use master
exec sp_adddistributor @distributor = N'WIN-44AACDR0OJ2\INSTANCE01', @password = N''
GO
exec sp_adddistributiondb @database = N'distribution', @data_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL13.INSTANCE01\MSSQL\Data', @log_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL13.INSTANCE01\MSSQL\Data', @log_file_size = 2, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @security_mode = 1
GO

use [distribution] 
if (not exists (select * from sysobjects where name = 'UIProperties' and type = 'U ')) 
	create table UIProperties(id int) 
if (exists (select * from ::fn_listextendedproperty('SnapshotFolder', 'user', 'dbo', 'table', 'UIProperties', null, null))) 
	EXEC sp_updateextendedproperty N'SnapshotFolder', N'C:\Program Files\Microsoft SQL Server\MSSQL13.INSTANCE01\MSSQL\ReplData', 'user', dbo, 'table', 'UIProperties' 
else 
	EXEC sp_addextendedproperty N'SnapshotFolder', N'C:\Program Files\Microsoft SQL Server\MSSQL13.INSTANCE01\MSSQL\ReplData', 'user', dbo, 'table', 'UIProperties'
GO

exec sp_adddistpublisher @publisher = N'WIN-44AACDR0OJ2', @distribution_db = N'distribution', @security_mode = 1, @working_directory = N'C:\Program Files\Microsoft SQL Server\MSSQL13.INSTANCE01\MSSQL\ReplData', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER'
GO
