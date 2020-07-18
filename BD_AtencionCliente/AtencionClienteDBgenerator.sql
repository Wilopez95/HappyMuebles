CREATE DATABASE IF NOT EXISTS  CentroAtencionCliente;

CREATE TABLE TipoCupon(
   pkTipoCupon int primary key auto_increment not NULL,
   Descripcion varchar(30)
);
CREATE TABLE Cupon(
	pkCupon int primary key auto_increment not NULL,
    fkTipoCupon int,
    Porcentaje float,
    FechaEmi date,
    FechaVen date,
    FOREIGN KEY (fkTipoCupon) REFERENCES TipoCupon(pkTipoCupon)
);

CREATE TABLE CuponXcliente(
	pkCuponxCliente int primary key auto_increment not null,
    fkCliente int,
    fkCupon int,
	FOREIGN KEY (fkCupon) REFERENCES Cupon(pkCupon)
);
CREATE TABLE RegistroLLamada(
	pkRegistroLLamada int primary key auto_increment not null,
    fkCliente int,
    fkEmpleado int,
    Motivo varchar(250),
    FechaLlamada date
);
