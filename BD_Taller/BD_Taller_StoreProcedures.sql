Use TallerMuebleria;

GO
CREATE PROCEDURE ConsultarGerenteTaller
	@NumeroTaller int = NULL
AS
BEGIN

	BEGIN TRY
		SELECT E.Identificacion,E.Nombre, T.Nombre
		FROM Empleado E JOIN Taller T ON E.fkTaller = T.pkTaller
		WHERE ISNULL(@NumeroTaller,E.fkTaller) = E.fkTaller AND E.fkTipoEmpleado = 5
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO

--execute ConsultarGerenteTaller;
--execute ConsultarGerenteTaller @NumeroTaller = 2;

GO
CREATE PROCEDURE VerStockProductos
	@NumeroTaller int = NULL
AS
BEGIN
	BEGIN TRY
		SELECT T.pkTaller Taller, P.Nombre, S.Cantidad
		FROM Stock S JOIN Producto P ON S.fkProducto = P.pkProducto 
		INNER JOIN Taller T ON T.pkTaller = S.fkTaller
		WHERE ISNULL (@NumeroTaller, S.fkTaller)= S.fkTaller
		Order by S.fkTaller
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO

--execute VerStockProductos;
--execute VerStockProductos @NumeroTaller = 2;


---------------------------------------------------------------
--------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarProducto
	@fkTipoProducto int,
	@Nombre nvarchar(50),
	@Descripcion nvarchar(30),
	@Precio money
AS
BEGIN
	BEGIN TRY
		INSERT INTO Producto (fkTipoProducto,Nombre,Descripcion,Precio)
		VALUES(@fkTipoProducto,@Nombre,@Descripcion,@Precio)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarProducto
	@pkProducto int,
	@Nombre nvarchar(50) = NULL,
	@Descripcion nvarchar(50) = NULL,
	@Precio money = NULL
AS
BEGIN
	BEGIN TRY
		UPDATE Producto
		SET Nombre  = ISNULL(@Nombre,Nombre),Descripcion=ISNULL(@Descripcion,Descripcion),Precio=ISNULL(@Precio,Precio)
		WHERE pkProducto = @pkProducto
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE EliminarProducto
	@pkProducto int
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY
		DELETE FROM Producto
		WHERE pkProducto = @pkProducto 
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
---------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarStockProducto
	@fkProducto int,
	@fkTaller int,
	@Cantidad int
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY

		SELECT @CantActual = S.Cantidad
		FROM Stock S
		WHERE S.fkTaller = fkTaller AND S.fkProducto = @fkProducto

		IF(@CantActual>0)
		BEGIN
			UPDATE Stock 
			SET Cantidad = @CantActual + @Cantidad
			WHERE fkTaller = @fkTaller AND fkProducto = @fkProducto 
		END
		ELSE
		BEGIN
			INSERT INTO Stock(fkProducto,Cantidad,fkTaller)
			VALUES (@fkProducto,@Cantidad, @fkTaller)
		END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
---------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarStockProductoReducir
	@fkTaller int,
	@fkProducto int,
	@Cantidad int
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY

		SELECT @CantActual = S.Cantidad
		FROM Stock S
		WHERE S.fkTaller = @fkTaller AND S.fkProducto = @fkProducto

		IF(@CantActual>=@Cantidad)
		BEGIN
			UPDATE Stock 
			SET Cantidad = @CantActual - @Cantidad
			WHERE fkTaller = @fkTaller AND fkProducto = @fkProducto 
		END
		ELSE
		BEGIN
			print('Cantidad insuficiente en Stock')
		END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
---------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarEmpleado
	@Identificacion varchar(30),
	@Nombre varchar(40),
	@fkTipoEmpleado int,
	@FechaContratacion date,
	@Salario money,
	@fkTaller int
AS
BEGIN
	BEGIN TRY
		INSERT INTO Empleado (Identificacion, Nombre, fkTipoEmpleado, fechaContratacion, salario, fkTaller)
		VALUES (@Identificacion, @Nombre, @fkTipoEmpleado, @FechaContratacion, @Salario, @fkTaller)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE ObtenerEmpleado
	@pkEmpleado int = NULL
AS
BEGIN
	BEGIN TRY
		SELECT E.pkEmpleado, E.fkTaller, E.fkTipoEmpleado, E.Identificacion, E.Nombre, E.fechaContratacion, E.salario FROM EMPLEADO E
		WHERE E.pkEmpleado = ISNULL(@pkEmpleado, @pkEmpleado)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarPerfilEmpleado
	@pkEmpleado int,
	@Identificacion varchar(30) = NULL,
	@Nombre varchar(40) =  NULL,
	@fkTipoEmpleado int = NULL,
	@FechaContratacion date = NULL,
	@Salario money = NULL,
	@fkTaller int = NULL
AS
BEGIN
	BEGIN TRY
		UPDATE Empleado
		SET Identificacion = ISNULL(@Identificacion, Identificacion), 
		Nombre=ISNULL(@Nombre, Nombre), 
		fkTipoEmpleado = ISNULL(@fkTipoEmpleado,fkTipoEmpleado), 
		FechaContratacion=ISNULL(@FechaContratacion,FechaContratacion),
		Salario = ISNULL(@Salario, Salario),
		fkTaller=ISNULL(@fkTaller, fkTaller)
		WHERE pkEmpleado = @pkEmpleado
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE EliminarEmpleado
	@pkEmpleado int
AS
BEGIN
	DECLARE @CantEmpleado int
	BEGIN TRY
		SELECT @CantEmpleado=COUNT(*) 
		FROM Empleado E 
		WHERE E.pkEmpleado = @pkEmpleado 
		IF(@CantEmpleado>0)
			BEGIN
				DELETE FROM Empleado
				WHERE pkEmpleado = @pkEmpleado;
			END
		ELSE
			BEGIN
				raiserror('El idCliente ingresado no existe en la Base de datos',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
---------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarTipoEmpleado
	@Descripcion nvarchar(30)
AS
BEGIN

	BEGIN TRY
		INSERT INTO TipoEmpleado(Descripcion)
		VALUES(@Descripcion)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE ObtenerTipoEmpleado
AS
BEGIN
	BEGIN TRY
		SELECT Te.pkTipoEmpleado,Te.Descripcion 
		FROM TipoEmpleado Te
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------