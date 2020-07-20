const express = require('express'); 

function eRoutes() {
    const router = express.Router();
    var forniture = require('./repository/forniture/forniture.routes')(router);
    var account = require('./repository/account/account.routes')(router);
    return router;
}

module.exports = eRoutes;