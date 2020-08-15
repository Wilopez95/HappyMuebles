--CREATE DATABASE DBII_Muebleria 
USE DBII_Muebleria;
GO

Alter Database DBII_Muebleria
add filegroup SECUNDARY

Alter Database DBII_Muebleria
add filegroup TERCEARY

Alter Database DBII_Muebleria
add file
(name=DDII_SucursalB,filename='C:\DB\SucursalB\DBII_SucursalB.mdf',
	SIZE=8 MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH =64 MB) TO FILEGROUP SECUNDARY

Alter Database DBII_Muebleria
add file
(name=DDII_SucursalC,filename='C:\DB\SucursalC\DBII_SucursalC.mdf',
	SIZE=8 MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH =64 MB) TO FILEGROUP TERCEARY

--Definimos la funcion de particion
CREATE PARTITION FUNCTION Particion_Sucursal (int)
AS RANGE LEFT FOR VALUES (1,2);

--Creamos un esquema para la funcion de particion
CREATE PARTITION SCHEME EsquemaParticion 
AS PARTITION Particion_Sucursal TO
([PRIMARY], SECUNDARY, TERCEARY)

CREATE TABLE TipoProducto(
	pkTipoProducto int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Detalle nvarchar(30) NOT NULL
);

CREATE TABLE Producto(
	pkProducto int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkTipoProducto int NOT NULL FOREIGN KEY REFERENCES TipoProducto(pkTipoProducto) ON DELETE CASCADE,
	Nombre nvarchar(50) NOT NULL,
	Descripcion nvarchar(30) NOT NULL,
	Precio money NOT NULL,
	Foto nvarchar(Max)
);

CREATE TABLE Sucursal(
	pkSucursal int NOT NULL PRIMARY KEY IDENTITY(1,1),
	NumeroSucursal int,
	NombreSucursal varchar(15),
	Ubicacion geometry NOT NULL
);

CREATE TABLE TelefonoXSucursal(
	pkTelefonoXSucursal int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkSucursal int NOT NULL FOREIGN KEY REFERENCES Sucursal(pkSucursal) ON DELETE CASCADE, 
	Numero varchar(30) NOT NULL,
	Detalle nvarchar(30) NOT NULL
);


CREATE TABLE Stock(
	pkStock int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkProducto int NOT NULL FOREIGN KEY REFERENCES Producto(pkProducto) ON DELETE CASCADE,
	fkSucursal int NOT NULL FOREIGN KEY REFERENCES Sucursal(pkSucursal) ON DELETE CASCADE,
	Cantidad int NOT NULL
);

CREATE TABLE TipoEmpleado(
	pkTipoEmpleado int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Detalle nvarchar(30) NOT NULL,
	Salario money
);

CREATE TABLE Empleado(
	pkEmpleado int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkTipoEmpleado int NOT NULL FOREIGN KEY REFERENCES TipoEmpleado(pkTipoEmpleado) ON DELETE CASCADE,
	Nombre varchar(40) NOT NULL,
	FechaContratacion date NOT NULL,
	Foto nvarchar(Max),
); 

CREATE TABLE Cuenta(
	pkCuenta int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkEmpleado int NOT NULL FOREIGN KEY REFERENCES Empleado(pkEmpleado) ON DELETE CASCADE,
	EPassword nvarchar(16),
	Email nvarchar(50)
); 

CREATE TABLE EmpleadoXSucursal(
	pkEmpleadoXSucursal int NOT NULL,
	fkEmpleado int NOT NULL FOREIGN KEY REFERENCES Empleado(pkEmpleado) ON DELETE CASCADE,
	fkSucursal int NOT NULL FOREIGN KEY REFERENCES Sucursal(pkSucursal) ON DELETE CASCADE,
) ON EsquemaParticion (fkSucursal);

CREATE TABLE Cliente(
	pkCliente int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre varchar(40),
	FechaCumpleannos date NOT NULL,
	Ubicacion geometry NOT NULL
);

CREATE TABLE TelefonoXCliente(
	pkTelefonoXCliente int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkCliente int NOT NULL FOREIGN KEY REFERENCES Cliente(pkCliente) ON DELETE CASCADE,
	Numero varchar(30) NOT NULL,
	Detalle nvarchar(30) NOT NULL
);

CREATE TABLE CuentaCliente(
	pkCuentaCliente int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkCliente int NOT NULL FOREIGN KEY REFERENCES Cliente(pkCliente) ON DELETE CASCADE,
	Email nvarchar(30) NOT NULL,
	CPassword nvarchar(16),
	RecibirInfo bit
);

CREATE TABLE MetodoPago(
	pkMetodoPago int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Detalle nvarchar(50) NOT NULL
)

CREATE TABLE EstadoCompra(
	pkEstadoCompra int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Detalle nvarchar(30) NOT NULL
);

CREATE TABLE Compra(
	pkCompra int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkEstadoCompra int NOT NULL FOREIGN KEY REFERENCES EstadoCompra(pkEstadoCompra) ON DELETE CASCADE,
	FechaCompra date NOT NULL
);

CREATE TABLE Factura(
	pkFactura int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkMetodoPago int NOT NULL FOREIGN KEY REFERENCES MetodoPago(pkMetodoPago) ON DELETE CASCADE,
	fkCompra int NOT NULL FOREIGN KEY REFERENCES Compra(pkCompra) ON DELETE CASCADE,
	fkSucursal int NOT NULL FOREIGN KEY REFERENCES Sucursal(pkSucursal) ON DELETE CASCADE,
	fkCliente int NOT NULL FOREIGN KEY REFERENCES Cliente(pkCliente) ON DELETE CASCADE, 
	MontoTotal money NOT NULL
)

CREATE TABLE LineaFactura(
	pkLineaFactura int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkFactura int NOT NULL FOREIGN KEY REFERENCES Factura(pkFactura) ON DELETE CASCADE,
	Cantidad int NOT NULL,
	Detalle nvarchar(50) NOT NULL,
	Monto nvarchar(50) NOT NULL
)

CREATE TABLE ListaCompra(
	pkListaCompra int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkProducto int NOT NULL FOREIGN KEY REFERENCES Producto(pkProducto) ON DELETE CASCADE,
    fkCompra int NOT NULL FOREIGN KEY REFERENCES Compra(pkCompra) ON DELETE CASCADE,
	Cantidad int NOT NULL
)

CREATE TABLE EvaluacionCompra(
	pkEvaluacionCompra int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkCompra int NOT NULL FOREIGN KEY REFERENCES Compra(pkCompra) ON DELETE CASCADE,
	EvaluacionServicio int NOT NULL,
	EvaluacionProducto int NOT NULL,
	EvaluacionEntrega int NOT NULL,
	Comentario nvarchar(max) NOT NULL
);

CREATE TABLE ComisionXCompra(
	pkComisionxCompra int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkEmpleado int NOT NULL FOREIGN KEY REFERENCES Empleado(pkEmpleado) ON DELETE CASCADE,
	fkCompra int NOT NULL FOREIGN KEY REFERENCES Compra(pkCompra) ON DELETE CASCADE,
	Comision int NOT NULL
);

CREATE TABLE Entrega(
	pkEntrega int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fkSucursal int NOT NULL FOREIGN KEY REFERENCES Sucursal(pkSucursal),
	fkCompra int NOT NULL FOREIGN KEY REFERENCES Compra(pkCompra) ON DELETE CASCADE,
	fkCliente int NOT NULL FOREIGN KEY REFERENCES Cliente(pkCliente) ON DELETE CASCADE,
	Monto money NOT NULL
);