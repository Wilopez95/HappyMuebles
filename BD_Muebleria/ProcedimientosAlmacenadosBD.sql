
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

	  SELECT pkProducto,fkTipoProducto,Detalle
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
				SELECT P.Detalle,P.Foto,S.Cantidad,S.Cantidad,S.fkSucursal
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
		WHERE E.Email = @Email AND C.Password = @EPassword
	

		IF(@CantEmpleado>0)
			BEGIN
				SELECT E.pkEmpleado,E.Nombre
				FROM Empleado E JOIN Cuenta C on E.pkEmpleado =  C.fkEmpleado
				WHERE E.Email = @Email AND C.Password = @EPassword
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
--execute ConsultarTallerMasCercano @NumeroSucursal=1;

--execute ConsultarSucursalMasCercana @pkCliente=1;

--execute ValidarCliente @Email='ccrock0@blog.com',@CPassword='CM33VN6cSZO'

--execute ValidarEmpleado @Email='dpuve0@gnu.org',@EPassword='t5HeUcdWPo'

--execute ObtenerMueblesCategoria @Categoria=5

execute ObtenerMuebles @pagina=2