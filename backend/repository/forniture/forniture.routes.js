const _fornitureRepository =  require('./forniture.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function(router){
    const fornitureRepository = _fornitureRepository(dbContext);

    router.route('/fornitures/:page')
        .get(fornitureRepository.getPage)

    router.route('/fornitures/category/get')
        .get(fornitureRepository.getCategory)

    router.route('/fornitures')
    .get(fornitureRepository.getRandom)

    router.route('/fornitures/description/:id')
    .get(fornitureRepository.getForniture)

    router.route('/fornitures/stock/check')
    .get(fornitureRepository.getStock)

    router.route('/fornitures/sucursales/get')
    .get(fornitureRepository.getSucursales)


   
}