var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function FornitureRepository(dbContext){

    function getFornitures(req,res){
        
        if (req.params.page) {
            var parameters = [];
            

            parameters.push({ name: 'Page', type: TYPES.Int, val: req.params.page });
            var query = "execute ObtenerMuebles @pagina=@Page"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
        }
    } 

    function getFornituresCategory(req,res,category){
        if(req.params.category){
            var parameters = [];

            parameters.push({name: 'Category', type: TYPES.Int, val: req.params.category})
            var query = "execute ObtenerMueblesCategoria @Categoria = @category"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
            
        }
    }


    return {
        getPage: getFornitures,
        getCategory: getFornituresCategory
    }

}
module.exports = FornitureRepository;