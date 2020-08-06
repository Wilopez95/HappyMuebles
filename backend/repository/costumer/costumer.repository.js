var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function CostumerRepository(dbContext){


    function getCostumersInfo(req,res,id){
        if(req.params.id){
            var parameters = [];

            parameters.push({name: 'Id', type: TYPES.Int, val: req.params.id})
            var query = "execute obtenerPerfilCliente @idCliente = @id"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
            
        }
    }

    function getCostumerCoupons(req,res,id){
        if(req.params.id){
            var parameters = [];

            parameters.push({name: 'Id', type: TYPES.Int, val: req.params.id})
            var query = "execute ObtenerCuponesPorCliente @idCliente = @id"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
            
        }
    }


    function registerCostumer(req,res){
        var parameters = [];
            parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
            parameters.push({ name: 'FechaCumpleannos', type: TYPES.Date, val: req.body.birthdate});
            parameters.push({ name: 'Ubicacion', type: TYPES.VarChar, val: req.body.location});

            dbContext.post("RegistrarCliente", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
    }

    function updateCostumer(req,res){
        var parameters = [];
            parameters.push({ name: 'idCliente', type: TYPES.Int, val: req.body.id});
            parameters.push({ name: 'Nombre', type: TYPES.VarChar, val: req.body.name});
            parameters.push({ name: 'FechaCumpleannos', type: TYPES.Date, val: req.body.birthdate});
            parameters.push({ name: 'Ubicacion', type: TYPES.VarChar, val: req.body.location});

            dbContext.post("ActualizarPerfilCliente", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
    }

    return {
        getInfo:getCostumersInfo,
        getCoupons:getCostumerCoupons,
        register:registerCostumer,
        update: updateCostumer
    }

}
module.exports = CostumerRepository;