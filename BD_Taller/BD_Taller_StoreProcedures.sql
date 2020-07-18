Use TallerMuebleria

GO
CREATE PROCEDURE ConsultarGerenteTaller
	@NumeroTaller int
AS
BEGIN
	DECLARE @UbicacionSucursal geometry
	DECLARE @CantTaller int
	DECLARE @Comercio int 

	BEGIN TRY

		SELECT  @CantTaller=COUNT(*) 
		FROM Taller T
		WHERE T.pkTaller = @NumeroTaller
	

		IF(@CantTaller>0)
			BEGIN
				SELECT E.Identificacion,E.Nombre
				FROM Empleado E
				WHERE E.fkTaller = @NumeroTaller AND E.fkTipoEmpleado = 5

			END
		ELSE
			BEGIN
				raiserror('El taller ingresado no existe',1,1)
			END
	END TRY
	BEGIN CATCH
		raiserror('Ocurrio un error ejecutando',1,1)
	END CATCH
	RETURN
END
GO


--execute ConsultarGerenteTaller @NumeroTaller=1;