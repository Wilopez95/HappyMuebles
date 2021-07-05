const _accountRepository =  require('./account.repository');
const dbContext = require('../../Database/dbContext');


module.exports = function(router){
    const accountRepository = _accountRepository(dbContext);

    router.route('/account/login')
        .post(accountRepository.login)

    router.route('/account/register/cliente')
        .post(accountRepository.registerCliente)
    
    router.route('/account/register/empleado')
        .post(accountRepository.registerEmpleado)

    router.route('/account/updateCliente')
        .post(accountRepository.updateCliente)

    router.route('/account/updateEmpleado')
        .post(accountRepository.updateEmpleado)

           
}