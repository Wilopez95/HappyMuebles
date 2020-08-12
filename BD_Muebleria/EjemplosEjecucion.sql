
---------------------CRUD CLIENTE------------------
--execute RegistrarCliente @Nombre='Pedro',@FechaCumpleannos='1990-07-12',@Ubicacion='POLYGON((110 -75, 115 -75, 115 -80, 110 -80, 110 -75))';
--execute RegistrarCuentaCliente @fkCliente=11,@Email='pedro@gmail.com',@CPassword='p2123',@RecibirIndo=1
--execute ValidarCliente @Email='pedro@gmail.com',@CPassword='p2123'
--execute obtenerPerfilCliente @idCliente=11
--execute ActualizarCuentaCliente @idCliente=11,@Email='pedro@gmail.com',@CPassword='1234',@RecibirInfo='1'
--execute ActualizarPerfilCliente @idCliente=11,@Nombre='Pedrito',@FechaCumpleannos='1992-08-25',@Ubicacion='NULL'
--execute EliminarCliente @pkcliente=11
--execute EliminarCuentaCliente @pkCliente=4

---------Perfil del cliente

--DECLARE @UbicacionCliente geometry
--SELECT @UbicacionCliente = dbo.ObtenerUbicacionCliente(1);
--SELECT @UbicacionCliente Ubicacion


--execute ConsultarSucursalMasCercana @pkCliente=1;

--execute ConsultarCumpleannos