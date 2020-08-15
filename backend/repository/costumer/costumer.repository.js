var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function CostumerRepository(dbContext){


    function getCostumersInfo(req,res){
            var parameters = [];

            parameters.push({name: 'idCliente', type: TYPES.Int, val: req.body.id})
            var query = "execute @idCliente = @id"

            dbContext.post("obtenerPerfilCliente", parameters, function (error, data) {
                return res.json(response(data, error));
            });
    }

    function getCostumerCoupons(req,res){
            var parameters = [];

            parameters.push({name: 'idCliente', type: TYPES.Int, val: req.body.id});
            dbContext.post("ObtenerCuponesPorCliente", parameters, function (error, data) {
                        return res.json(response(data, error));
                    }); 
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