const _costumerRepository =  require('./costumer.repository');
const dbContext = require('../../Database/dbContext');


module.exports = function(router){
    const costumerRepository = _costumerRepository(dbContext);

    router.route('/costumer/info/get/:id')
        .get(costumerRepository.getInfo)
    
    router.route('/costumer/coupons/get')
        .post(costumerRepository.getCoupons)


    router.route('/costumer/update')
        .post(costumerRepository.update)
  
  
}