
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

	  SELECT pkProducto,fkTipoProducto,Descripcion
	  FROM Producto
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
				SELECT P.Descripcion,P.Foto,S.Cantidad,S.Cantidad,S.fkSucursal
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
		WHERE @pkEmpleado = @pkEmpleado
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
	@fkEmpleado int = NULL,
	@EPassword nvarchar(16) = NULL,
	@Email nvarchar(50)= NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Cuenta
		SET fkEmpleado = ISNULL(@fkEmpleado,fkEmpleado),EPassword = ISNULL(@EPassword,EPassword),Email = ISNULL(@Email,Email) 
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
	@Descripcion nvarchar(50),
	@Monto  nvarchar(50)
AS
BEGIN
	BEGIN TRY
		INSERT INTO LineaFactura(fkFactura, Cantidad, Descripcion, Monto) values (@idFactura, 1, @Descripcion, @Monto);
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
		SELECT P.Nombre, P.Detalle, P.Precio FROM Producto P WHERE P.pkProducto = @idProducto
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
		SELECT P.Descripcion, P.Precio FROM Producto P 
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
--EXEC ObtenerProductosRandom
--------------------------------------------------------------------------------------------------
---Pruebas
--------------------------------------------------------------------------------------------------
--execute ConsultarTallerMasCercano @NumeroSucursal=1;

--execute ConsultarSucursalMasCercana @pkCliente=1;

--execute ValidarCliente @Email='ccrock0@blog.com',@CPassword='CM33VN6cSZO'

--execute ValidarEmpleado @Email='tlewsy1@theglobeandmail.com',@EPassword='5VFhsxFu'

--execute ObtenerMueblesCategoria @Categoria=5


--execute ObtenerMuebles @pagina=2

--execute ObtenerCuponesPorCliente @idCliente=1