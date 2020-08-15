const _costumerRepository =  require('./costumer.repository');
const dbContext = require('../../Database/dbContext');


module.exports = function(router){
    const costumerRepository = _costumerRepository(dbContext);

    router.route('/costumer/info/get')
        .post(costumerRepository.getInfo)
    
    router.route('/costumer/coupons/get')
        .post(costumerRepository.getCoupons)

    router.route('/costumer/register')
        .post(costumerRepository.register)    

    router.route('/costumer/update')
        .post(costumerRepository.update)    
}