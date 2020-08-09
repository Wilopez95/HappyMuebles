const express = require('express'); 

function eRoutes() {
    const router = express.Router();
    var forniture = require('./repository/forniture/forniture.routes')(router);
    var account = require('./repository/account/account.routes')(router);
    var costumer = require('./repository/costumer/costumer.routes')(router);
    var employee = require('./repository/employee/employee.routes')(router);
    return router;
}

module.exports = eRoutes;