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




    return {
        getInfo:getProfileCliente,
        getCoupons:getCostumerCoupons
    }

}
module.exports = CostumerRepository;