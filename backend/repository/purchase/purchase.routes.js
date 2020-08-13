const _purchaseRepository =  require('./purchase.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function(router){
    const purchaseRepository = _purchaseRepository(dbContext);

    router.route('/purchase/estado')
        .post(purchaseRepository.register)

    router.route('/purchase/addShoppingList/add')
        .post(purchaseRepository.shopping)
    
    router.route('/purchase/bill')
        .post(purchaseRepository.bill)

    
    router.route('/purchase/billLine')
        .post(purchaseRepository.billLine)  
            
    router.route('/purchase/paymentMethods')
    .get(purchaseRepository.getPayment)  
  
}