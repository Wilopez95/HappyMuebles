const _accountRepository =  require('./account.repository');
const dbContext = require('../../Database/dbContext');


module.exports = function(router){
    const accountRepository = _accountRepository(dbContext);

    router.route('/account/login')
        .post(accountRepository.login)
    
}