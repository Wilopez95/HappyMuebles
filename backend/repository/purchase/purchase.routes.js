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
    .post(purchaseRepository.getPayment)  


    router.route('/purchase/calification')
    .post(purchaseRepository.getCalification)

    router.route('/purchase/client/history/:id')
    .get(purchaseRepository.getCHistory)
  
    router.route('/purchase/sucursal/history/:id')
    .get(purchaseRepository.getSHistory)
}