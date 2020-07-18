
INSERT INTO TipoCupon(Descripcion)
VALUES ('Cupon por cliente frecuente');

INSERT INTO TipoCupon(Descripcion)
VALUES ('Cupon por cumpleaños');

INSERT INTO TipoCupon(Descripcion)
VALUES ('Cupon por primera compra');

INSERT INTO TipoCupon(Descripcion)
VALUES ('Cupon por fin de mes');


INSERT INTO Cupon(fkTipoCupon, Porcentaje, FechaEmi, FechaVen)
 VALUES (3, 0.25,'2020-07-07','2020-08-07');
 
 INSERT INTO Cupon(fkTipoCupon, Porcentaje, FechaEmi, FechaVen)
 VALUES (2, 0.30,'2020-07-07','2020-09-07');
 
 INSERT INTO Cupon(fkTipoCupon, Porcentaje, FechaEmi, FechaVen)
 VALUES (1, 0.45,'2020-07-07','2020-09-07');
 
 INSERT INTO Cupon(fkTipoCupon, Porcentaje, FechaEmi, FechaVen)
 VALUES (4, 0.10,'2020-06-07','2020-06-30');
 
 INSERT INTO Cupon(fkTipoCupon, Porcentaje, FechaEmi, FechaVen)
 VALUES (3, 0.25,'2020-07-07','2020-10-07');
 
 
INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (1,1);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (1,2);

INSERT INTO CuponXcliente(fkCliente,fkCupon)
VALUES (2,3);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (5,3);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (6,2);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (8,1);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (9,2);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (3,4);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (4,5);

INSERT INTO CuponXcliente(fkCliente, fkCupon)
VALUES (6,4);

INSERT INTO RegistroLlamada(fkCliente, fkEmpleado, Motivo, FechaLlamada)
VALUES (1,1,'Cotizacion','2020-07-07');

INSERT INTO RegistroLlamada(fkCliente, fkEmpleado, Motivo, FechaLlamada)
VALUES (5,8,'Consulta de horario','2020-07-07');

INSERT INTO RegistroLlamada(fkCliente, fkEmpleado, Motivo, FechaLlamada)
VALUES (4,3,'Consulta tecnica','2020-06-04');

INSERT INTO RegistroLlamada(fkCliente, fkEmpleado, Motivo, FechaLlamada)
VALUES (5,10,'Cotizacion','2020-04-02');

INSERT INTO RegistroLlamada(fkCliente, fkEmpleado, Motivo, FechaLlamada)
VALUES (6,7,'Solicitar cambio de mueble','2020-03-15');

INSERT INTO RegistroLlamada(fkCliente, fkEmpleado, Motivo, FechaLlamada)
VALUES (7,3,'Consulta de horarios en feriado','2020-04-02');

INSERT INTO RegistroLlamada(fkCliente, fkEmpleado, Motivo, FechaLlamada)
VALUES (10,12,'Cotizacion','2020-04-02');
