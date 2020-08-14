
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


-------------------------CRUD EMPLEADO---------------------------------
--execute RegistrarEmpleado @fkTipoEmpleado=1,@Nombre='Juan',@FechaContratacion='2015-02-14',@Foto='https://www.cinconoticias.com/wp-content/uploads/personas-arrogantes.jpg';
--execute RegistrarCuentaEmpleado  @fkEmpleado=21,@Epassword='123',@Email='juan@gmail.com'
--execute ValidarEmpleado @Email='juan@gmail.com',@EPassword='123'
--execute ObtenerEmpleadosPorSucursal @idSucursal=1
--execute ObtenerTiposEmpleado

--execute ActualizarCuentaEmpleado @pkCuenta=1,@Epassword='4567',@Email='efr@gmail.com'
--execute ActualizarPerfilEmpleado @pkEmpleado=1,@fkTipoEmpleado=2,@Nombre='Maria',@FechaContratacion='2000-04-12',@Foto='https://pymstatic.com/5844/conversions/personas-emocionales-social.jpg'

--execute EliminarEmpleado @pkEmpleado=5
--execute EliminarCuentaEmpleado @pkEmpleado=4

--BD/TALLER
--execute ConsultarGerenteTaller @NumeroTaller = 2;




---------------------CRUD TIPO Empleado
--execute RegistrarTipoEmpleado @Detalle='Bodeguero',@Salario=250.25

------------------CRUD Producto
--execute RegistrarProducto @fkTipoProducto=1,@Nombre='Producto',@Descripcion='uso',@Precio=25.23,@Foto = 'https://gollo-prod-grupounicomer.netdna-ssl.com/media/catalog/product/cache/7fab98186e03fe46f2659b9ea1ab996a/4/3/4303040128.jpg'
--execute VerProducto @idProducto=1
--execute VerProductosXTipoProducto @idTipoProducto=2
--execute VerStockProductosxSucursal @idSucursal=1
--execute ActualizarProducto @pkProducto = 5,@Nombre='Mesa de sala',@Precio=8.19,@Foto='https://gollo-prod-grupounicomer.netdna-ssl.com/media/catalog/product/cache/7fab98186e03fe46f2659b9ea1ab996a/1/-/1-az1027_nogal_branco_fi_3.jpg';
--execute ActualizarStockProducto @fkSucursal=1,@fkProducto=2,@Cantidad=4
--execute EliminarProducto @pkProducto=2




--execute ConsultarProductolMasCercano @pkCliente=1,@pkProducto=1,@cantProducto=1


------------------GENERAR COMPRA
--execute GenerarCompraNueva
--execute AgregarAListaCompra @idProducto=1,@idCompra=1
--execute GenerarFactura @idMetodoPago=1,@idCompra=1
--execute ProcesarFacturacion @fkFactura=37
--execute ObtenerCuponesPorCliente @idCliente = 1

--select dbo.ObtenerMontoPorCompra(1)