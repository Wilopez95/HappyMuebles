var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function CostumerRepository(dbContext){


   
    function getProfileCliente(req,res){
        if (req.params.id) {
            var parameters = [];
            parameters.push({ name: 'Id', type: TYPES.Int, val: req.params.id});
            var query = "obtenerPerfilCliente @idCliente =@id"
            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
        }
            
    }

    function getCostumerCoupons(req,res){
            var parameters = [];

            parameters.push({name: 'idCliente', type: TYPES.Int, val: req.body.id});
            dbContext.post("ObtenerCuponesPorCliente", parameters, function (error, data) {
                        return res.json(response(data, error));
                    }); 
    }

    function updateProfile(req,res){
        var parameters = [];
        parameters.push({ name: 'idCliente', type: TYPES.NVarChar, val: req.body.pkcliente});
        parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
        parameters.push({ name: 'FechaCumpleannos', type: TYPES.Date, val: req.body.date});
        parameters.push({ name: 'Ubicacion', type: TYPES.VarChar, val: req.body.location});
        parameters.push({ name: 'Email', type: TYPES.NVarChar, val: req.body.email});
        parameters.push({ name: 'CPassword', type: TYPES.NVarChar, val: req.body.password });
        parameters.push({ name: 'RecibirInfo', type: TYPES.NVarChar, val: req.body.info });

        dbContext.post("ActualizarClienteCuenta", parameters, function (error, data) {    
            return res.json(response(data, error));
            
        });
 

    }




    return {
        getInfo:getProfileCliente,
        getCoupons:getCostumerCoupons,
        update:updateProfile
    }

}
module.exports = CostumerRepository;