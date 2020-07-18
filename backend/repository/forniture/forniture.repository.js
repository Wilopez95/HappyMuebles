var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function FornitureRepository(dbContext){

    function getFornitures(req,res){
        dbContext.get("ObteneMueblesAll", function (error, data) {
            return res.json(response(data, error));
        });
    }


    return {
        getAll: getFornitures
    }

}
module.exports = FornitureRepository;