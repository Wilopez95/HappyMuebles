const _fornitureRepository =  require('./forniture.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function(){
    const fornitureRepository = _fornitureRepository(dbContext);
}