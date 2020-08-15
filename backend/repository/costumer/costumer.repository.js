var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function CostumerRepository(dbContext){


   
    function getProfileCliente(req,res){
        var parameters = [];
        parameters.push({ name: 'idCliente', type: TYPES.Int, val: req.body.id});
            dbContext.post("obtenerPerfilCliente", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
    }

    function getCostumerCoupons(req,res){
            var parameters = [];

            parameters.push({name: 'idCliente', type: TYPES.Int, val: req.body.id});
            dbContext.post("ObtenerCuponesPorCliente", parameters, function (error, data) {
                        return res.json(response(data, error));
                    }); 
    }




    return {
        getInfo:getProfileCliente,
        getCoupons:getCostumerCoupons
    }

}
module.exports = CostumerRepository;