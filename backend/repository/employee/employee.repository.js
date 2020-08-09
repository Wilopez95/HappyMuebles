var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function EmployeeRepository(dbContext){

    function registerEmployee(req,res){
        var parameters = [];
            parameters.push({ name: 'fkTipoEmpleado', type: TYPES.Int, val: req.body.tipoEmpleado});
            parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
            parameters.push({ name: 'FechaContratacion', type: TYPES.Date, val: req.body.date});
            parameters.push({ name: 'Foto', type: TYPES.NVarChar, val: req.body.photo});

            dbContext.post("RegistrarEmpleado", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
    }
    function updateEmployee(req,res){
        var parameters = [];
        parameters.push({ name: 'pkEmpleado', type: TYPES.Int, val: req.body.id});
        parameters.push({ name: 'fkTipoEmpleado', type: TYPES.Int, val: req.body.tipoEmpleado});
        parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
        parameters.push({ name: 'FechaContratacion', type: TYPES.Date, val: req.body.date});
        parameters.push({ name: 'Foto', type: TYPES.NVarChar, val: req.body.photo});


            dbContext.post("ActualizarPerfilEmpleado", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
    }

 return {
    register: registerEmployee,
    update: updateEmployee
}

}
module.exports = EmployeeRepository;