var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function FornitureRepository(dbContext){

    function getFornitures(req,res,next){
        
        if (req.params.page) {
            var parameters = [];

            parameters.push({ name: 'Page', type: TYPES.Int, val: req.params.page });
            var query = "execute ObtenerMuebles @pagina=@Page"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
        }
    }


    return {
        getPage: getFornitures
    }

}
module.exports = FornitureRepository;