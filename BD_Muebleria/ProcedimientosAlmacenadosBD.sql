
-- ----------------FUNCIONES---------------------------------------------
GO
CREATE FUNCTION ObtenerUbicacionSucursal(@NumeroSucursal int)
RETURNS geometry
AS
BEGIN
	DECLARE @areaSucursal geometry;

	SELECT @areaSucursal=S.Ubicacion
	FROM Sucursal S
	WHERE S.NumeroSucursal = @NumeroSucursal

	RETURN @areaSucursal;

END;
GO
-----------------------------------------------------------------------------
GO
CREATE FUNCTION ObtenerUbicacionCliente(@pkCliente int)
RETURNS geometry
AS
BEGIN
	DECLARE @areaCliente geometry;

	SELECT @areaCliente=C.Ubicacion
	FROM Cliente C
	WHERE C.pkCliente = @pkCliente

	RETURN @areaCliente;

END;
GO
-----------------------------------------------------------------------------
GO
CREATE FUNCTION ObtenerPromedioEvaluacion(
@EvaluacionServicio int,
@EvaluacionProducto int,
@EvaluacionEntrega int)
RETURNS decimal(8,2)
AS
BEGIN
	DECLARE @promedio decimal

	select @promedio = (@EvaluacionServicio + @EvaluacionProducto + @EvaluacionEntrega)*10/30

	RETURN @promedio;

END;
GO


-----------------------------------------------------------------------------


---------------------STORE PROCEDURES--------------------------------------------
GO
CREATE PROCEDURE ConsultarTallerMasCercano
	@NumeroSucursal int
AS
BEGIN
	DECLARE @UbicacionSucursal geometry
	DECLARE @CantSucursal int
	DECLARE @Comercio int 

	BEGIN TRY

		SELECT  @CantSucursal=COUNT(*) 
		FROM Sucursal S
		WHERE S.NumeroSucursal = @NumeroSucursal 
	

		IF(@CantSucursal>0)
			BEGIN
				SELECT @UbicacionSucursal = dbo.ObtenerUbicacionSucursal(@NumeroSucursal);
				
				SELECT T.pkTaller,T.Nombre,@UbicacionSucursal.STDistance(T.Ubicacion) AS Distancia
				FROM [TallerMuebleria].dbo.Taller T
				Order by Distancia asc
		

			END
		ELSE
			BEGIN
				raiserror('La sucursal ingresada no existe',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO

----------------------------------------------------------------------------
GO
CREATE PROCEDURE ConsultarSucursalMasCercana
	@pkCliente int
AS
BEGIN
	DECLARE @UbicacionCliente geometry
	DECLARE @CantCliente int

	BEGIN TRY

		SELECT  @CantCliente=COUNT(*) 
		FROM Cliente C
		WHERE c.pkCliente = @pkCliente 
	

		IF(@CantCliente>0)
			BEGIN
				SELECT @UbicacionCliente = dbo.ObtenerUbicacionCliente(@pkCliente);
				
				SELECT S.NumeroSucursal,@UbicacionCliente.STDistance(S.Ubicacion) AS Distancia
				FROM Sucursal S
				Order by Distancia asc
		
			END
		ELSE
			BEGIN
				raiserror('La sucursal ingresada no existe',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ObtenerMuebles
	@pagina int
AS
BEGIN
	DECLARE @LimInferior int 
	DECLARE @CantRegistros int 

	SET @LimInferior = @pagina*10-10
	SET @CantRegistros = 10

	BEGIN TRY

	  SELECT P.pkProducto, P.Nombre, P.fkTipoProducto, P.Descripcion, P.Foto, TP.pkTipoProducto, TP.Detalle
	  FROM Producto P INNER JOIN TipoProducto TP ON P.fkTipoProducto = TP.pkTipoProducto
	  ORDER BY pkProducto ASC OFFSET @LimInferior ROWS FETCH NEXT @CantRegistros ROWS ONLY; 

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ObtenerMueblesCategoria
	@Categoria int
AS
BEGIN
	DECLARE @ValidarCategoria int

	BEGIN TRY

		SELECT  @ValidarCategoria = COUNT(*) 
		FROM TipoProducto TP
		WHERE TP.pkTipoProducto = @Categoria 
	

		IF(@ValidarCategoria>0)
			BEGIN
				SELECT P.Nombre, P.Descripcion,P.Foto,S.Cantidad,S.Cantidad,S.fkSucursal
				FROM Producto P JOIN Stock S ON P.pkProducto = S.fkProducto  
				WHERE P.fkTipoProducto = @Categoria

			END
		ELSE
			BEGIN
				raiserror('La categoria ingresada no existe',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
CREATE PROCEDURE ValidarCliente
	@Email nvarchar(30),
	@CPassword nvarchar(16)
AS
BEGIN
	DECLARE @CantCliente int
	DECLARE @Comercio int 

	BEGIN TRY

		SELECT  @CantCliente=COUNT(*) 
		FROM CuentaCliente C
		WHERE C.Email = @Email AND C.CPassword = @CPassword
	

		IF(@CantCliente>0)
			BEGIN
				SELECT C.pkCliente,C.Nombre
				FROM CuentaCliente Cc JOIN Cliente C ON Cc.fkCliente = C.pkCliente
				WHERE Cc.Email = @Email AND Cc.CPassword = @CPassword
			END
		ELSE
			BEGIN
				raiserror('Los credenciales de cliente son incorrectos o el cliente no se encuentra registrado',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ValidarEmpleado
	@Email nvarchar(30),
	@EPassword nvarchar(16)
AS
BEGIN
	DECLARE @CantEmpleado int
	DECLARE @Comercio int 

	BEGIN TRY

		SELECT  @CantEmpleado=COUNT(*) 
		FROM Empleado E JOIN Cuenta C on E.pkEmpleado =  C.fkEmpleado
		WHERE C.Email = @Email AND C.EPassword = @EPassword
	

		IF(@CantEmpleado>0)
			BEGIN
				SELECT E.pkEmpleado,E.Nombre
				FROM Empleado E JOIN Cuenta C on E.pkEmpleado =  C.fkEmpleado
				WHERE C.Email = @Email AND C.EPassword = @EPassword
			END
		ELSE
			BEGIN
				raiserror('Los credenciales de empleado son incorrectos o el empleado no se encuentra registrado',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE obtenerPerfilCliente
	@idCliente int
AS
BEGIN
	DECLARE @CantCliente int

	BEGIN TRY

		SELECT  @CantCliente=COUNT(*) 
		FROM Cliente C 
		WHERE C.pkCliente = @idCliente 
	

		IF(@CantCliente>0)
			BEGIN
				SELECT  C.pkCliente,Nombre,Ubicacion 
				FROM Cliente C 
				WHERE C.pkCliente = @idCliente 
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
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ObtenerCuponesPorCliente
	@idCliente int
AS
BEGIN
	DECLARE @CantCliente int

	BEGIN TRY

		SELECT  @CantCliente=COUNT(*) 
		FROM Cliente C 
		WHERE C.pkCliente = @idCliente 
	

		IF(@CantCliente>0)
			BEGIN
				SELECT Cl.Nombre,MT.fkCliente,MT.Porcentaje,MT.Descripcion
				FROM OPENQUERY(MYSQLVINCULADO,'SELECT C.fkCliente,Cu.Porcentaje Porcentaje,T.Descripcion FROM centroatencioncliente.cuponxcliente C JOIN centroatencioncliente.tipocupon T ON C.fkCupon=T.pkTipoCupon JOIN centroatencioncliente.cupon Cu ON Cu.pkCupon = C.fkCupon') MT JOIN Cliente Cl ON Cl.pkCliente = MT.fkCliente
				WHERE fkCliente = @idCliente
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

--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarCliente
	@Nombre varchar(40),
	@FechaCumpleannos date,
	@Ubicacion geometry
AS
BEGIN

	BEGIN TRY
		INSERT INTO Cliente(Nombre,FechaCumpleannos,Ubicacion)
		VALUES (@Nombre,@FechaCumpleannos,@Ubicacion)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarCuentaCliente
	@fkCliente int,
	@Email nvarchar(30),
	@CPassword nvarchar(16),
	@RecibirIndo bit
AS
BEGIN

	BEGIN TRY
		INSERT INTO CuentaCliente(fkCliente,Email,CPassword,RecibirInfo)
		VALUES (@fkCliente,@Email,@CPassword,@RecibirIndo)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarPerfilCliente
	@idCliente int,
	@Nombre varchar(40) = NULL,
	@FechaCumpleannos date = NULL,
	@Ubicacion geometry = NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Cliente
		SET Nombre = ISNULL(@Nombre,Nombre),FechaCumpleannos=ISNULL(@FechaCumpleannos,FechaCumpleannos),Ubicacion=ISNULL(@Ubicacion,Ubicacion)
		WHERE pkCliente = @idCliente
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarCuentaCliente
	@idCliente int,
	@Email nvarchar(30) = NULL,
	@CPassword nvarchar(16) = NULL,
	@RecibirInfo bit = NULL
AS
BEGIN

	BEGIN TRY
		UPDATE CuentaCliente
		SET Email=ISNULL(@Email,Email),CPassword=ISNULL(@CPassword,CPassword),RecibirInfo=ISNULL(@RecibirInfo,RecibirInfo)
		WHERE fkCliente = @idCliente
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarEmpleado
	@fkTipoEmpleado int,
	@Nombre varchar(40),
	@FechaContratacion date,
	@Foto nvarchar(max)
AS
BEGIN

	BEGIN TRY
		INSERT INTO Empleado(fkTipoEmpleado,Nombre,FechaContratacion,Foto)
		VALUES (@fkTipoEmpleado,@Nombre,@FechaContratacion,@Foto)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarPerfilEmpleado
	@pkEmpleado int,
	@fkTipoEmpleado int = NULL,
	@Nombre varchar(40) =  NULL,
	@FechaContratacion date = NULL,
	@Foto nvarchar(max) = NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Empleado
		SET fkTipoEmpleado  = ISNULL(@fkTipoEmpleado,fkTipoEmpleado),Nombre=ISNULL(@Nombre,Nombre),FechaContratacion=ISNULL(@FechaContratacion,FechaContratacion)
		WHERE pkEmpleado = @pkEmpleado
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarCuentaEmpleado
	@fkEmpleado int,
	@EPassword nvarchar(16),
	@Email nvarchar(50)
AS
BEGIN

	BEGIN TRY
		INSERT INTO Cuenta(fkEmpleado,EPassword,Email)
		VALUES (@fkEmpleado,@EPassword,@Email)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarCuentaEmpleado
	@pkCuenta int,
	@EPassword nvarchar(16) = NULL,
	@Email nvarchar(50)= NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Cuenta
		SET EPassword = ISNULL(@EPassword,EPassword),Email = ISNULL(@Email,Email) 
		WHERE pkCuenta = @pkCuenta 
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE GenerarCompra
	@idEstadoCompra int
AS
BEGIN
	BEGIN TRY
		INSERT INTO Compra (fkEstadoCompra, FechaCompra) values (@idEstadoCompra, GETDATE());
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE AgregarAListaCompra
	@idProducto int,
	@idCompra int,
	@Cantidad int
AS
BEGIN
	BEGIN TRY
		INSERT INTO ListaCompra(fkProducto, fkCompra, Cantidad) values (@idProducto, @idCompra, @Cantidad);
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE GenerarFactura
	@idMetodoPago int,
	@idCompra int,
	@MontoTotal money
AS
BEGIN
	BEGIN TRY
		INSERT INTO Factura(fkMetodoPago, fkCompra, MontoTotal) values (@idMetodoPago, @idCompra, @MontoTotal);
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE AgregarALineaFactura
	@idFactura int,
	@Detalle nvarchar(50),
	@Monto  nvarchar(50)
AS
BEGIN
	BEGIN TRY
		INSERT INTO LineaFactura(fkFactura, Cantidad, Detalle, Monto) values (@idFactura, 1, @Detalle, @Monto);
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE VerMetodosDePago
AS
BEGIN
	BEGIN TRY
		SELECT MP.Detalle FROM MetodoPago MP
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--EXEC verMetodosDePago
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE VerSucursales
AS
BEGIN
	BEGIN TRY
		SELECT S.NumeroSucursal FROM Sucursal S
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--EXEC verSucursales
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE VerProducto
	@idProducto int
AS
BEGIN
	BEGIN TRY
		SELECT P.pkProducto, P.Nombre, P.Descripcion, P.Foto, P.Precio, TP.pkTipoProducto, TP.Detalle from Producto P
		INNER JOIN TipoProducto TP ON P.fkTipoProducto = TP.pkTipoProducto
		WHERE P.pkProducto = @idProducto
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE VerProductosXTipoProducto
	@idTipoProducto int
AS
BEGIN
	BEGIN TRY
		SELECT P.pkProducto, P.Nombre, P.Descripcion, P.Foto, P.Precio, TP.pkTipoProducto, TP.Detalle from Producto P
		INNER JOIN TipoProducto TP ON P.fkTipoProducto = TP.pkTipoProducto 
		WHERE TP.pkTipoProducto = @idTipoProducto
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE ConfirmarStock
	@idProducto int,
	@idSucursal int,
	@Cantidad int
AS
BEGIN
	BEGIN TRY
		IF @Cantidad > (SELECT St.Cantidad FROM Stock St WHERE St.fkProducto = @idProducto AND St.fkSucursal = @idSucursal)
			BEGIN
				SELECT 0
			END
		ELSE
			BEGIN
				SELECT 1
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE ObtenerProductosRandom
AS
BEGIN
	BEGIN TRY
		SELECT  P.pkProducto, P.Nombre, P.Descripcion, P.Foto, P.Precio, TP.pkTipoProducto, TP.Detalle from Producto P
		INNER JOIN TipoProducto TP ON P.fkTipoProducto = TP.pkTipoProducto
		WHERE pkProducto in 
		(select top 12 pkProducto from Producto order by newid())
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
----------------------------------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarClienteCuenta
	@Nombre varchar(40),
	@FechaCumpleannos date,
	@Ubicacion geometry,
	@Email nvarchar(30),
	@CPassword nvarchar(16),
	@RecibirInfo bit
AS
BEGIN
	DECLARE @fkCliente int 

	BEGIN TRY
		INSERT INTO Cliente(Nombre,FechaCumpleannos,Ubicacion)
		VALUES (@Nombre,@FechaCumpleannos,@Ubicacion)


	  SELECT TOP (1) @fkCliente=C.pkCliente
	  FROM Cliente C
	  order by pkCliente desc

	  INSERT INTO CuentaCliente(fkCliente,Email,CPassword,RecibirInfo)
	  VALUES(@fkCliente,@Email,@CPassword,@RecibirInfo)

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO

----------------------------------------------------------------------------------------
GO
CREATE PROCEDURE EliminarCliente
	@pkCliente int
AS
BEGIN
	DECLARE @CantCliente int

	BEGIN TRY

		SELECT  @CantCliente=COUNT(*) 
		FROM Cliente C 
		WHERE C.pkCliente = @pkCliente 
	

		IF(@CantCliente>0)
			BEGIN
				DELETE FROM Cliente
				WHERE pkCliente = @pkCliente;
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
----------------------------------------------------------------------------------------
GO
CREATE PROCEDURE EliminarCuentaCliente
	@pkCliente int
AS
BEGIN
	DECLARE @CantCliente int

	BEGIN TRY

		SELECT  @CantCliente=COUNT(*) 
		FROM Cliente C 
		WHERE C.pkCliente = @pkCliente 
	

		IF(@CantCliente>0)
			BEGIN
				DELETE FROM CuentaCliente
				WHERE fkCliente = @pkCliente;
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
----------------------------------------------------------------------------------------
GO
CREATE PROCEDURE EliminarEmpleado
	@pkEmpleado int
AS
BEGIN
	DECLARE @CantEmpleado int

	BEGIN TRY

		SELECT  @CantEmpleado=COUNT(*) 
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
----------------------------------------------------------------------------------------
GO
CREATE PROCEDURE EliminarCuentaEmpleado
	@pkEmpleado int
AS
BEGIN
	DECLARE @CantEmpleado int

	BEGIN TRY

		SELECT  @CantEmpleado=COUNT(*) 
		FROM Empleado E 
		WHERE E.pkEmpleado = @pkEmpleado 
	

		IF(@CantEmpleado>0)
			BEGIN
				DELETE FROM Cuenta
				WHERE fkEmpleado = @pkEmpleado;
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

-----------------------------------------------------------------------------
CREATE PROCEDURE getProductoPrice
    @nombre VARCHAR(40)
as 
BEGIN
    Select Producto.Precio from Producto 
    where Producto.Nombre = @nombre
end
go
---------------------------------------------------------------
GO
CREATE PROCEDURE ConsultarCumpleannos
AS
BEGIN
	DECLARE @Date date
	DECLARE @Month varchar(5)
	DECLARE @CantCupones int
	DECLARE @CantEmpleado int
	DECLARE @idCliente int
	DECLARE @idEmpleado int
	DECLARE @randEmpleado int

	SELECT @Date = GETDATE() 
	SELECT @Month = FORMAT(GETDATE(),'MM');


	BEGIN TRY

		DECLARE @Total_Cumples TABLE(id int identity(1,1),pkCliente int,Nombre varchar(40),FechaCumpleanos date,Ubicacion geometry)
		DECLARE @servicio_Cliente TABLE(id int identity(1,1),pkEmpleado int)
		
		INSERT INTO @Total_Cumples
		SELECT Cq.pkCliente,Cq.Nombre,Cq.FechaCumpleannos,Cq.Ubicacion
		FROM Cliente Cq
		WHERE FORMAT(Cq.FechaCumpleannos,'MM') = @Month

		INSERT INTO @servicio_Cliente
		SELECT E.pkEmpleado
		FROM Empleado E
		WHERE E.fkTipoEmpleado = 4

		SELECT @CantEmpleado = COUNT(*)
		FROM @servicio_Cliente
		
		

		SELECT @CantCupones = COUNT(*) 
		FROM @Total_Cumples 


		WHILE(@CantCupones > 0)
		BEGIN
			
			SELECT @idCliente=t.pkCliente
			FROM @Total_Cumples t
			WHERE id = @CantCupones 

			INSERT INTO OPENQUERY(MYSQLVINCULADO,'SELECT fkCliente,fkCupon FROM cuponxcliente')
			VALUES (@idCliente,2)

			SELECT @randEmpleado = FLOOR(RAND()*(1-@CantEmpleado+1))+@CantEmpleado;
			
			SELECT @idEmpleado = s.pkEmpleado
			FROM @servicio_Cliente s
			Where s.id = @randEmpleado 


			INSERT INTO OPENQUERY(MYSQLVINCULADO,'SELECT fkCliente,fkEmpleado,Motivo,FechaLlamada FROM registrollamada') 
			VALUES (@idCliente,@idEmpleado,'Notificar cupon cumpleannos',@Date)

			SELECT @CantCupones = @CantCupones - 1 
		END


	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE ObtenerEmpleadosPorSucursal
	@idSucursal int =  NULL
AS
BEGIN

	BEGIN TRY
		SELECT E.Nombre,S.NumeroSucursal 
		FROM EmpleadoXSucursal Es JOIN Empleado E ON Es.fkEmpleado = E.pkEmpleado JOIN Sucursal S ON Es.fkSucursal = S.pkSucursal  
		WHERE ISNULL(@idSucursal,Es.fkSucursal) = Es.fkSucursal
		order by Es.fkSucursal

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE ObtenerTiposEmpleado
AS
BEGIN

	BEGIN TRY
		SELECT Te.pkTipoEmpleado,Te.Detalle,Te.Salario 
		FROM TipoEmpleado Te

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarTipoEmpleado
	@Detalle nvarchar(30),
	@Salario money
AS
BEGIN

	BEGIN TRY
		INSERT INTO TipoEmpleado(Detalle,Salario)
		VALUES(@Detalle,@Salario)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------
GO
CREATE PROCEDURE VerStockProductosxSucursal
	@idSucursal int
AS
BEGIN

	BEGIN TRY
		SELECT S.fkSucursal Sucursal, P.Nombre, S.Cantidad
		FROM Stock S JOIN Producto P ON S.fkProducto = P.pkProducto 
		WHERE ISNULL (@idSucursal,S.fkSucursal)= S.fkSucursal
		Order by S.fkSucursal
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO

---------------------------------------------------------------
GO
CREATE PROCEDURE RegistrarProducto
	@fkTipoProducto int,
	@Nombre nvarchar(50),
	@Descripcion nvarchar(30),
	@Precio money,
	@Foto nvarchar(max)
AS
BEGIN

	BEGIN TRY
		INSERT INTO Producto (fkTipoProducto,Nombre,Descripcion,Precio,Foto)
		VALUES(@fkTipoProducto,@Nombre,@Descripcion,@Precio,@Foto)
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
	@Precio money = NULL,
	@Foto nvarchar(max) = NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Producto
		SET Nombre  = ISNULL(@Nombre,Nombre),Descripcion=ISNULL(@Descripcion,Descripcion),Precio=ISNULL(@Precio,Precio),Foto = ISNULL(@Foto,Foto)
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
	@fkSucursal int,
	@fkProducto int,
	@Cantidad int
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY

		SELECT @CantActual = S.Cantidad
		FROM Stock S
		WHERE S.fkSucursal = @fkSucursal AND S.fkProducto = @fkProducto

		IF(@CantActual>0)
		BEGIN
			UPDATE Stock 
			SET Cantidad = @CantActual + @Cantidad
			WHERE fkSucursal = @fkSucursal AND fkProducto = @fkProducto 
		END
		ELSE
		BEGIN
			INSERT INTO Stock(fkProducto,fkSucursal,Cantidad)
			VALUES (@fkProducto,@fkSucursal,@Cantidad)
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
	@fkSucursal int,
	@fkProducto int,
	@Cantidad int
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY

		SELECT @CantActual = S.Cantidad
		FROM Stock S
		WHERE S.fkSucursal = @fkSucursal AND S.fkProducto = @fkProducto

		IF(@CantActual>=@Cantidad)
		BEGIN
			UPDATE Stock 
			SET Cantidad = @CantActual - @Cantidad
			WHERE fkSucursal = @fkSucursal AND fkProducto = @fkProducto 
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


--execute ConsultarCumpleannos
--EXEC ObtenerProductosRandom
--------------------------------------------------------------------------------------------------
---Pruebas
--------------------------------------------------------------------------------------------------
--execute ConsultarTallerMasCercano @NumeroSucursal=1;

--execute ConsultarSucursalMasCercana @pkCliente=1;

--execute ValidarCliente @Email='pedro@gmail.com',@CPassword='p2123'

--execute ValidarEmpleado @Email='tlewsy1@theglobeandmail.com',@EPassword='5VFhsxFu'

--execute ObtenerMueblesCategoria @Categoria=5


--execute ObtenerMuebles @pagina=2

--execute ObtenerCuponesPorCliente @idCliente=1


--execute RegistrarCliente @Nombre='Pedro',@FechaCumpleannos='1990-07-12',@Ubicacion='POLYGON((110 -75, 115 -75, 115 -80, 110 -80, 110 -75))';

--execute RegistrarCuentaCliente @fkCliente=11,@Email='pedro@gmail.com',@CPassword='p2123',@RecibirIndo=1