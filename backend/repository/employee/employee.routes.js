const _employeeRepository =  require('./employee.repository');
const dbContext = require('../../Database/dbContext');


module.exports = function(router){
    const employeeRepository = _employeeRepository(dbContext); 

    router.route('/employee/profile/get')
        .post(employeeRepository.getProfile)  
}