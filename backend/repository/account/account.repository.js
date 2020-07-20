var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function AccountRepository(dbContext){

    function loginAccount(req,res){
        var parameters = [];
        if(req.body.email.includes("Admin/")||req.body.email.includes("admin/")){
            console.log("Login a Admin")
            console.log(req.body.email.substr(6) );
            console.log(req.body.pass);

        }else{
            parameters.push({ name: 'Email', type: TYPES.VarChar, val: req.body.email });
            parameters.push({ name: 'CPassword', type: TYPES.VarChar, val: req.body.pass });

            dbContext.post("ValidarCliente", parameters, function (error, data) {
                if( data.length == 0){
                    return res.sendStatus(204);
                }else{
                    return res.json(response(data, error));
                } 
            });
        }

    }


    return {
        login: loginAccount
    }
    

}


module.exports = AccountRepository;