USE [master]
GO
EXEC master.dbo.sp_addlinkedserver 
@server = N'MYSQLVINCULADO', 
@srvproduct=N'MySQL', 
@provider=N'MSDASQL', 
@datasrc=N'MysqlVinculado'
 
EXEC master.dbo.sp_addlinkedsrvlogin 
@rmtsrvname=N'MYSQLVINCULADO',
@useself=N'False',
@locallogin=NULL,
@rmtuser=N'root',
@rmtpassword='temporal'
 
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'collation compatible', 
@optvalue=N'false'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'data access', 
@optvalue=N'true'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'dist', 
@optvalue=N'false'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'pub', 
@optvalue=N'false'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'rpc', 
@optvalue=N'true'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'rpc out', 
@optvalue=N'true'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'sub', 
@optvalue=N'false'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'connect timeout', 
@optvalue=N'0'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'collation name', 
@optvalue=null
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'lazy schema validation', 
@optvalue=N'false'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'query timeout', 
@optvalue=N'0'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'use remote collation', 
@optvalue=N'true'
GO
 
EXEC master.dbo.sp_serveroption 
@server=N'MYSQLVINCULADO', 
@optname=N'remote proc transaction promotion', 
@optvalue=N'true'
GO