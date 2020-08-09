const _employeeRepository =  require('./employee.repository');
const dbContext = require('../../Database/dbContext');


module.exports = function(router){
    const employeeRepository = _employeeRepository(dbContext);

 
    router.route('/employee/register')
        .post(employeeRepository.register)    

    router.route('/employee/update')
        .post(employeeRepository.update)    
}