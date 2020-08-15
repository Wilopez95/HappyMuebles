Use TallerMuebleria;

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

--execute ConsultarGerenteTaller @NumeroTaller = 2;