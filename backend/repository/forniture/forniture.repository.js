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

   /* function getFornituresCategory(req,res,category){
        if(req.params.category){
            var parameters = [];

            parameters.push({name: 'Category', type: TYPES.Int, val: req.params.category})
            var query = "execute ObtenerMueblesCategoria @Categoria = @category"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
            
        }
    }*/


    function getFornituresCategory(req,res,category){
            var parameters = [];

            parameters.push({name: 'Category', type: TYPES.Int, val: req.body.category})
            var query = "execute ObtenerMueblesCategoria @Categoria = @category"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
        
    }
    function getFornituresRandom(req,res){
        if(req,res){
            var parameters =[];
            var query = "execute ObtenerProductosRandom"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
            
        }
    }
    function getFornitureDescription(req,res){
        if (req.params.id) {
            var parameters = [];
            
            parameters.push({ name: 'Id', type: TYPES.Int, val: req.params.id});
            var query = "execute VerProducto @idProducto =@id"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
        }
    }
    function getStockCheck(req,res){
        var parameters = [];
        parameters.push({ name: 'idProducto', type: TYPES.Int, val: req.body.producto});
        parameters.push({ name: 'idSucursal', type: TYPES.Int, val: req.body.sucursal});
        parameters.push({ name: 'Cantidad', type: TYPES.Int, val: req.body.cantidad});

        dbContext.post("ConfirmarStock", parameters, function (error, data) {
            if( data.length == 0){
                return res.sendStatus(204);
            }else{
                return res.json(response(data, error));
            } 
        });
    }
    function getSucursales(req,res){
        var parameters = [];
        var query = "execute VerSucursales"

        dbContext.getQuery(query, parameters, false, function (error, data) {
            return res.json(response(data, error));
        });
    }
 

    return {
        getPage: getFornitures,
        getCategory: getFornituresCategory,
        getRandom: getFornituresRandom,
        getForniture: getFornitureDescription,
        getStock:getStockCheck,
        getSucursales:getSucursales
    }

}
module.exports = FornitureRepository;