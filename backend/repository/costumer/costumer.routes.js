const _costumerRepository =  require('./costumer.repository');
const dbContext = require('../../Database/dbContext');


module.exports = function(router){
    const costumerRepository = _costumerRepository(dbContext);

    router.route('/costumer/:id')
        .get(costumerRepository.getInfo)
    
}