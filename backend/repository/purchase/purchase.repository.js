var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function PurchaseRepository(dbContext){

    function registerPurchase(req,res){
        var parameters = [];

            parameters.push({name: 'idEstadoCompra', type: TYPES.Int, val: req.body.estadoCompra})

            dbContext.post("GenerarCompra", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
    }
    function addToShoppingList(req,res){
        var parameters = [];
        parameters.push({ name: 'idProducto', type: TYPES.Int, val: req.body.producto});
        parameters.push({ name: 'idCompra', type: TYPES.Int, val: req.body.compra});
        parameters.push({ name: 'Cantidad', type: TYPES.Int, val: req.body.cantidad});

        dbContext.post("AgregarAListaCompra", parameters, function (error, data) {
            if( data.length == 0){
                return res.sendStatus(204);
            }else{
                return res.json(response(data, error));
            } 
        });
    }
    function billGeneration(req,res){
        var parameters = [];
        parameters.push({ name: 'idMetodoPago', type: TYPES.Int, val: req.body.metodoP});
        parameters.push({ name: 'idCompra', type: TYPES.Int, val: req.body.compra});
        parameters.push({ name: 'MontoTotal', type: TYPES.Money, val: req.body.monto});

        dbContext.post("GenerarFactura", parameters, function (error, data) {
            if( data.length == 0){
                return res.sendStatus(204);
            }else{
                return res.json(response(data, error));
            } 
        });
    }
    function billLineGeneration(req,res){
        var parameters = [];
        parameters.push({ name: 'idFactura', type: TYPES.Int, val: req.body.factura});
        parameters.push({ name: 'Detalle', type: TYPES.NVarChar, val: req.body.detalle});
        parameters.push({ name: 'Monto', type: TYPES.NVarChar, val: req.body.monto});

        dbContext.post("AgregarALineaFactura", parameters, function (error, data) {
            if( data.length == 0){
                return res.sendStatus(204);
            }else{
                return res.json(response(data, error));
            } 
        });
    }
    function getPaymentMethods(req,res){
            var parameters=[];
            dbContext.post("VerMetodosDePago", parameters,function (error, data) {
                return res.json(response(data, error));
            });
        
    }
    function getCalification(req,res){
        var parameters = [];
        parameters.push({ name: 'fkCompra', type: TYPES.Int, val: req.body.id});
        parameters.push({ name: 'EvaluacionServicio', type: TYPES.Int, val: req.body.servicio});
        parameters.push({ name: 'EvaluacionProducto', type: TYPES.Int, val: req.body.producto});
        parameters.push({ name: 'EvaluacionEntrega', type: TYPES.Int, val: req.body.entrega});
        parameters.push({ name: 'Comentario', type: TYPES.NVarChar, val: req.body.comentario});

        dbContext.post("AgregarEvaluacionCompra", parameters, function (error, data) {
            if( data.length == 0){
                return res.sendStatus(204);
            }else{
                return res.json(response(data, error));
            } 
        });

    }



    return {
        register: registerPurchase,
        shopping: addToShoppingList,
        bill: billGeneration,
        billLine: billLineGeneration,
        getPayment: getPaymentMethods,
        getCalification: getCalification
    }

}
module.exports = PurchaseRepository;