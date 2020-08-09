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

    function registerAccount(req,res){
        var parameters = [];
        if(req.body.tipocuenta.includes("empleado")){
            parameters.push({ name: 'fkEmpleado', type: TYPES.Int, val: req.body.id});
            parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email});
            parameters.push({ name: 'EPassword', type: TYPES.NVarChar, val: req.body.password });

            dbContext.post("RegistrarCuentaEmpleado", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });

        }else{
            parameters.push({ name: 'fkCliente', type: TYPES.Int, val: req.body.id });
            parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email });
            parameters.push({ name: 'CPassword', type: TYPES.NVarChar, val: req.body.password });
            parameters.push({ name: 'RecibirIndo', type: TYPES.VarChar, val: req.body.info});

            dbContext.post("RegistrarCuentaCliente", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
        }
    }

    function updateAccount(req,res){
        var parameters = [];
        if(req.body.tipocuenta.includes("empleado")){
            parameters.push({ name: 'fkEmpleado', type: TYPES.Int, val: req.body.id});
            parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email});
            parameters.push({ name: 'EPassword', type: TYPES.NVarChar, val: req.body.password });

            dbContext.post("ActualizarCuentaEmpleado", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });

        }else{
            parameters.push({ name: 'idCliente', type: TYPES.Int, val: req.body.id });
            parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email });
            parameters.push({ name: 'CPassword', type: TYPES.NVarChar, val: req.body.password });
            parameters.push({ name: 'RecibirInfo', type: TYPES.VarChar, val: req.body.info});

            dbContext.post("ActualizarCuentaCliente", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
        }
    }

    return {
        login: loginAccount,
        register:registerAccount,
        update:updateAccount
    }
    

}


module.exports = AccountRepository;