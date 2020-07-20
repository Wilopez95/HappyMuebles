const _fornitureRepository =  require('./forniture.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function(router){
    const fornitureRepository = _fornitureRepository(dbContext);

    router.route('/fornitures/:page')
        .get(fornitureRepository.getPage)

    router.route('/fornitures/category/:category')
        .get(fornitureRepository.getCategory)
}