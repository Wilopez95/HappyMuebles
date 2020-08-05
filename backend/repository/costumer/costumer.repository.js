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


    return {
        getInfo:getCostumersInfo
    }

}
module.exports = CostumerRepository;