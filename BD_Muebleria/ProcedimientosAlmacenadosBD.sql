
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
GO
CREATE FUNCTION ObtenerMontoPorCompra(@pkCompra int)
RETURNS money
AS
BEGIN
	DECLARE @totalCompra money;

	SELECT @totalCompra=SUM(P.Precio * L.Cantidad)
	FROM ListaCompra L JOIN Producto P ON L.fkProducto = P.pkProducto
	WHERE L.fkCompra = @pkCompra 

	RETURN @totalCompra;

END;
GO
-----------------------------------------------------------------------------
GO
CREATE FUNCTION aplicarDescuentoCompra(@totalCompra money,@Porcentaje float)
RETURNS money
AS
BEGIN
	DECLARE @totalGeneral money;

	SELECT @totalGeneral = @totalCompra - (@totalCompra * @Porcentaje) 

	RETURN @totalGeneral;

END;
GO


-----------------------------------------------------------------------------
GO
CREATE FUNCTION transformarMonto(@Monto money)
RETURNS varchar(10)
AS
BEGIN
	DECLARE @dolar varchar(10)
	SET @dolar = '$'
	
	DECLARE @montoConver varchar(10)
	DECLARE @Salida varchar(10)

	SELECT @montoConver=convert(varchar(30),@Monto, 1)

	SELECT @Salida = @dolar+@montoConver 


	RETURN @Salida;

END;
GO

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
CREATE PROCEDURE [dbo].[ObtenerMueblesCategoria]
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

				SELECT  P.pkProducto, P.Nombre, P.Descripcion, P.Foto, P.Precio, TP.pkTipoProducto, TP.Detalle from Producto P
				INNER JOIN TipoProducto TP ON P.fkTipoProducto = TP.pkTipoProducto 
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
CREATE PROCEDURE [dbo].[obtenerPerfilCliente]
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
				SELECT TOP 1 dbo.Cliente.pkCliente, dbo.Cliente.Nombre, dbo.Cliente.FechaCumpleannos, dbo.CuentaCliente.Email, dbo.CuentaCliente.RecibirInfo, dbo.TelefonoXCliente.Numero
				FROM dbo.Cliente LEFT JOIN
                         dbo.CuentaCliente ON dbo.Cliente.pkCliente = dbo.CuentaCliente.fkCliente INNER JOIN
                         dbo.TelefonoXCliente ON dbo.Cliente.pkCliente = dbo.TelefonoXCliente.fkCliente
				WHERE dbo.Cliente.pkCliente = @idCliente 
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
GO
CREATE PROCEDURE ActualizarClienteCuenta
	@idCliente int,
	@Nombre varchar(40) = NULL,
	@FechaCumpleannos date = NULL,
	@Ubicacion geometry = NULL,
	@Email nvarchar(30) = NULL,
	@CPassword nvarchar(16) = NULL,
	@RecibirInfo bit = NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Cliente
		SET Nombre = ISNULL(@Nombre,Nombre),FechaCumpleannos = ISNULL(@FechaCumpleannos,FechaCumpleannos),Ubicacion = ISNULL(@Ubicacion,Ubicacion)
		WHERE pkCliente = @idCliente  

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
	@idEmpleado int,
	@EPassword nvarchar(16) = NULL,
	@Email nvarchar(50)= NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Cuenta
		SET EPassword = ISNULL(@EPassword,EPassword),Email = ISNULL(@Email,Email) 
		WHERE fkEmpleado = @idEmpleado 
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE ActualizarEmpleadoCuenta
	@idEmpleado int,
	@fkTipoEmpleado int = NULL,
	@Nombre varchar(40) = NULL,
	@FechaContratacion date =  NULL,
	@Foto nvarchar(max) = NULL,
	@EPassword nvarchar(16) = NULL,
	@Email nvarchar(50)= NULL
AS
BEGIN

	BEGIN TRY
		UPDATE Empleado
		SET fkTipoEmpleado = ISNULL(@fkTipoEmpleado,fkTipoEmpleado),Nombre=ISNULL(@Nombre,Nombre),FechaContratacion=ISNULL(@FechaContratacion,FechaContratacion),Foto=ISNULL(@Foto,Foto)
		WHERE pkEmpleado = @idEmpleado

		UPDATE Cuenta
		SET EPassword = ISNULL(@EPassword,EPassword),Email = ISNULL(@Email,Email) 
		WHERE fkEmpleado = @idEmpleado 
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE GenerarCompraNueva
AS
BEGIN
	DECLARE @FechaCompra date = GETDATE()
	BEGIN TRY
		INSERT INTO Compra (fkEstadoCompra, FechaCompra) 
		VALUES (1, @FechaCompra);

		SELECT TOP(1) C.pkCompra
		FROM Compra C
		Order by C.pkCompra desc

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
	@idCompra int
AS
BEGIN
	BEGIN TRY
		DECLARE @ExisteLinea int

		SELECT @ExisteLinea = COUNT(*)
		FROM ListaCompra L
		WHERE L.fkCompra = @idCompra AND L.fkProducto = @idProducto

		If (@ExisteLinea>0)
		BEGIN
			UPDATE ListaCompra
			SET Cantidad = Cantidad + 1
			WHERE fkCompra = @idCompra AND fkProducto = @idProducto 
		END
		ELSE
		BEGIN
			INSERT INTO ListaCompra(fkProducto, fkCompra, Cantidad)
			VALUES (@idProducto, @idCompra, 1);
		END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO


--------------------------------------------------------------------------------------------------

CREATE PROCEDURE ProcesarFacturacion
	@fkFactura int
AS
BEGIN
	BEGIN TRY
		DECLARE @idCompra int
		DECLARE @MontoCompra money

		SELECT @idCompra = F.fkCompra
		FROM Factura F
		WHERE F.pkFactura = @fkFactura 

		INSERT INTO LineaFactura(fkFactura,Cantidad,Detalle,Monto)
		SELECT @fkFactura,L.Cantidad, P.Nombre,dbo.transformarMonto(L.Cantidad * P.Precio)
		FROM ListaCompra L JOIN Producto P ON L.fkProducto = P.pkProducto 
		WHERE L.fkCompra = @idCompra 

		SELECT @MontoCompra = dbo.ObtenerMontoPorCompra(@idCompra)

		UPDATE Factura
		SET MontoTotal = @MontoCompra
		WHERE pkFactura = @fkFactura 

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------------------
CREATE PROCEDURE GenerarFactura
	@idMetodoPago int,
	@idCompra int,
	@idSucursal int,
	@idCliente int
AS
BEGIN
	DECLARE @idFactura int 
	BEGIN TRY
		INSERT INTO Factura(fkMetodoPago, fkCompra,fkSucursal,fkCliente,MontoTotal)
		VALUES (@idMetodoPago, @idCompra,@idSucursal,@idCliente,0)

		SELECT TOP(1) @idFactura = F.pkFactura
		FROM Factura F
		WHERE F.fkCompra = @idCompra
		Order by F.pkFactura desc

		execute ProcesarFacturacion @fkFactura = @idFactura

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
-----------------------------AGREAR FACTURAS DE PRUEBA-------------------------------------------
execute GenerarFactura @idMetodoPago=3, @idCompra=1, @idSucursal=1, @idCliente=1
execute GenerarFactura @idMetodoPago=2, @idCompra=2, @idSucursal=2, @idCliente=2
execute GenerarFactura @idMetodoPago=1, @idCompra=3, @idSucursal=3, @idCliente=3
execute GenerarFactura @idMetodoPago=2, @idCompra=4, @idSucursal=3, @idCliente=4
execute GenerarFactura @idMetodoPago=2, @idCompra=5, @idSucursal=1, @idCliente=5
execute GenerarFactura @idMetodoPago=3, @idCompra=6, @idSucursal=2, @idCliente=6
execute GenerarFactura @idMetodoPago=1, @idCompra=7, @idSucursal=3, @idCliente=7
execute GenerarFactura @idMetodoPago=3, @idCompra=8, @idSucursal=1, @idCliente=8
execute GenerarFactura @idMetodoPago=3, @idCompra=9, @idSucursal=1, @idCliente=9
execute GenerarFactura @idMetodoPago=1, @idCompra=10, @idSucursal=2, @idCliente=10
execute GenerarFactura @idMetodoPago=2, @idCompra=11, @idSucursal=3, @idCliente= 1
execute GenerarFactura @idMetodoPago=2, @idCompra=12, @idSucursal=2, @idCliente= 2
execute GenerarFactura @idMetodoPago=2, @idCompra=13, @idSucursal=1, @idCliente= 3
execute GenerarFactura @idMetodoPago=2, @idCompra=14, @idSucursal=2, @idCliente= 4
execute GenerarFactura @idMetodoPago=3, @idCompra=15, @idSucursal=3, @idCliente= 5
execute GenerarFactura @idMetodoPago=2, @idCompra=16, @idSucursal=2, @idCliente= 6
execute GenerarFactura @idMetodoPago=3, @idCompra=17, @idSucursal=1, @idCliente= 7
execute GenerarFactura @idMetodoPago=1, @idCompra=18, @idSucursal=2, @idCliente= 8
execute GenerarFactura @idMetodoPago=1, @idCompra=19, @idSucursal=3, @idCliente= 9
execute GenerarFactura @idMetodoPago=2, @idCompra=20, @idSucursal=3, @idCliente= 10
execute GenerarFactura @idMetodoPago=1, @idCompra=21, @idSucursal=1, @idCliente= 1
execute GenerarFactura @idMetodoPago=2, @idCompra=22, @idSucursal=2, @idCliente= 2
execute GenerarFactura @idMetodoPago=3, @idCompra=23, @idSucursal=3, @idCliente= 3
execute GenerarFactura @idMetodoPago=1, @idCompra=24, @idSucursal=2, @idCliente= 4
execute GenerarFactura @idMetodoPago=3, @idCompra=25, @idSucursal=1, @idCliente= 5
execute GenerarFactura @idMetodoPago=3, @idCompra=26, @idSucursal=2, @idCliente= 6
execute GenerarFactura @idMetodoPago=1, @idCompra=27, @idSucursal=3, @idCliente= 7
execute GenerarFactura @idMetodoPago=3, @idCompra=28, @idSucursal=2, @idCliente= 8
execute GenerarFactura @idMetodoPago=1, @idCompra=29, @idSucursal=1, @idCliente= 9
execute GenerarFactura @idMetodoPago=2, @idCompra=30, @idSucursal=2, @idCliente= 10
execute GenerarFactura @idMetodoPago=3, @idCompra=31, @idSucursal=3, @idCliente= 1
execute GenerarFactura @idMetodoPago=3, @idCompra=32, @idSucursal=1, @idCliente= 2
execute GenerarFactura @idMetodoPago=1, @idCompra=33, @idSucursal=1, @idCliente= 3
execute GenerarFactura @idMetodoPago=3, @idCompra=34, @idSucursal=2, @idCliente= 4
execute GenerarFactura @idMetodoPago=1, @idCompra=35, @idSucursal=3, @idCliente= 5
GO
--------------------------------------------------------------------------------------------------
CREATE PROCEDURE AgregarALineaFactura
	@idFactura int,
	@Cantidad int,
	@Detalle nvarchar(50),
	@Monto  nvarchar(50)
AS
BEGIN
	BEGIN TRY
		DECLARE @MontoConver varchar(10)
		DECLARE @MontoObtenido money

		INSERT INTO LineaFactura(fkFactura, Cantidad, Detalle, Monto)
		VALUES (@idFactura, @Cantidad, @Detalle, @Monto);

		SELECT TOP(1)@MontoConver = value FROM STRING_SPLIT(@monto, '$') order by value desc;
		SELECT @MontoObtenido=CONVERT(money,@MontoConver)

		UPDATE Factura
		SET MontoTotal = MontoTotal + @MontoObtenido
		WHERE pkFactura = @idFactura 

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
    Select Producto.Precio, Producto.pkProducto from Producto 
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

----------------------------------------------------------------------------
GO
CREATE PROCEDURE ConsultarProductolMasCercano
	@pkCliente int,
	@pkProducto int,
	@cantProducto int
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
				FROM Sucursal S JOIN Stock Sk ON S.pkSucursal = Sk.fkSucursal 
				WHERE Sk.fkProducto = @pkProducto AND Sk.Cantidad >= @cantProducto 
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

---------------------------------------------------------------------------
CREATE PROCEDURE AgregarEvaluacionCompra
	@fkCompra int,
	@EvaluacionServicio int,
	@EvaluacionProducto int,
	@EvaluacionEntrega int,
	@Comentario nvarchar =  NULL
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY
		INSERT INTO EvaluacionCompra(fkCompra,EvaluacionServicio,EvaluacionProducto,EvaluacionEntrega,Comentario)
		VALUES (@fkCompra,@EvaluacionServicio,@EvaluacionProducto,@EvaluacionEntrega,@Comentario)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------------------
CREATE PROCEDURE AgregarMetodoPago
	@Detalle nvarchar(50)
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY
		INSERT INTO MetodoPago(Detalle)
		VALUES (@Detalle)
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------------------
CREATE PROCEDURE ActualizarMetodoPago
	@pkMetodoPago int,
	@Detalle nvarchar(50)
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY
		UPDATE MetodoPago
		SET Detalle = @Detalle
		WHERE pkMetodoPago = @pkMetodoPago
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------------------------
CREATE PROCEDURE EliminarMetodoPago
	@pkMetodoPago int
AS
BEGIN
	DECLARE @CantActual int
	BEGIN TRY
		DELETE MetodoPago
		WHERE pkMetodoPago = @pkMetodoPago 

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------
CREATE PROCEDURE RegistrarEmpleadoCuenta
	@fkTipoEmpleado int,
	@Nombre varchar(40),
	@FechaContratacion date,
	@Foto nvarchar(max),
	@EPassword nvarchar(16),
	@Email nvarchar(50)

AS
BEGIN
	DECLARE @fkEmpleado int
	
	BEGIN TRY
		
		INSERT INTO Empleado(fkTipoEmpleado,Nombre,FechaContratacion,Foto)
		VALUES (@fkEmpleado,@Nombre,@FechaContratacion,@Foto)

		
		 SELECT TOP (1) @fkEmpleado = E.pkEmpleado
		 FROM Empleado E
		 order by pkEmpleado desc

		 INSERT INTO Cuenta(fkEmpleado,EPassword,Email)
		VALUES(@fkEmpleado,@EPassword,@Email)

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------
CREATE PROCEDURE ObtenerHistorialCompra
	@fkMetodoPago int = NULL,
	@fkSucursal int =  NULL,
	@fkCliente int = NULL

AS
BEGIN
	
	BEGIN TRY
		SELECT C.pkCompra,C.FechaCompra, S.NombreSucursal, Cl.Nombre NombreCliente,Mp.Detalle MetodoPago
		FROM Factura F JOIN MetodoPago Mp ON F.fkMetodoPago = Mp.pkMetodoPago
		JOIN Compra C ON F.fkCompra = C.pkCompra
		JOIN Sucursal S ON F.fkSucursal = S.pkSucursal
		JOIN Cliente Cl ON F.fkCliente = Cl.pkCliente
		WHERE ISNULL(@fkMetodoPago,Mp.pkMetodoPago) = Mp.pkMetodoPago AND ISNULL(@fkSucursal,S.pkSucursal) = S.pkSucursal AND ISNULL(@fkCliente,Cl.pkCliente) = Cl.pkCliente

	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
--------------------------------------------------
CREATE PROCEDURE ObtenerListaCompra
	@idCompra int = NULL

AS
BEGIN
	
	BEGIN TRY
		SELECT P.Nombre,L.Cantidad
		FROM ListaCompra L JOIN Producto P ON L.fkProducto = P.pkProducto
		WHERE L.fkCompra = @idCompra 
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
---------------------------------------------------------
CREATE PROCEDURE ObtenerDetalleFactura
	@idFactura int = NULL

AS
BEGIN
	
	BEGIN TRY
		SELECT L.Cantidad,L.Detalle,L.Monto
		FROM LineaFactura L
		WHERE L.fkFactura = @idFactura 
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO
----------------------------------------------------------
CREATE PROCEDURE obtenerPerfilEmpleado
	@idEmpleado int
AS
BEGIN
	DECLARE @CantEmpleado int

	BEGIN TRY

		SELECT  @CantEmpleado=COUNT(*) 
		FROM Empleado E
		WHERE E.pkEmpleado = @idEmpleado 
	

		IF(@CantEmpleado>0)
			BEGIN
				SELECT  E.pkEmpleado,E.Nombre, T.Detalle TipoEmpleado,E.FechaContratacion,E.Foto
				FROM Empleado E JOIN TipoEmpleado  T ON E.fkTipoEmpleado = T.pkTipoEmpleado
				WHERE E.pkEmpleado = @idEmpleado 
			END
		ELSE
			BEGIN
				raiserror('El idEmpleado ingresado no existe en la Base de datos',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END






