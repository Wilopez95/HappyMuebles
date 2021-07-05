--CREATE DATABASE TallerMuebleria

use TallerMuebleria

CREATE TABLE Taller(
pkTaller	int  constraint pk_Taller primary key IDENTITY(1,1),
Nombre	    varchar(30),
Ubicacion   geometry constraint nn_ubicacion not null,
Email       varchar(30)
)


CREATE TABLE Empleado(
pkEmpleado		int  constraint pk_Empleado primary key IDENTITY(1,1),
Identificacion	varchar(30) constraint uu_Identificacion unique,
Nombre			varchar(30) constraint nn_Nombre not null,
fkTipoEmpleado  int,
fechaContratacion date,
salario	money,
fkTaller  int
)


CREATE TABLE TipoEmpleado(
pkTipoEmpleado	int  constraint pk_TipoEmpleado primary key IDENTITY(1,1),
Descripcion   	varchar(30) constraint nn_DescEmpleado not null,
)


CREATE TABLE Producto(
pkProducto int  constraint pk_Producto primary key IDENTITY(1,1),
fkTipoProducto	int,
Nombre varchar(250) NOT NULL,
Descripcion varchar(MAX) constraint nn_DescProducto not null,
precio	money
)

CREATE TABLE TipoProducto(
pkTipoProducto	int  constraint pk_TipoProducto primary key IDENTITY(1,1),
Detalle   	    varchar(40) constraint nn_DescTipoProducto not null,
)

CREATE TABLE Stock(
pkStock 	int  constraint pk_Stock primary key IDENTITY(1,1),
fkProducto  int,
Cantidad	int,
fkTaller    int
)

ALTER TABLE Empleado
ADD FOREIGN KEY (fkTipoEmpleado) REFERENCES TipoEmpleado(pkTipoEmpleado);


ALTER TABLE Empleado
ADD FOREIGN KEY (fkTaller) REFERENCES Taller(pkTaller);

ALTER TABLE Producto
ADD FOREIGN KEY (fkTipoProducto) REFERENCES TipoProducto(pkTipoProducto);

ALTER TABLE Stock
ADD FOREIGN KEY (fkProducto) REFERENCES Producto(pkProducto);

ALTER TABLE Stock
ADD FOREIGN KEY (fkTaller) REFERENCES Taller(pkTaller);
 
