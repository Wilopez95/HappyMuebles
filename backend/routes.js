const express = require('express'); 

function eRoutes() {
    const router = express.Router();
    var forniture = require('./repository/forniture/forniture.routes')(router);
    return router;
}

module.exports = eRoutes;