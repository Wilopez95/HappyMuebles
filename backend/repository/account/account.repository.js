var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function AccountRepository(dbContext){

    function loginAccount(req,res){
        var parameters = [];
        if(req.body.email.includes("Admin/")||req.body.email.includes("admin/")){
            parameters.push({ name: 'Email', type: TYPES.VarChar, val: req.body.email.substr(6) });
            parameters.push({ name: 'EPassword', type: TYPES.VarChar, val: req.body.pass });

            dbContext.post("ValidarEmpleado", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });

        }else{
            parameters.push({ name: 'Email', type: TYPES.VarChar, val: req.body.email });
            parameters.push({ name: 'CPassword', type: TYPES.VarChar, val: req.body.pass });

            dbContext.post("ValidarCliente", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
        }
    }

    function registerAccountEmpleado(req,res){
        var parameters = [];
        parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email});
        parameters.push({ name: 'EPassword', type: TYPES.NVarChar, val: req.body.password });
        parameters.push({ name: 'fkTipoEmpleado', type: TYPES.Int, val: req.body.tipoEmpleado});
        parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
        parameters.push({ name: 'FechaContratacion', type: TYPES.Date, val: req.body.date});
        parameters.push({ name: 'Foto', type: TYPES.NVarChar, val: req.body.photo});

        dbContext.post("RegistrarEmpleadoCuenta", parameters, function (error, data) {
            if( data.length == 0){
                return res.sendStatus(204);
            }else{
                return res.json(response(data, error));
            } 
        });
    }
    function registerAccountCliente(req,res){
        var parameters = [];
        parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email });
        parameters.push({ name: 'CPassword', type: TYPES.NVarChar, val: req.body.password });
        parameters.push({ name: 'RecibirInfo', type: TYPES.VarChar, val: req.body.info});
        parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
        parameters.push({ name: 'FechaCumpleannos', type: TYPES.Date, val: req.body.birthdate});
        parameters.push({ name: 'Ubicacion', type: TYPES.VarChar, val: req.body.location});
    
        dbContext.post("RegistrarClienteCuenta", parameters, function (error, data) {
            if( data.length == 0){
                return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
            
    }
        
    

    function updateAccountEmpleado(req,res){
            var parameters = [];

            parameters.push({ name: 'pkEmpleado', type: TYPES.Int, val: req.body.id});
            parameters.push({ name: 'fkTipoEmpleado', type: TYPES.Int, val: req.body.tipoEmpleado});
            parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
            parameters.push({ name: 'FechaContratacion', type: TYPES.Date, val: req.body.date});
            parameters.push({ name: 'Foto', type: TYPES.NVarChar, val: req.body.photo});
            parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email});
            parameters.push({ name: 'EPassword', type: TYPES.NVarChar, val: req.body.password });

            dbContext.post("ActualizarEmpleadoCuenta", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });

    }
        function updateAccountCliente(req,res){
        
            var parameters = [];
            parameters.push({ name: 'idCliente', type: TYPES.Int, val: req.body.id});
            parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
            parameters.push({ name: 'FechaCumpleannos', type: TYPES.Date, val: req.body.birthdate});
            parameters.push({ name: 'Ubicacion', type: TYPES.VarChar, val: req.body.location});
            parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email });
            parameters.push({ name: 'CPassword', type: TYPES.NVarChar, val: req.body.password });
            parameters.push({ name: 'RecibirInfo', type: TYPES.VarChar, val: req.body.info});

            dbContext.post("ActualizarClienteCuenta", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
        }

    return {
        login: loginAccount,
        registerCliente:registerAccountCliente,
        registerEmpleado:registerAccountEmpleado,
        updateCliente:updateAccountCliente,
        updateEmpleado:updateAccountEmpleado
    }

}


module.exports = AccountRepository;